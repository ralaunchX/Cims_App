import 'dart:async';
import 'dart:developer';

import 'package:cims/form_list.dart';
import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/keys.dart';
import 'package:cims/utils/network_info.dart';
import 'package:cims/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RapListScreen extends StatefulWidget {
  const RapListScreen({super.key});

  @override
  State<RapListScreen> createState() => _RapListScreenState();
}

class _RapListScreenState extends State<RapListScreen> {
  List<String> allRapIds = [];
  List<String> filteredRapIds = [];
  final TextEditingController searchController = TextEditingController();
  bool hasInternet = false;
  Stream<bool>? _networkStream;
  StreamSubscription<bool>? _networkSubscription;

  @override
  initState() {
    super.initState();
    final savedValue = AppPrefs().prefs;
    inspect(savedValue);
    loadKeys();

    _networkStream = NetworkInfo().onStatusChange;
    _networkSubscription = _networkStream!.listen((isOnline) {
      setState(() {
        hasInternet = isOnline;
      });
    });
  }

  void filterRapIds(String query) {
    if (query != '') {
      final filtered = allRapIds
          .where((id) => id.toLowerCase().contains(query.toLowerCase()))
          .toList();
      setState(() {
        filteredRapIds = filtered;
      });
    } else {
      setState(() {
        filteredRapIds = allRapIds;
      });
    }
  }

  Future<void> loadKeys() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys().toList();
    keys.remove('rap_id');
    keys.remove(Keys.loginExpiryTimestamp);
    final rapIds = keys.map((key) => key.split('_').first).toSet().toList();
    setState(() {
      allRapIds = rapIds;
      filteredRapIds = allRapIds;
      searchController.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RAP Cases'),
        actions: [
          TextButton.icon(
            onPressed: () async {
              final result = await Navigator.pushNamed(context, '/rapId');
              if (result == true) {
                await loadKeys();
              }
            },
            icon: const Icon(Icons.add, color: Colors.black),
            label: const Text(
              'New Rap Case',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: TextField(
              controller: searchController,
              onChanged: filterRapIds,
              decoration: InputDecoration(
                hintText: 'Search RAP ID',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                isDense: true,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: filteredRapIds.isEmpty
                ? const Center(child: Text('No matching RAP IDs found'))
                : ListView.separated(
                    padding: const EdgeInsets.all(12),
                    itemCount: filteredRapIds.length,
                    itemBuilder: (context, index) {
                      String currentRapId = filteredRapIds[index];
                      return Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                          side:
                              const BorderSide(color: Colors.grey, width: 0.5),
                        ),
                        child: ListTile(
                          tileColor: Colors.blue[200],
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          title: Text(
                            currentRapId,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          trailing: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.arrow_forward_ios, size: 16),
                              PopupMenuButton<String>(
                                icon: const Icon(Icons.more_vert, size: 16),
                                onSelected: (value) async {
                                  if (value == 'download') {
                                    Utility.downloadJson(context, currentRapId);
                                  }
                                },
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 'download',
                                    child: Text('Download'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          onTap: () async {
                            await AppPrefs().setRapId(currentRapId);
                            Keys.rapId = currentRapId;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const FormListScreen()),
                            );
                          },
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
        ),
        child: hasInternet
            ? const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_done, color: Colors.green),
                  SizedBox(width: 8),
                  Text(
                    'Network available, you can sync data',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.wifi_off, color: Colors.red),
                  SizedBox(width: 8),
                  Text(
                    'No Internet Connection',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

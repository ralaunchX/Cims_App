import 'dart:async';

import 'package:cims/utils/api_services.dart';
import 'package:cims/utils/network_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/keys.dart';

class RapIdEntryScreen extends StatefulWidget {
  const RapIdEntryScreen({super.key});

  @override
  State<RapIdEntryScreen> createState() => _RapIdEntryScreenState();
}

class _RapIdEntryScreenState extends State<RapIdEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  String rapId = '';
  String interviewerName = '';
  String entryType = 'Existing'; // default selected
  bool isLoading = false;
  late TextEditingController rapIdController;

  bool hasInternet = false;
  Stream<bool>? _networkStream;
  StreamSubscription<bool>? _networkSubscription;

  @override
  initState() {
    super.initState();
    rapIdController = TextEditingController(text: rapId);
    checkNetwork();
    // rapId = AppPrefs().getRapId() ?? '';
    // interviewerName = AppPrefs().getInterviewerName(rapId) ?? '';
  }

  checkNetwork() async {
    hasInternet = await NetworkInfo().isConnected();
    setState(() {});

    _networkStream = NetworkInfo().onStatusChange;
    _networkSubscription = _networkStream!.listen((online) {
      setState(() => hasInternet = online);
    });
  }

  Future<String> fetchNewRapId() async {
    if (hasInternet == true) {
      var response =
          await ApiServices.createRapId(interviewerName: interviewerName);
      int id = response['case_id'];
      return id.toString();
    } else {
      int timestamp = DateTime.now().millisecondsSinceEpoch % 1000000;
      return 'TEMP$timestamp';
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Enter RAP Details '),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Entry Type'),
                  value: entryType,
                  items: ['Existing', 'New']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        entryType = val;
                        rapIdController.clear();
                        rapId = '';
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: interviewerName,
                  decoration: const InputDecoration(
                    labelText: 'Interviewer Name',
                  ),
                  onChanged: (val) => interviewerName = val,
                  validator: (val) =>
                      val == null || val.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onTap: () async {
                    if (entryType == 'New' &&
                        interviewerName.isNotEmpty == true &&
                        rapId.isEmpty == true) {
                      setState(() {
                        isLoading = true;
                      });

                      final newRapId = await fetchNewRapId();

                      setState(() {
                        rapId = newRapId.trim();
                        rapIdController.text = rapId;
                        isLoading = false;
                      });
                    }
                  },
                  controller: rapIdController,
                  readOnly: entryType == 'New',
                  decoration: const InputDecoration(labelText: 'RAP ID'),
                  onChanged: (val) => rapIdController.text = rapId = val.trim(),
                  validator: (val) =>
                      val == null || val.isEmpty ? 'Required' : null,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                const SizedBox(height: 20),
                // Visibility(
                //   visible: rapId == '' && entryType == 'New',
                //   child: isLoading
                //       ? const CircularProgressIndicator()
                //       : ElevatedButton(
                //           onPressed: () async {
                //             if (interviewerName.isEmpty) {
                //               showDialog(
                //                 context: context,
                //                 builder: (context) => AlertDialog(
                //                   title: const Text('Missing Information'),
                //                   content: const Text(
                //                       'Please enter the interviewer name.'),
                //                   actions: [
                //                     TextButton(
                //                       onPressed: () =>
                //                           Navigator.of(context).pop(),
                //                       child: const Text('OK'),
                //                     ),
                //                   ],
                //                 ),
                //               );
                //               return;
                //             }
                //             setState(() {
                //               isLoading = true;
                //             });

                //             final newRapId = await fetchNewRapId();

                //             setState(() {
                //               rapId = newRapId.trim();
                //               rapIdController.text = rapId;
                //               isLoading = false;
                //             });
                //           },
                //           child: const Text('Generate RapId'),
                //         ),
                // ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await AppPrefs().setRapId(rapId);
                      await AppPrefs()
                          .setInterviewerName(interviewerName, rapId);
                      Keys.rapId = rapId;

                      Navigator.pushReplacementNamed(context, '/formlist',
                          result: true);
                    }
                  },
                  child: const Text('Continue'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> onPop() async {
    Navigator.pop(context, true);
    return true;
  }
}

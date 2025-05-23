import 'package:cims/household_info_screens.dart/llwdsp_householdcomposition_screen.dart';
import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/keys.dart';
import 'package:flutter/material.dart';

class HouseholdList extends StatefulWidget {
  const HouseholdList({super.key});

  @override
  State<HouseholdList> createState() => _HouseholdListState();
}

class _HouseholdListState extends State<HouseholdList> {
  final List<Map<String, dynamic>> householdForms = [
    {
      'title': 'HOUSEHOLD COMPOSITION',
      'widget': const LlwdspHouseholdcompositionScreen(),
      'key': Keys.llwdspHouseholdComposition
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HouseHold Info ${Keys.rapId}')),
      body: ListView.builder(
        itemCount: householdForms.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: ListTile(
              tileColor: AppPrefs().prefs!.containsKey(
                      '${Keys.rapId}_${householdForms[index]['key']}')
                  ? Colors.green
                  : Colors.transparent,
              leading: const Icon(Icons.description),
              title: Text(householdForms[index]['title']),
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => householdForms[index]['widget'],
                  ),
                );
                if (result == true) {
                  setState(() {});
                }
              },
            ),
          );
        },
      ),
    );
  }
}

import 'package:cims/household_info_screens.dart/llwdsp_householdcomposition_screen.dart';
import 'package:cims/household_info_screens.dart/llwdsp_householdeducation_screen.dart';
import 'package:cims/household_info_screens.dart/llwdsp_householdemployment_screen.dart';
import 'package:cims/household_info_screens.dart/llwdsp_skillknowledge_screen.dart';
import 'package:cims/household_info_screens.dart/llwdsp_smallbusiness_screen.dart';
import 'package:cims/household_info_screens.dart/llwdsp_unemployment_screen.dart';
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
    {
      'title': 'EDUCATION',
      'widget': const LlwdspHouseholdEducationScreen(),
      'key': Keys.llwdspHouseholdEducation
    },
    {
      'title': 'EMPLOYMENT',
      'widget': const LlwdspHouseholdEmploymentScreen(),
      'key': Keys.llwdspHouseholdEmployment
    },
    {
      'title': 'UNEMPLOYMENT',
      'widget': const LlwdspHouseholdUnEmploymentScreen(),
      'key': Keys.llwdspHouseholdUnEmployment
    },
    {
      'title': 'Skills and Knowledge',
      'widget': const LlwdspSkillKnowledgeScreen(),
      'key': Keys.llwdspHouseholdSkillKnowledge
    },
    {
      'title': 'SMALL BUSINESS / INCOME GENERATION ACTIVITIES',
      'widget': const LlwdspBusinessScreen(),
      'key': Keys.llwdspHouseholdSmallBusiness
    },
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onPop,
      child: Scaffold(
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
      ),
    );
  }

  Future<bool> onPop() async {
    Navigator.pop(context, true);
    return true;
  }
}

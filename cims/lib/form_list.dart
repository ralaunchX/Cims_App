import 'dart:developer';

import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/keys.dart';
import 'package:flutter/material.dart';

class FormListScreen extends StatefulWidget {
  const FormListScreen({super.key});

  @override
  State<FormListScreen> createState() => _FormListScreenState();
}

class _FormListScreenState extends State<FormListScreen> {
  final forms = [
    {
      'title': '1.1 Asset Registration - HouseHold Information',
      'route': '/assetsHouseHold',
      'key': [Keys.assetsHouseHold]
    },
    {
      'title': '1.2 Asset Registration - Asset Details',
      'route': '/assetDetails',
      'key': [Keys.assetDetails]
    },
    {
      'title': '1.3 Asset Registration - Beneficiary Details',
      'route': '/assetBeneficiary',
      'key': [Keys.assetBeneficiary]
    },
    {
      'title': '1.4 Asset Registration - CoOwner Details',
      'route': '/assetCoowner',
      'key': [Keys.assetCoowner]
    },
    {
      'title': '02 Census Form',
      'route': '/census',
      'key': [Keys.censusHousehold, Keys.censusInstitution]
    },
    {
      'title': '3.1 LLWDSP Phase III Resettlement Action Plan Survey',
      'route': '/llwdspResettlement',
      'key': [Keys.llwdspResettlement]
    },
    {
      'title': '3.2 LLWDSP Phase III Household Info',
      'route': '/houseHold',
      'key': [
        Keys.llwdspHouseholdComposition,
        Keys.llwdspHouseholdEducation,
        Keys.llwdspHouseholdEmployment,
        Keys.llwdspHouseholdUnEmployment,
        Keys.llwdspHouseholdSkillKnowledge,
        Keys.llwdspHouseholdSmallBusiness
      ]
    },
    {
      'title': '3.3 LLWDSP Phase III HOUSEHOLD ASSETS',
      'route': '/llwdspAssets',
      'key': [Keys.llwdspAssets]
    },
    {
      'title': '3.4 LLWDSP Phase III - LIVELIHOOD RESOURCES',
      'route': '/llwdspLivelihood',
      'key': [Keys.llwdspLivelihood]
    },
    {
      'title': '3.5 LLWDSP Phase III - SOCIAL NETWORKS',
      'route': '/llwdspSocialNetwork',
      'key': [Keys.llwdspSocialNetwork]
    },
    {
      'title': '3.6 LLWDSP Phase III - FOOD GARDENS',
      'route': '/llwdspFoodGardens',
      'key': [Keys.llwdspFoodGardens]
    },
    {
      'title': '3.7 LLWDSP Phase III - CROP FIELDS',
      'route': '/llwdspCropField',
      'key': [Keys.llwdspCropField]
    },
    {
      'title': '3.8 LLWDSP Phase III - LIVESTOCK',
      'route': '/llwdspLivestock',
      'key': [Keys.llwdspLivestock]
    },
    {
      'title': '3.9 LLWDSP Phase III - FRUIT TREES',
      'route': '/llwdspFruitTrees',
      'key': [Keys.llwdspFruitTrees]
    },
    {
      'title': '3.10 LLWDSP Phase III - EXPENDITURE',
      'route': '/llwdspExpenditure',
      'key': [Keys.llwdspExpenditure]
    },
    {
      'title': '3.11 LLWDSP Phase III - Transport',
      'route': '/llwdspTransport',
      'key': [Keys.llwdspTransport]
    },
    {
      'title': '3.12 LLWDSP Phase III - FUNDING',
      'route': '/llwdspFunding',
      'key': [Keys.llwdspFunding]
    },
    {
      'title': '3.13 LLWDSP Phase III - FOOD SECURITY',
      'route': '/llwdspFoodForms',
      'key': [
        Keys.llwdspFoodSecurity,
        Keys.llwdspFoodMonthlyStatus,
        Keys.llwdspFoodProductionConsumpion
      ]
    },
    {
      'title': '3.14 LLWDSP Phase III - ENERGY SOURCES',
      'route': '/llwdspEnergySources',
      'key': [Keys.llwdspEnergySources]
    },
    {
      'title': '3.15 LLWDSP Phase III - ADDITIONAL INFO',
      'route': '/llwdspAdditionalInfo',
      'key': [Keys.llwdspAdditionalInfo]
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prefs = AppPrefs().prefs;
    return Scaffold(
      appBar: AppBar(title: Text('Form List ${Keys.rapId}')),
      body: Column(children: [
        Expanded(
          child: ListView.separated(
            itemCount: forms.length,
            itemBuilder: (context, index) {
              final form = forms[index];

              final List<String> keys;
              if (form.containsKey('key')) {
                keys = (form['key'] as List<dynamic>?)?.cast<String>() ?? [];
              } else {
                keys = [];
              }

              final allKeysPresent = keys.isNotEmpty &&
                  prefs != null &&
                  keys.every((k) => prefs.containsKey('${Keys.rapId}_$k'));
              String? title = form['title'] as String?;
              String? route = form['route'] as String?;

              return ListTile(
                tileColor: allKeysPresent ? Colors.green : Colors.transparent,
                leading: const Icon(Icons.description),
                title: Text(title ?? ''),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () async {
                  final result = await Navigator.pushNamed(context, route!);
                  if (result == true) {
                    setState(() {});
                  }
                },
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 5),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
      ]),
    );
  }
}

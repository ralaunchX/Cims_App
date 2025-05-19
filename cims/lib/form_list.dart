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
    {'title': '02 Census Form', 'route': '/census'},
    {
      'title': '3.1 LLWDSP Phase III General Information',
      'route': '/llwdspResettlement',
      'key': Keys.llwdspResettlement
    },
    {
      'title': '3.3 LLWDSP Phase III HOUSEHOLD ASSETS',
      'route': '/llwdspAssets',
      'key': Keys.llwdspAssets
    },
    {
      'title': '3.4 LLWDSP Phase III - LIVELIHOOD RESOURCES',
      'route': '/llwdspLivelihood',
      'key': Keys.llwdspLivelihood
    },
    {
      'title': '3.5 LLWDSP Phase III - SOCIAL NETWORKS',
      'route': '/llwdspSocialNetwork',
      'key': Keys.llwdspSocialNetwork
    },
    {
      'title': '3.6 LLWDSP Phase III - FOOD GARDENS',
      'route': '/llwdspFoodGardens',
      'key': Keys.llwdspFoodGardens
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form List ${Keys.rapId}')),
      body: ListView.builder(
        itemCount: forms.length,
        itemBuilder: (context, index) {
          return ListTile(
            tileColor: AppPrefs()
                    .prefs!
                    .containsKey('${Keys.rapId}_${forms[index]['key']}')
                ? Colors.green
                : Colors.transparent,
            leading: const Icon(Icons.description),
            title: Text(forms[index]['title']!),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () async {
              final result =
                  await Navigator.pushNamed(context, forms[index]['route']!);
              if (result == true) {
                setState(() {});
              }
            },
          );
        },
      ),
    );
  }
}

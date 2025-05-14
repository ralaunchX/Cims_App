import 'dart:developer';

import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/keys.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormListScreen extends StatefulWidget {
  const FormListScreen({super.key});

  @override
  State<FormListScreen> createState() => _FormListScreenState();
}

class _FormListScreenState extends State<FormListScreen> {
  final forms = [
    {'title': '02. Census Form', 'route': '/census'},
    {
      'title': '3.1. LLWDSP Phase III Resettlement Action Plan Survey',
      'route': '/llwdspResettlement'
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
            leading: const Icon(Icons.description),
            title: Text(forms[index]['title']!),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(context, forms[index]['route']!);
            },
          );
        },
      ),
    );
  }
}

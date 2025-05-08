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
    // {'title': 'Asset Form', 'route': '/asset'},
    {'title': 'Census Form', 'route': '/census'},
  ];

  @override
  void initState() {
    super.initState();
    final savedValue = AppPrefs().prefs;
    inspect(savedValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form List')),
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

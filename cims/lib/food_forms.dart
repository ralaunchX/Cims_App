import 'package:cims/llwdsp_foodsecurity_screens.dart';
import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/keys.dart';
import 'package:flutter/material.dart';

class FoodFormsScreen extends StatefulWidget {
  const FoodFormsScreen({super.key});

  @override
  State<FoodFormsScreen> createState() => _FoodFormsScreenState();
}

class _FoodFormsScreenState extends State<FoodFormsScreen> {
  final List<Map<String, dynamic>> foodForms = [
    {
      'title': 'Food Security Details',
      'widget': const LlwdspFoodsecurityScreens(),
      'key': Keys.llwdspFoodSecurity
    },
    {
      'title': 'Monthly Food Status',
      'widget': '',
      'key': '',
    },
    {
      'title': 'Food Production and Consumption Patterns',
      'widget': '',
      'key': '',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Food Security Forms${Keys.rapId}')),
      body: ListView.builder(
        itemCount: foodForms.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: ListTile(
              tileColor: AppPrefs()
                      .prefs!
                      .containsKey('${Keys.rapId}_${foodForms[index]['key']}')
                  ? Colors.green
                  : Colors.transparent,
              leading: const Icon(Icons.description),
              title: Text(foodForms[index]['title']),
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => foodForms[index]['widget'],
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

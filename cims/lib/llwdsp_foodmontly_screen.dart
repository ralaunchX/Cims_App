import 'dart:convert';

import 'package:cims/data_model/llwdsp_foodmonthlystatus_model.dart';
import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/constants.dart';
import 'package:cims/utils/keys.dart';
import 'package:cims/utils/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LlwdspFoodMontlyScreen extends StatefulWidget {
  const LlwdspFoodMontlyScreen({super.key});

  @override
  State<LlwdspFoodMontlyScreen> createState() => _LlwdspFoodmontlyScreenState();
}

class _LlwdspFoodmontlyScreenState extends State<LlwdspFoodMontlyScreen> {
  String rapId = Keys.rapId;
  final String llwdspMonthlyFoodKey =
      '${Keys.rapId}_${Keys.llwdspFoodMonthlyStatus}';
  ListMonthlyFoodDto monthData = ListMonthlyFoodDto(
    rapId: '',
    items: AppConstants.months
        .map((month) => MonthlyFoodDto(
              month: month,
              wasHungry: null,
              hungerReason: 'None',
            ))
        .toList(),
  );

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = AppPrefs().prefs;
    final saved = prefs?.getString(llwdspMonthlyFoodKey);
    if (saved != null) {
      final decoded = jsonDecode(saved);
      final data = ListMonthlyFoodDto.fromJson(decoded);
      setState(() {
        monthData = data;
      });
    }
  }

  Future<void> saveForm() async {
    final data = monthData;
    monthData.rapId = rapId;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(llwdspMonthlyFoodKey, jsonEncode(data.toJson()));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Montlhy Status Info Saved'),
        backgroundColor: Colors.green,
      ),
    );
    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.pop(context, true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Monthly Food Insecurity")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: 1200,
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  color: Colors.blue,
                  padding: const EdgeInsets.all(12),
                  child: const Row(
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text("Month",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                      ),
                      SizedBox(
                        width: 200,
                        child: Text("Was Household Hungry?",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                      ),
                      SizedBox(
                        width: 440,
                        child: Text("Reason for Hunger",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: monthData.items.length,
                  itemBuilder: (context, index) {
                    final month = monthData.items[index].month;
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 200,
                              child: TextFormField(
                                initialValue: month,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Month',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 200,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Radio<bool>(
                                        value: true,
                                        groupValue:
                                            monthData.items[index].wasHungry,
                                        onChanged: (val) => setState(() =>
                                            monthData.items[index].wasHungry =
                                                val),
                                      ),
                                      const Text("Yes"),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Radio<bool>(
                                        value: false,
                                        groupValue:
                                            monthData.items[index].wasHungry,
                                        onChanged: (val) => setState(() =>
                                            monthData.items[index].wasHungry =
                                                val),
                                      ),
                                      const Text("No"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 440,
                              child: DropdownButtonFormField<String>(
                                value: monthData.items[index].hungerReason,
                                items: AppConstants.hungerReasons.map((reason) {
                                  return DropdownMenuItem(
                                    value: reason,
                                    child: Text(reason),
                                  );
                                }).toList(),
                                onChanged: (value) => setState(() => monthData
                                    .items[index].hungerReason = value),
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder()),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              CommonSubmitButton(onPressed: saveForm)
            ],
          ),
        ),
      ),
    );
  }
}

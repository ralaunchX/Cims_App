import 'dart:convert';

import 'package:cims/data_model/llwdsp_foodgardens_model.dart';
import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/constants.dart';
import 'package:cims/utils/keys.dart';
import 'package:cims/utils/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LlwdspFoodgardensScreen extends StatefulWidget {
  final LlwdspFoodgardensModel? llwdspFoodgardensModel;

  const LlwdspFoodgardensScreen({super.key, this.llwdspFoodgardensModel});

  @override
  State<LlwdspFoodgardensScreen> createState() =>
      _LlwdspFoodgardensScreenState();
}

class _LlwdspFoodgardensScreenState extends State<LlwdspFoodgardensScreen> {
  final _formKey = GlobalKey<FormState>();
  String rapId = Keys.rapId;
  String llwdspFoodGardenKey = '${Keys.rapId}_${Keys.llwdspFoodGardens}';

  List<String> cropsGrown = [];
  List<String> cropsHarvested = [];

  String gardenChoice = AppConstants.notSelected;
  String cropUse = AppConstants.notSelected;
  String irrigationMethod = AppConstants.notSelected;
  String fertilizerType = AppConstants.notSelected;

  @override
  void initState() {
    super.initState();
    final prefs = AppPrefs().prefs;
    var foodGardenData = widget.llwdspFoodgardensModel;
    String? foodGardenString = prefs?.getString(llwdspFoodGardenKey);
    if (foodGardenString != null) {
      final json = jsonDecode(foodGardenString);
      foodGardenData = LlwdspFoodgardensModel.fromJson(json);
    }
    if (foodGardenData != null) {
      cropsGrown = foodGardenData.cropsGrown;
      cropsHarvested = foodGardenData.cropsHarvested;
      gardenChoice = foodGardenData.gardenChoice;

      cropUse = foodGardenData.cropUse;
      irrigationMethod = foodGardenData.irrigationMethod;
      fertilizerType = foodGardenData.fertilizerType;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Food Gardens Survey')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Q.19 Does the household have any food garden at the homestead or elsewhere?',
                style: TextStyle(fontSize: 16),
              ),
              DropdownButtonFormField<String>(
                items: AppConstants.foodGardenChoice
                    .map((method) =>
                        DropdownMenuItem(value: method, child: Text(method)))
                    .toList(),
                value: gardenChoice,
                isExpanded: true,
                onChanged: (val) => setState(() => gardenChoice = val!),
                validator: (val) {
                  if (val == null || val == AppConstants.notSelected) {
                    return 'Please Select a Response';
                  }
                  return null;
                },
              ),
              if (gardenChoice != AppConstants.notSelected &&
                  gardenChoice != 'Don\'t have a food garden') ...[
                const SizedBox(height: 16),
                const Text('Crops Grown',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                ...AppConstants.cropGrownHarvested
                    .map((crop) => CheckboxListTile(
                          title: Text(crop),
                          controlAffinity: ListTileControlAffinity.leading,
                          dense: true,
                          visualDensity: VisualDensity.compact,
                          value: cropsGrown.contains(crop),
                          onChanged: (selected) {
                            setState(() {
                              if (selected == true) {
                                cropsGrown.add(crop);
                              } else {
                                cropsGrown.remove(crop);
                              }
                            });
                          },
                        )),
                const SizedBox(height: 16),
                const Text('Crops Harvested',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                ...AppConstants.cropGrownHarvested
                    .map((crop) => CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(crop),
                          dense: true,
                          visualDensity: VisualDensity.compact,
                          value: cropsHarvested.contains(crop),
                          onChanged: (selected) {
                            setState(() {
                              if (selected == true) {
                                cropsHarvested.add(crop);
                              } else {
                                cropsHarvested.remove(crop);
                              }
                            });
                          },
                        )),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Crop Use'),
                  isExpanded: true,
                  items: AppConstants.cropUseChoices
                      .map((use) =>
                          DropdownMenuItem(value: use, child: Text(use)))
                      .toList(),
                  value: cropUse,
                  validator: (val) {
                    if (val == null || val == AppConstants.notSelected) {
                      return 'Please Select a Response';
                    }
                    return null;
                  },
                  onChanged: (val) => setState(() => cropUse = val!),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration:
                      const InputDecoration(labelText: 'Irrigation Method'),
                  isExpanded: true,
                  items: AppConstants.irrigationMethods
                      .map((method) =>
                          DropdownMenuItem(value: method, child: Text(method)))
                      .toList(),
                  value: irrigationMethod,
                  validator: (val) {
                    if (val == null || val == AppConstants.notSelected) {
                      return 'Please Select a Response';
                    }
                    return null;
                  },
                  onChanged: (val) => setState(() => irrigationMethod = val!),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration:
                      const InputDecoration(labelText: 'Fertilizer Type'),
                  isExpanded: true,
                  items: AppConstants.fertilizationChoices
                      .map((fertilizer) => DropdownMenuItem(
                          value: fertilizer, child: Text(fertilizer)))
                      .toList(),
                  value: fertilizerType,
                  validator: (val) {
                    if (val == null || val == AppConstants.notSelected) {
                      return 'Please Select a Response';
                    }
                    return null;
                  },
                  onChanged: (val) => setState(() => fertilizerType = val!),
                ),
              ],
              const SizedBox(height: 24),
              CommonSubmitButton(onPressed: () {
                saveForm();
              })
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveForm() async {
    if (_formKey.currentState!.validate()) {
      final llwdspFoodgardensData = LlwdspFoodgardensModel(
          cropsGrown: cropsGrown,
          cropsHarvested: cropsHarvested,
          gardenChoice: gardenChoice,
          cropUse: cropUse,
          irrigationMethod: irrigationMethod,
          fertilizerType: fertilizerType);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          llwdspFoodGardenKey, jsonEncode(llwdspFoodgardensData.toJson()));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Food Gardens Survey Form Submitted'),
            backgroundColor: Colors.green),
      );
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pop(context, true);
      });
    }
  }
}

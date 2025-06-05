import 'dart:convert';

import 'package:cims/data_model/llwdsp_foodconsumptionproduction_model.dart';
import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/constants.dart';
import 'package:cims/utils/keys.dart';
import 'package:cims/utils/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LlwdspFoodproductionconsumption extends StatefulWidget {
  const LlwdspFoodproductionconsumption({super.key});

  @override
  State<LlwdspFoodproductionconsumption> createState() =>
      _LlwdspFoodproductionconsumptionState();
}

class _LlwdspFoodproductionconsumptionState
    extends State<LlwdspFoodproductionconsumption> {
  String rapId = Keys.rapId;
  final String foodProductionConsumptionKey =
      '${Keys.rapId}_${Keys.llwdspFoodProductionConsumpion}';

  List<String> selectedStapleMonths = [];
  String? stapleStorage;
  String? sideDishSource;
  List<String> selectedSideDishMonths = [];

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = AppPrefs().prefs;
    final saved = prefs?.getString(foodProductionConsumptionKey);
    if (saved != null) {
      final decoded = jsonDecode(saved);
      final data = FoodProductionConsumptionDto.fromJson(decoded);
      setState(() {
        selectedStapleMonths = data.selectedStapleMonths;
        stapleStorage = data.stapleStorage;
        sideDishSource = data.sideDishSource;
        selectedSideDishMonths = data.selectedSideDishMonths;
      });
    }
  }

  void toggleMonthSelection(List<String> list, String month) {
    setState(() {
      if (list.contains(month)) {
        list.remove(month);
      } else {
        list.add(month);
      }
    });
  }

  Future<void> submitForm() async {
    final data = FoodProductionConsumptionDto(
        rapId: rapId,
        selectedStapleMonths: selectedStapleMonths,
        selectedSideDishMonths: selectedSideDishMonths,
        sideDishSource: sideDishSource,
        stapleStorage: stapleStorage);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        foodProductionConsumptionKey, jsonEncode(data.toJson()));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Food Info Saved'),
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
      appBar: AppBar(title: const Text('Food Production & Consumption')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(
                "If the staple is sometimes self-produced, during which months do they usually consume their own staple?"),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: AppConstants.months.map((month) {
                return FilterChip(
                  label: Text(month),
                  selected: selectedStapleMonths.contains(month),
                  onSelected: (_) =>
                      toggleMonthSelection(selectedStapleMonths, month),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle(
                "If the household’s staple is SOMETIMES self-produced, HOW is it stored?"),
            ...AppConstants.stapleStorageOptions.map((option) {
              return RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: stapleStorage,
                onChanged: (value) => setState(() => stapleStorage = value),
              );
            }),
            const SizedBox(height: 24),
            _buildSectionTitle(
                "Apart from the staple this Household consumes, is the side-dish mostly self-produced or mostly bought food?"),
            ...AppConstants.sideDishSourceOptions.map((option) {
              return RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: sideDishSource,
                onChanged: (value) => setState(() => sideDishSource = value),
              );
            }),
            const SizedBox(height: 24),
            _buildSectionTitle(
                "If the side-dish is mostly self-produced, during which months do they consume their own produce as side-dish?"),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: [
                ...AppConstants.months.map((month) {
                  return FilterChip(
                    label: Text(month),
                    selected: selectedSideDishMonths.contains(month),
                    onSelected: (_) =>
                        toggleMonthSelection(selectedSideDishMonths, month),
                  );
                }).toList(),
                FilterChip(
                  label: const Text("Never"),
                  selected: selectedSideDishMonths.contains("Never"),
                  onSelected: (_) {
                    setState(() {
                      selectedSideDishMonths.contains("Never")
                          ? selectedSideDishMonths.remove("Never")
                          : selectedSideDishMonths.add("Never");
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            CommonSubmitButton(onPressed: submitForm)
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

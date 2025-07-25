import 'dart:convert';
import 'package:cims/data_model/food_security_model.dart';
import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/constants.dart';
import 'package:cims/utils/keys.dart';
import 'package:cims/utils/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LlwdspFoodsecurityScreens extends StatefulWidget {
  const LlwdspFoodsecurityScreens({super.key});

  @override
  State<LlwdspFoodsecurityScreens> createState() =>
      _LlwdspFoodsecurityScreensState();
}

class _LlwdspFoodsecurityScreensState extends State<LlwdspFoodsecurityScreens> {
  final _formKey = GlobalKey<FormState>();
  final String rapId = Keys.rapId;
  final String llwdspFoodSecurityKey =
      '${Keys.rapId}_${Keys.llwdspFoodSecurity}';
  bool? foodShortage = false;
  String? selectedStapleFood = AppConstants.notSelected;
  String? selectedStapleSource = AppConstants.notSelected;

  @override
  void initState() {
    super.initState();
    loadSavedData();
  }

  Future<void> loadSavedData() async {
    final prefs = AppPrefs().prefs;
    final jsonString = prefs?.getString(llwdspFoodSecurityKey);
    if (jsonString != null) {
      final dto = FoodSecurityDto.fromJson(jsonDecode(jsonString));
      setState(() {
        foodShortage = dto.foodShortageLastYear;
        selectedStapleFood = dto.primaryStapleFood;
        selectedStapleSource = dto.stapleFoodSource;
      });
    }
  }

  Future<void> submitForm() async {
    if (_formKey.currentState!.validate()) {
      final dto = FoodSecurityDto(
        rapId: rapId,
        foodShortageLastYear: foodShortage,
        primaryStapleFood: selectedStapleFood,
        stapleFoodSource: selectedStapleSource,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(llwdspFoodSecurityKey, jsonEncode(dto.toJson()));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Food Security Information Saved"),
          backgroundColor: Colors.green,
        ),
      );
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pop(context, true);
      });
    }
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> options,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          hint: const Text("Select"),
          items: options
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
          validator: (val) => val == null || val == AppConstants.notSelected
              ? 'Required'
              : null,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Food Security Details")),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              const Text(
                "Was there a shortage of food in the household at any time last year?",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<bool>(
                      title: const Text("Yes"),
                      value: true,
                      groupValue: foodShortage,
                      onChanged: (val) => setState(() => foodShortage = val),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<bool>(
                      title: const Text("No"),
                      value: false,
                      groupValue: foodShortage,
                      onChanged: (val) => setState(() => foodShortage = val),
                    ),
                  ),
                ],
              ),
              _buildDropdown(
                label: "Household's primary staple food",
                value: selectedStapleFood,
                options: AppConstants.stapleFoodOptions,
                onChanged: (val) => setState(() => selectedStapleFood = val),
              ),
              _buildDropdown(
                label: "Source of staple food",
                value: selectedStapleSource,
                options: AppConstants.sourceOptions,
                onChanged: (val) => setState(() => selectedStapleSource = val),
              ),
              const SizedBox(height: 32),
              CommonSubmitButton(onPressed: submitForm)
            ],
          ),
        ),
      ),
    );
  }
}

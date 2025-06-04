import 'dart:convert';

import 'package:cims/data_model/llwdsp_livelihood_model.dart';
import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/constants.dart';
import 'package:cims/utils/keys.dart';
import 'package:cims/utils/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LlwdspLivelihood extends StatefulWidget {
  final LlwdspLivelihoodModel? livelihoodModel;
  const LlwdspLivelihood({super.key, this.livelihoodModel});

  @override
  State<LlwdspLivelihood> createState() => _LlwdspLivelihoodState();
}

class _LlwdspLivelihoodState extends State<LlwdspLivelihood> {
  String rapId = Keys.rapId;
  String llwdspLivelihoodKey = '${Keys.rapId}_${Keys.llwdspLivelihood}';

  String primaryLivelihood = AppConstants.notSelected;
  String secondaryLivelihood = AppConstants.notSelected;
  List<String> regularIncomeSources = [];
  final TextEditingController otherRegularIncome = TextEditingController();
  List<String> lastMonthIncomeSources = [];
  final TextEditingController otherLastMonthIncome = TextEditingController();
  List<String> grantsReceived = [];

  @override
  void initState() {
    super.initState();
    final prefs = AppPrefs().prefs;
    var livelihoodData = widget.livelihoodModel;
    String? livelihoodString = prefs?.getString(llwdspLivelihoodKey);
    if (livelihoodString != null) {
      final json = jsonDecode(livelihoodString);
      livelihoodData = LlwdspLivelihoodModel.fromJson(json);
    }
    if (livelihoodData != null) {
      primaryLivelihood = livelihoodData.primaryLivelihood;
      secondaryLivelihood = livelihoodData.secondaryLivelihood;
      regularIncomeSources = livelihoodData.regularIncomeSources;
      otherRegularIncome.text = livelihoodData.otherRegularIncome;
      lastMonthIncomeSources = livelihoodData.lastMonthIncomeSources;
      otherLastMonthIncome.text = livelihoodData.otherLastMonthIncome;
      grantsReceived = livelihoodData.grantsReceived;
    }
  }

  @override
  void dispose() {
    otherRegularIncome.dispose();
    otherLastMonthIncome.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LLWDSP Livelihood')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
                child: Text(
              'Primary and Secondary Livelihood',
              style: TextStyle(fontSize: 20),
            )),
            DropdownButtonFormField<String>(
              isExpanded: true,
              value: primaryLivelihood,
              decoration: const InputDecoration(
                labelText: 'Primary Livelihood',
              ),
              items: AppConstants.livelihoodTypes
                  .map((option) => DropdownMenuItem(
                        value: option,
                        child: Text(option),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() => primaryLivelihood = value!);
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              isExpanded: true,
              value: secondaryLivelihood,
              decoration: const InputDecoration(
                labelText: 'Secondary Livelihood',
              ),
              items: AppConstants.livelihoodTypes
                  .map((option) => DropdownMenuItem(
                        value: option,
                        child: Text(option),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() => secondaryLivelihood = value!);
              },
            ),
            const SizedBox(height: 24),
            const Center(
              child: Text('Sources of Income (Check all that apply)',
                  style: TextStyle(fontSize: 20)),
            ),
            const SizedBox(height: 24),
            _buildMultiSelect(
              'Regularly:',
              AppConstants.incomeSources,
              regularIncomeSources,
            ),
            TextFormField(
              controller: otherRegularIncome,
              decoration: const InputDecoration(labelText: 'Please specify'),
            ),
            const SizedBox(height: 24),
            _buildMultiSelect(
              'Last Month:',
              AppConstants.incomeSources,
              lastMonthIncomeSources,
            ),
            TextFormField(
              controller: otherLastMonthIncome,
              decoration: const InputDecoration(labelText: 'Please specify'),
            ),
            const SizedBox(height: 24),
            _buildMultiSelect(
              'Grants Received',
              AppConstants.grantList,
              lastMonthIncomeSources,
            ),
            const SizedBox(height: 24),
            CommonSubmitButton(onPressed: () {
              saveForm();
            })
          ],
        ),
      ),
    );
  }

  Widget _buildMultiSelect(
      String title, List<String> options, List<String> selectedList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...options.map((option) {
          return CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            visualDensity: VisualDensity.compact,
            title: Text(option, style: const TextStyle(fontSize: 16)),
            controlAffinity: ListTileControlAffinity.leading,
            value: selectedList.contains(option),
            onChanged: (isSelected) {
              setState(() {
                if (isSelected == true) {
                  selectedList.add(option);
                } else {
                  selectedList.remove(option);
                }
              });
            },
          );
        }).toList(),
      ],
    );
  }

  Future<void> saveForm() async {
    if (primaryLivelihood == AppConstants.notSelected ||
        secondaryLivelihood == AppConstants.notSelected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please answer all Livelihood DropDown questions.'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      final llwdspLivelihoodData = LlwdspLivelihoodModel(
          caseId: rapId,
          primaryLivelihood: primaryLivelihood,
          secondaryLivelihood: secondaryLivelihood,
          regularIncomeSources: regularIncomeSources,
          otherRegularIncome: otherRegularIncome.text,
          lastMonthIncomeSources: lastMonthIncomeSources,
          otherLastMonthIncome: otherLastMonthIncome.text,
          grantsReceived: grantsReceived);

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString(
          llwdspLivelihoodKey, jsonEncode(llwdspLivelihoodData.toJson()));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Livelihood Form Submitted'),
            backgroundColor: Colors.green),
      );

      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pop(context, true);
      });
    }
  }
}

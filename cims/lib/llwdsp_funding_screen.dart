import 'dart:convert';

import 'package:cims/data_model/llwdsp_funding_model.dart';
import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/constants.dart';
import 'package:cims/utils/keys.dart';
import 'package:cims/utils/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LlwdspFundingScreen extends StatefulWidget {
  final LLwdspListFunding? lLwdspListFunding;
  const LlwdspFundingScreen({super.key, this.lLwdspListFunding});

  @override
  State<LlwdspFundingScreen> createState() => _LlwdspFundingScreenState();
}

class _LlwdspFundingScreenState extends State<LlwdspFundingScreen> {
  String rapId = Keys.rapId;
  String llwdspFundingKey = '${Keys.rapId}_${Keys.llwdspFunding}';
  List<FundingClubData> fundingRows = [
    FundingClubData(
        memberReference: '',
        typeOfGroup: AppConstants.notSelected,
        contributionFrequency: AppConstants.notSelected,
        receiptFrequency: AppConstants.notSelected,
        sourceOfIncome: AppConstants.notSelected,
        contributionToLivelihood: AppConstants.notSelected)
  ];
  final _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    final prefs = AppPrefs().prefs;
    var fundingList = widget.lLwdspListFunding;
    String? fundingString = prefs?.getString(llwdspFundingKey);
    if (fundingString != null) {
      final json = jsonDecode(fundingString);
      fundingList = LLwdspListFunding.fromJson(json);
    }
    if (fundingList != null) {
      fundingRows = fundingList.fundingData;
    }
  }

  void addRow() {
    setState(() => fundingRows.add(FundingClubData(
        memberReference: '',
        typeOfGroup: AppConstants.notSelected,
        contributionFrequency: AppConstants.notSelected,
        receiptFrequency: AppConstants.notSelected,
        sourceOfIncome: AppConstants.notSelected,
        contributionToLivelihood: AppConstants.notSelected)));
  }

  void removeRow(int index) {
    setState(() => fundingRows.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Saving Club/Society Details")),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(16),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: const Row(
                            children: [
                              _HeaderCell('Household Member Reference'),
                              _HeaderCell('Type of Group'),
                              _HeaderCell('Contribution Frequency'),
                              _HeaderCell('Receipt Frequency'),
                              _HeaderCell('Source of Income'),
                              _HeaderCell('Contribution to Livelihood'),
                              _HeaderCell('Action'),
                            ],
                          ),
                        ),
                        Column(
                          children: fundingRows.asMap().entries.map((entry) {
                            final index = entry.key;
                            final row = entry.value;
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                children: [
                                  _TextFieldCell(
                                    initialValue: row.memberReference,
                                    onChanged: (val) =>
                                        row.memberReference = val,
                                  ),
                                  _DropdownCell(
                                    value: row.typeOfGroup,
                                    items: AppConstants.fundingGroupChoices,
                                    onChanged: (val) =>
                                        setState(() => row.typeOfGroup = val!),
                                  ),
                                  _DropdownCell(
                                    value: row.contributionFrequency,
                                    items: AppConstants.fundingFrequencyChoices,
                                    onChanged: (val) => setState(
                                        () => row.contributionFrequency = val!),
                                  ),
                                  _DropdownCell(
                                    value: row.receiptFrequency,
                                    items: AppConstants.fundingFrequencyChoices,
                                    onChanged: (val) => setState(
                                        () => row.receiptFrequency = val!),
                                  ),
                                  _DropdownCell(
                                    value: row.sourceOfIncome,
                                    items:
                                        AppConstants.fundingIncomeSourceChoices,
                                    onChanged: (val) => setState(
                                        () => row.sourceOfIncome = val!),
                                  ),
                                  _DropdownCell(
                                    value: row.contributionToLivelihood,
                                    items: AppConstants
                                        .fundingLivelihoodContributionChoices,
                                    onChanged: (val) => setState(() =>
                                        row.contributionToLivelihood = val!),
                                  ),
                                  SizedBox(
                                    width: 180,
                                    child: Center(
                                      child: TextButton(
                                        onPressed: () => removeRow(index),
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        child: const Text(
                                          "Remove",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  onPressed: addRow,
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text("Add Row",
                      style: TextStyle(color: Colors.white)),
                  style: TextButton.styleFrom(backgroundColor: Colors.green),
                ),
                CommonSubmitButton(onPressed: () {
                  saveForm();
                })
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> saveForm() async {
    if (_formKey.currentState!.validate()) {
      final llwdspFundingData =
          LLwdspListFunding(rapId: rapId, fundingData: fundingRows);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          llwdspFundingKey, jsonEncode(llwdspFundingData.toJson()));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Funding Form Submitted'),
            backgroundColor: Colors.green),
      );
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pop(context, true);
      });
    }
  }
}

class _HeaderCell extends StatelessWidget {
  final String label;
  const _HeaderCell(this.label);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _TextFieldCell extends StatelessWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;

  const _TextFieldCell({required this.initialValue, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: TextFormField(
        initialValue: initialValue,
        onChanged: onChanged,
        decoration: const InputDecoration(),
        validator: (val) =>
            val == null || val.isEmpty || val == '' ? 'Required' : null,
      ),
    );
  }
}

class _DropdownCell extends StatelessWidget {
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _DropdownCell(
      {this.value, required this.items, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        value: value,
        items: items
            .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
        decoration: const InputDecoration(),
        validator: (val) =>
            val == null || val == AppConstants.notSelected ? 'Select' : null,
      ),
    );
  }
}

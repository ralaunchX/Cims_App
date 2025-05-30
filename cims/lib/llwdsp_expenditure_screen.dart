import 'dart:convert';

import 'package:cims/data_model/llwdsp_expenditure_model.dart';
import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/constants.dart';
import 'package:cims/utils/keys.dart';
import 'package:cims/utils/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LlwdspExpenditureScreen extends StatefulWidget {
  final LlwdspExpenditureList? llwdspExpenditureList;
  const LlwdspExpenditureScreen({super.key, this.llwdspExpenditureList});

  @override
  State<LlwdspExpenditureScreen> createState() =>
      _LlwdspExpenditureScreenState();
}

class _LlwdspExpenditureScreenState extends State<LlwdspExpenditureScreen> {
  final _formKey = GlobalKey<FormState>();
  String rapId = Keys.rapId;
  String llwdspExpenditureKey = '${Keys.rapId}_${Keys.llwdspExpenditure}';
  List<ExpenditureDto> expenditureList = [
    ExpenditureDto(
        frequency: AppConstants.notSelected, item: AppConstants.notSelected),
  ];

  @override
  void initState() {
    super.initState();
    final prefs = AppPrefs().prefs;
    var llwdspExpenditureList = widget.llwdspExpenditureList;
    String? llwdspExpenditureString = prefs?.getString(llwdspExpenditureKey);
    if (llwdspExpenditureString != null) {
      final json = jsonDecode(llwdspExpenditureString);
      llwdspExpenditureList = LlwdspExpenditureList.fromJson(json);
    }
    if (llwdspExpenditureList != null) {
      expenditureList = llwdspExpenditureList.expenditureList;
    }
  }

  void _addRow() {
    setState(() => expenditureList.add(ExpenditureDto(
        frequency: AppConstants.notSelected, item: AppConstants.notSelected)));
  }

  void _removeRow(int index) {
    setState(() => expenditureList.removeAt(index));
  }

  Widget _buildRow(ExpenditureDto data, int index) {
    return Row(
      children: [
        SizedBox(
          width: 300,
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            ),
            value: data.item.isEmpty ? null : data.item,
            items: AppConstants.expenditureItems
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
            onChanged: (val) => setState(() => data.item = val ?? ''),
            validator: (val) => val == null || val == AppConstants.notSelected
                ? 'Required'
                : null,
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 300,
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            ),
            value: data.frequency.isEmpty ? null : data.frequency,
            items: AppConstants.frequencyOptionsExpenditure
                .map((f) => DropdownMenuItem(value: f, child: Text(f)))
                .toList(),
            onChanged: (val) => setState(() => data.frequency = val ?? ''),
            validator: (val) => val == null || val == AppConstants.notSelected
                ? 'Required'
                : null,
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 180,
          child: Row(
            children: [
              Radio<bool>(
                value: true,
                groupValue: data.occurredLastMonth,
                onChanged: (val) =>
                    setState(() => data.occurredLastMonth = val!),
              ),
              const Text('Yes'),
              Radio<bool>(
                value: false,
                groupValue: data.occurredLastMonth,
                onChanged: (val) =>
                    setState(() => data.occurredLastMonth = val!),
              ),
              const Text('No'),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => _removeRow(index),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LLWDSP Phase III - EXPENDITURE')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                "Expenditure",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: 950,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: const Row(
                            children: [
                              SizedBox(
                                width: 300,
                                child: Text(
                                  'Expenditure Item',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                width: 300,
                                child: Text(
                                  'Frequency',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                width: 220,
                                child: Text(
                                  'Occurred Last Month?',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                child: Text(
                                  'Remove',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: expenditureList.length,
                            itemBuilder: (context, index) =>
                                _buildRow(expenditureList[index], index),
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: _addRow,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Row'),
                  ),
                  const SizedBox(width: 20),
                  CommonSubmitButton(onPressed: _saveForm)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveForm() async {
    if (_formKey.currentState!.validate()) {
      final llwdspExpenditureData =
          LlwdspExpenditureList(rapId: rapId, expenditureList: expenditureList);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          llwdspExpenditureKey, jsonEncode(llwdspExpenditureData.toJson()));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Expenditure Form Submitted'),
            backgroundColor: Colors.green),
      );
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pop(context, true);
      });
    }
  }
}

import 'dart:convert';

import 'package:cims/data_model/llwdsp_unemployment_model.dart';
import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/constants.dart';
import 'package:cims/utils/keys.dart';
import 'package:cims/utils/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

class LlwdspHouseholdUnEmploymentScreen extends StatefulWidget {
  final ListUnEmploymentInfo? listUnEmploymentInfo;
  const LlwdspHouseholdUnEmploymentScreen(
      {super.key, this.listUnEmploymentInfo});

  @override
  State<LlwdspHouseholdUnEmploymentScreen> createState() =>
      _UnemploymentScreenState();
}

class _UnemploymentScreenState
    extends State<LlwdspHouseholdUnEmploymentScreen> {
  final _formKey = GlobalKey<FormState>();
  String rapId = Keys.rapId;
  final String unEmploymentKey =
      '${Keys.rapId}_${Keys.llwdspHouseholdUnEmployment}';

  List<UnemploymentInfo> unemploymentList = [
    UnemploymentInfo(
        refNo: '',
        reasonForUnemployment: AppConstants.notSelected,
        yearsOfUnemployment: '0')
  ];
  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = AppPrefs().prefs;
    final saved = prefs?.getString(unEmploymentKey);
    if (saved != null) {
      final decoded = jsonDecode(saved);
      final data = ListUnEmploymentInfo.fromJson(decoded);
      setState(() {
        unemploymentList = data.unEmploymentInfoList;
      });
    }
  }

  void _addRow() {
    setState(() {
      unemploymentList.add(UnemploymentInfo(
          refNo: '',
          reasonForUnemployment: AppConstants.notSelected,
          yearsOfUnemployment: '0'));
    });
  }

  void _removeRow(int index) {
    setState(() {
      unemploymentList.removeAt(index);
    });
  }

  Widget _textField({
    required String value,
    required String hint,
    required double width,
    required Function(String) onChanged,
    bool isNumber = false,
  }) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: TextFormField(
          initialValue: value,
          onChanged: onChanged,
          keyboardType: isNumber ? TextInputType.number : null,
          validator: (val) => val!.isEmpty || val == '' ? 'Required' : null,
          decoration: InputDecoration(hintText: hint),
        ),
      ),
    );
  }

  Widget _dropdownField({
    required String value,
    required List<String> items,
    required double width,
    required String hint,
    required Function(String) onChanged,
  }) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: DropdownButtonFormField<String>(
          isExpanded: true,
          value: value.isEmpty ? null : value,
          onChanged: (val) => onChanged(val!),
          validator: (val) => val == null || val == AppConstants.notSelected
              ? 'Required'
              : null,
          decoration: InputDecoration(hintText: hint),
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildRow(int index) {
    final info = unemploymentList[index];
    return Row(
      children: [
        _textField(
          value: info.refNo,
          hint: 'Ref No.',
          width: 100,
          onChanged: (val) => info.refNo = val,
        ),
        _dropdownField(
          value: info.reasonForUnemployment,
          items: AppConstants.unemploymentReasonChoices,
          width: 500,
          hint: 'Reason for Unemployment',
          onChanged: (val) => setState(() => info.reasonForUnemployment = val),
        ),
        _textField(
          value: info.yearsOfUnemployment,
          hint: 'Years',
          width: 100,
          onChanged: (val) => info.yearsOfUnemployment = val,
          isNumber: true,
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 150,
          child: ElevatedButton(
            onPressed: () => _removeRow(index),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Remove", style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.blue,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: const Row(
        children: [
          _HeaderCell('Ref No.', width: 100),
          _HeaderCell('Reason for Unemployment', width: 500),
          _HeaderCell('Years of Unemployment', width: 100),
          SizedBox(width: 100),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Household Unemployment")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: 900,
                    child: Column(
                      children: [
                        _buildHeader(),
                        const Divider(height: 0),
                        Expanded(
                          child: ListView.separated(
                            itemCount: unemploymentList.length,
                            itemBuilder: (_, i) => _buildRow(i),
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _addRow,
                    icon: const Icon(Icons.add),
                    label: const Text("Add Row"),
                  ),
                  CommonSubmitButton(onPressed: () {
                    saveForm();
                  })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  saveForm() async {
    if (_formKey.currentState!.validate()) {
      final data = ListUnEmploymentInfo(
        rapId: rapId,
        unEmploymentInfoList: unemploymentList,
      );
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(unEmploymentKey, jsonEncode(data.toJson()));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('UnEmployment Info Saved'),
          backgroundColor: Colors.green,
        ),
      );
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pop(context, true);
      });
    }
  }
}

class _HeaderCell extends StatelessWidget {
  final String label;
  final double width;
  const _HeaderCell(this.label, {required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

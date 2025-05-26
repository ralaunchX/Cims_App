import 'dart:convert';

import 'package:cims/data_model/llwdsp_householdemployment_model.dart';
import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/constants.dart';
import 'package:cims/utils/keys.dart';
import 'package:cims/utils/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LlwdspHouseholdEmploymentScreen extends StatefulWidget {
  final ListEmploymentInfo? listEmploymentInfo;
  const LlwdspHouseholdEmploymentScreen({super.key, this.listEmploymentInfo});

  @override
  State<LlwdspHouseholdEmploymentScreen> createState() =>
      _LlwdspHouseholdEmploymentScreenState();
}

class _LlwdspHouseholdEmploymentScreenState
    extends State<LlwdspHouseholdEmploymentScreen> {
  final _formKey = GlobalKey<FormState>();
  String rapId = Keys.rapId;
  final String llwdspEmploymentKey =
      '${Keys.rapId}_${Keys.llwdspHouseholdEmployment}';

  List<EmploymentInfo> employmentList = [
    EmploymentInfo(
      refNo: '',
      typeOfEmployment: AppConstants.notSelected,
      employmentSector: AppConstants.notSelected,
      employmentCategory: AppConstants.notSelected,
      placeOfWork: AppConstants.notSelected,
    )
  ];

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = AppPrefs().prefs;
    final saved = prefs?.getString(llwdspEmploymentKey);
    if (saved != null) {
      final decoded = jsonDecode(saved);
      final data = ListEmploymentInfo.fromJson(decoded);
      setState(() {
        employmentList = data.employmentInfoList;
      });
    }
  }

  void _addRow() {
    setState(() {
      employmentList.add(EmploymentInfo(
        refNo: '',
        typeOfEmployment: AppConstants.notSelected,
        employmentSector: AppConstants.notSelected,
        employmentCategory: AppConstants.notSelected,
        placeOfWork: AppConstants.notSelected,
      ));
    });
  }

  void _removeRow(int index) {
    setState(() {
      employmentList.removeAt(index);
    });
  }

  Future<void> _saveForm() async {
    if (_formKey.currentState!.validate()) {
      final data = ListEmploymentInfo(
        rapId: rapId,
        employmentInfoList: employmentList,
      );
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(llwdspEmploymentKey, jsonEncode(data.toJson()));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Employment Info Saved'),
          backgroundColor: Colors.green,
        ),
      );
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pop(context, true);
      });
    }
  }

  Widget _textField({
    required String value,
    required void Function(String) onChanged,
    required String hint,
    required double width,
  }) =>
      SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: TextFormField(
            initialValue: value,
            onChanged: onChanged,
            validator: (val) => val!.isEmpty || val == '' ? 'Required' : null,
            decoration: InputDecoration(hintText: hint),
          ),
        ),
      );

  Widget _dropdownField({
    required String value,
    required void Function(String) onChanged,
    required List<String> items,
    required double width,
    required String hint,
  }) =>
      SizedBox(
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

  Widget _buildRow(int index) {
    final info = employmentList[index];
    return Row(
      children: [
        _textField(
          value: info.refNo,
          hint: 'Ref No.',
          width: 100,
          onChanged: (val) => info.refNo = val,
        ),
        _dropdownField(
          value: info.typeOfEmployment,
          items: AppConstants.employmentTypeChoices,
          onChanged: (val) => setState(() => info.typeOfEmployment = val),
          width: 300,
          hint: 'Type of Employment',
        ),
        _dropdownField(
          value: info.employmentSector,
          items: AppConstants.employmentSectorChoices,
          onChanged: (val) => setState(() => info.employmentSector = val),
          width: 300,
          hint: 'Employment Sector',
        ),
        _dropdownField(
          value: info.employmentCategory,
          items: AppConstants.employmentCategoryChoices,
          onChanged: (val) => setState(() => info.employmentCategory = val),
          width: 220,
          hint: 'Category/Responsibility',
        ),
        _dropdownField(
          value: info.placeOfWork,
          items: AppConstants.placeOfWorkChoices,
          onChanged: (val) => setState(() => info.placeOfWork = val),
          width: 220,
          hint: 'Place of Work',
        ),
        const SizedBox(
          width: 50,
        ),
        SizedBox(
          width: 100,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => _removeRow(index),
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
          _HeaderCell('Type of Employment', width: 300),
          _HeaderCell('Employment Sector', width: 300),
          _HeaderCell('Employment Category', width: 220),
          _HeaderCell('Place of Work', width: 220),
          SizedBox(width: 50),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Household Employment")),
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
                    width: 1300,
                    child: Column(
                      children: [
                        _buildHeader(),
                        const Divider(height: 0),
                        Expanded(
                          child: ListView.separated(
                            itemCount: employmentList.length,
                            itemBuilder: (context, index) => _buildRow(index),
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
                    _saveForm();
                  })
                ],
              )
            ],
          ),
        ),
      ),
    );
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

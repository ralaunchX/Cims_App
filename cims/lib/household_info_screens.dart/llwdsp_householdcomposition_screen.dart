import 'dart:convert';
import 'dart:developer';

import 'package:cims/data_model/llwdsp_householdcomposition_model.dart';
import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/constants.dart';
import 'package:cims/utils/keys.dart';
import 'package:cims/utils/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LlwdspHouseholdcompositionScreen extends StatefulWidget {
  final ListHouseholdMemberDto? listHouseholdMember;
  const LlwdspHouseholdcompositionScreen({super.key, this.listHouseholdMember});

  @override
  State<LlwdspHouseholdcompositionScreen> createState() =>
      _LlwdspHouseholdcompositionScreenState();
}

class _LlwdspHouseholdcompositionScreenState
    extends State<LlwdspHouseholdcompositionScreen> {
  List<HouseholdMemberDto> members = [
    HouseholdMemberDto(
      refNo: '',
      name: '',
      relation: AppConstants.notSelected,
      sex: AppConstants.notSelected,
      dob: null,
      maritalStatus: AppConstants.notSelected,
      residentialStatus: AppConstants.notSelected,
      educationLevel: AppConstants.notSelected,
      occupation: AppConstants.notSelected,
      disability: AppConstants.notSelected,
      illness: AppConstants.notSelected,
    )
  ];
  final _formKey = GlobalKey<FormState>();
  String rapId = Keys.rapId;
  String llwdspHouseholdCompositionKey =
      '${Keys.rapId}_${Keys.llwdspHouseholdComposition}';

  @override
  void initState() {
    super.initState();
    final prefs = AppPrefs().prefs;
    var houseHoldCompositionList = widget.listHouseholdMember;
    String? houseHoldString = prefs?.getString(llwdspHouseholdCompositionKey);
    if (houseHoldString != null) {
      final json = jsonDecode(houseHoldString);
      houseHoldCompositionList = ListHouseholdMemberDto.fromJson(json);
    }
    if (houseHoldCompositionList != null) {
      members = houseHoldCompositionList.members;
    }
  }

  void _addRow() {
    setState(() => members.add(HouseholdMemberDto(
          refNo: '',
          name: '',
          relation: AppConstants.notSelected,
          sex: AppConstants.notSelected,
          dob: null,
          maritalStatus: AppConstants.notSelected,
          residentialStatus: AppConstants.notSelected,
          educationLevel: AppConstants.notSelected,
          occupation: AppConstants.notSelected,
          disability: AppConstants.notSelected,
          illness: AppConstants.notSelected,
        )));
  }

  void _removeRow(int index) {
    setState(() => members.removeAt(index));
  }

  Future<void> _selectDate(int index) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => members[index].dob = picked);
    }
  }

  Widget _buildRow(int index) {
    final m = members[index];
    return Row(
      children: [
        _inputField(
          width: 80,
          hint: 'Ref No.',
          onChanged: (val) => m.refNo = val,
          value: m.refNo,
        ),
        _inputField(
            width: 150,
            hint: 'Name',
            onChanged: (val) => m.name = val,
            value: m.name),
        _dropdownField(
            width: 160,
            value: m.relation,
            hint: 'Relation',
            items: AppConstants.relationshipChoices,
            onChanged: (val) => m.relation = val),
        _dropdownField(
            width: 100,
            value: m.sex,
            hint: 'Sex',
            items: AppConstants.genderList,
            onChanged: (val) => m.sex = val),
        _datePickerField(index),
        _dropdownField(
            width: 130,
            value: m.maritalStatus,
            hint: 'Marital',
            items: AppConstants.maritalStatuses,
            onChanged: (val) => m.maritalStatus = val),
        _dropdownField(
            width: 150,
            value: m.residentialStatus,
            hint: 'Residential',
            items: AppConstants.residentialStatusChoices,
            onChanged: (val) => m.residentialStatus = val),
        _dropdownField(
            width: 170,
            value: m.educationLevel,
            hint: 'Education',
            items: AppConstants.educationLevelChoices,
            onChanged: (val) => m.educationLevel = val),
        _dropdownField(
            width: 180,
            value: m.occupation,
            hint: 'Occupation',
            items: AppConstants.occupationChoices,
            onChanged: (val) => m.occupation = val),
        _dropdownField(
            width: 130,
            value: m.disability,
            hint: 'Disability',
            items: AppConstants.disabilityChoices,
            onChanged: (val) => m.disability = val),
        _dropdownField(
            width: 130,
            value: m.illness,
            hint: 'Illness',
            items: AppConstants.chronicIllnessChoices,
            onChanged: (val) => m.illness = val),
        const SizedBox(
          width: 20,
        ),
        SizedBox(
          width: 100,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => _removeRow(index),
            child: const Text('Remove', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }

  Widget _inputField(
      {required double width,
      required String hint,
      required void Function(String) onChanged,
      required String value}) {
    return SizedBox(
      width: width,
      child: Padding(
          padding: const EdgeInsets.all(4),
          child: TextFormField(
            initialValue: value,
            onChanged: onChanged,
            validator: (val) => val!.isEmpty || val == '' ? 'Required' : null,
          )),
    );
  }

  Widget _dropdownField(
      {required double width,
      required String value,
      required String hint,
      required List<String> items,
      required void Function(String) onChanged}) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: DropdownButtonFormField<String>(
          validator: (val) => val == null || val == AppConstants.notSelected
              ? 'Required'
              : null,
          isExpanded: true,
          value: value.isEmpty ? null : value,
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (val) => onChanged(val ?? ''),
        ),
      ),
    );
  }

  Widget _datePickerField(int index) {
    final m = members[index];
    return SizedBox(
      width: 180,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: TextFormField(
          readOnly: true,
          onTap: () => _selectDate(index),
          controller: TextEditingController(
              text: m.dob == null
                  ? ''
                  : '${m.dob!.day.toString().padLeft(2, '0')}/${m.dob!.month.toString().padLeft(2, '0')}/${m.dob!.year}'),
          decoration: const InputDecoration(
              suffixIcon: Icon(Icons.calendar_today), hintText: 'dd/mm/yyyy'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Household Composition')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: 1700,
                    child: Column(
                      children: [
                        _buildTableHeader(),
                        const Divider(height: 0),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: members.length,
                            itemBuilder: (_, i) => _buildRow(i),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                ElevatedButton.icon(
                  onPressed: _addRow,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Row'),
                ),
                CommonSubmitButton(onPressed: () {
                  saveForm();
                })
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      color: Colors.blue.shade700,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: const Row(
        children: [
          _HeaderCell('Ref No.', width: 80),
          _HeaderCell('Name & Surname', width: 150),
          _HeaderCell('Relation to HH Head', width: 160),
          _HeaderCell('Sex (M/F)', width: 100),
          _HeaderCell('Year of Birth', width: 180),
          _HeaderCell('Marital Status', width: 130),
          _HeaderCell('Residential Status', width: 150),
          _HeaderCell('Completed Education', width: 170),
          _HeaderCell('Main Occupation', width: 180),
          _HeaderCell('Disability', width: 130),
          _HeaderCell('Chronic Illness', width: 130),
          SizedBox(width: 120),
        ],
      ),
    );
  }

  Future<void> saveForm() async {
    if (_formKey.currentState!.validate()) {
      final houseHoldData =
          ListHouseholdMemberDto(rapId: rapId, members: members);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          llwdspHouseholdCompositionKey, jsonEncode(houseHoldData.toJson()));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Household Form Submitted'),
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
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

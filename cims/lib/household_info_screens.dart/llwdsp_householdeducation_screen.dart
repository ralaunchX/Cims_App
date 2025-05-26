import 'dart:convert';

import 'package:cims/data_model/llwdsp_edcation_model.dart';
import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/constants.dart';
import 'package:cims/utils/keys.dart';
import 'package:cims/utils/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LlwdspHouseholdEducationScreen extends StatefulWidget {
  final ListEducationInfo? listEducationInfoData;
  const LlwdspHouseholdEducationScreen({super.key, this.listEducationInfoData});

  @override
  State<LlwdspHouseholdEducationScreen> createState() =>
      _LlwdspHouseholdEducationScreenState();
}

class _LlwdspHouseholdEducationScreenState
    extends State<LlwdspHouseholdEducationScreen> {
  List<EducationInfo> educationList = [
    EducationInfo(
      refNo: '',
      attendingSchool: AppConstants.notSelected,
      schoolLevel: AppConstants.notSelected,
      reasonForNonAttendance: AppConstants.notSelected,
    )
  ];
  final _formKey = GlobalKey<FormState>();
  String rapId = Keys.rapId;
  String llwdspEducationKey = '${Keys.rapId}_${Keys.llwdspHouseholdEducation}';

  void _addRow() => setState(() => educationList.add(EducationInfo(
        refNo: '',
        attendingSchool: AppConstants.notSelected,
        schoolLevel: AppConstants.notSelected,
        reasonForNonAttendance: AppConstants.notSelected,
      )));
  void _removeRow(int index) => setState(() => educationList.removeAt(index));

  @override
  void initState() {
    super.initState();
    final prefs = AppPrefs().prefs;
    var educationDataList = widget.listEducationInfoData;
    String? educationDataString = prefs?.getString(llwdspEducationKey);
    if (educationDataString != null) {
      final json = jsonDecode(educationDataString);
      educationDataList = ListEducationInfo.fromJson(json);
    }
    if (educationDataList != null) {
      educationList = educationDataList.educationInfoList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Household Education")),
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
                    width: 1150,
                    child: Column(
                      children: [
                        _buildHeader(),
                        const Divider(height: 0),
                        Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: educationList.length,
                            itemBuilder: (context, index) => _buildRow(index),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 5),
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

  Widget _buildHeader() {
    return Container(
      color: Colors.blue.shade700,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: const Row(
        children: [
          _HeaderCell('Ref No.', width: 100),
          _HeaderCell('Attending School', width: 180),
          _HeaderCell('School Level', width: 280),
          _HeaderCell('Reason for Non-Attendance', width: 400),
          SizedBox(width: 100),
        ],
      ),
    );
  }

  Widget _buildRow(int index) {
    final info = educationList[index];
    return Row(
      children: [
        _textField(
          width: 100,
          hint: 'Ref No.',
          value: info.refNo,
          onChanged: (val) => info.refNo = val,
        ),
        _dropdownField(
          width: 180,
          value: info.attendingSchool,
          hint: 'Select',
          items: AppConstants.yesNoOption,
          onChanged: (val) {
            setState(() => info.attendingSchool = val);
          },
        ),
        _dropdownField(
            width: 280,
            value: info.schoolLevel,
            hint: 'Select Level',
            items: AppConstants.schoolLevelChoices,
            onChanged: (val) {
              setState(
                () => info.schoolLevel = val,
              );
            }),
        _dropdownField(
            width: 400,
            value: info.reasonForNonAttendance,
            hint: 'Select Reason',
            items: AppConstants.nonAttendanceReasonChoices,
            onChanged: (val) {
              setState(
                () => info.reasonForNonAttendance = val,
              );
            }),
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

  Widget _textField({
    required double width,
    required String hint,
    required String value,
    required void Function(String) onChanged,
  }) {
    return SizedBox(
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
  }

  Widget _dropdownField({
    required double width,
    required String value,
    required String hint,
    required List<String> items,
    required void Function(String) onChanged,
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

  Future<void> saveForm() async {
    if (_formKey.currentState!.validate()) {
      final educationData =
          ListEducationInfo(rapId: rapId, educationInfoList: educationList);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          llwdspEducationKey, jsonEncode(educationData.toJson()));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Education Form Submitted'),
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
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

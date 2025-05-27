import 'dart:convert';

import 'package:cims/data_model/llwdsp_skillknowledge_model.dart';
import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/constants.dart';
import 'package:cims/utils/keys.dart';
import 'package:cims/utils/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LlwdspSkillKnowledgeScreen extends StatefulWidget {
  const LlwdspSkillKnowledgeScreen({super.key});

  @override
  State<LlwdspSkillKnowledgeScreen> createState() =>
      _LlwdspSkillKnowledgeScreenState();
}

class _LlwdspSkillKnowledgeScreenState
    extends State<LlwdspSkillKnowledgeScreen> {
  final _formKey = GlobalKey<FormState>();
  String rapId = Keys.rapId;
  final String llwdspSkillKnowledgeKey =
      '${Keys.rapId}_${Keys.llwdspHouseholdSkillKnowledge}';
  List<SkillKnowledge> skillList = [
    SkillKnowledge(
        refNo: '',
        dominantSkill: AppConstants.notSelected,
        skillAcquisition: AppConstants.notSelected,
        skillIncomeSource: AppConstants.notSelected,
        anotherSkill: AppConstants.notSelected,
        literacyLevel: AppConstants.notSelected)
  ];

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = AppPrefs().prefs;
    final saved = prefs?.getString(llwdspSkillKnowledgeKey);
    if (saved != null) {
      final decoded = jsonDecode(saved);
      final data = ListSkillKnowledge.fromJson(decoded);
      setState(() {
        skillList = data.skillKnowledgeList;
      });
    }
  }

  void _addRow() {
    setState(() => skillList.add(SkillKnowledge(
        refNo: '',
        dominantSkill: AppConstants.notSelected,
        skillAcquisition: AppConstants.notSelected,
        skillIncomeSource: AppConstants.notSelected,
        anotherSkill: AppConstants.notSelected,
        literacyLevel: AppConstants.notSelected)));
  }

  void _removeRow(int index) {
    setState(() => skillList.removeAt(index));
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.blue,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: const Row(
        children: [
          _HeaderCell('Ref no', width: 120),
          _HeaderCell('Dominant skill', width: 300),
          _HeaderCell('Skill acquisition', width: 500),
          _HeaderCell('Skill income source', width: 300),
          _HeaderCell('Another skill', width: 300),
          _HeaderCell('Literacy level', width: 500),
          SizedBox(width: 100),
        ],
      ),
    );
  }

  Widget _buildRow(int index) {
    final info = skillList[index];
    return Row(
      children: [
        _textField(
          width: 120,
          value: info.refNo,
          hint: 'Ref no',
          onChanged: (val) => info.refNo = val,
        ),
        _dropdownField(
          width: 300,
          value: info.dominantSkill,
          hint: 'Dominant Skill',
          items: AppConstants.skillChoices,
          onChanged: (val) => setState(() => info.dominantSkill = val),
        ),
        _dropdownField(
          width: 500,
          value: info.skillAcquisition,
          hint: 'Skill Acquisition',
          items: AppConstants.skillAcquisitionChoices,
          onChanged: (val) => setState(() => info.skillAcquisition = val),
        ),
        _dropdownField(
          width: 300,
          value: info.skillIncomeSource,
          hint: 'Income Source',
          items: AppConstants.incomeEarningChoices,
          onChanged: (val) => setState(() => info.skillIncomeSource = val),
        ),
        _dropdownField(
          width: 300,
          value: info.anotherSkill,
          hint: 'Another Skill',
          items: AppConstants.skillChoices,
          onChanged: (val) => setState(() => info.anotherSkill = val),
        ),
        _dropdownField(
          width: 500,
          value: info.literacyLevel,
          hint: 'Literacy Level',
          items: AppConstants.literacyLevelChoices,
          onChanged: (val) => setState(() => info.literacyLevel = val),
        ),
        const SizedBox(
          width: 50,
        ),
        SizedBox(
          width: 100,
          child: ElevatedButton(
            onPressed: () => _removeRow(index),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Remove', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }

  Widget _textField({
    required String value,
    required String hint,
    required double width,
    required Function(String) onChanged,
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

  Future<void> saveForm() async {
    if (_formKey.currentState!.validate()) {
      final data = ListSkillKnowledge(
        rapId: rapId,
        skillKnowledgeList: skillList,
      );
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(llwdspSkillKnowledgeKey, jsonEncode(data.toJson()));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Skill & Knowledge Form Saved'),
          backgroundColor: Colors.green,
        ),
      );
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pop(context, true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Skill Knowledge")),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: 2200,
                    child: Column(
                      children: [
                        _buildHeader(),
                        const Divider(height: 0),
                        Expanded(
                          child: ListView.separated(
                            itemCount: skillList.length,
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

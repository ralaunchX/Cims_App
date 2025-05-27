import 'dart:convert';

import 'package:cims/data_model/llwdsp_smallbusiness_model.dart';
import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/constants.dart';
import 'package:cims/utils/keys.dart';
import 'package:cims/utils/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LlwdspBusinessScreen extends StatefulWidget {
  const LlwdspBusinessScreen({super.key});

  @override
  State<LlwdspBusinessScreen> createState() => _LlwdspBusinessScreenState();
}

class _LlwdspBusinessScreenState extends State<LlwdspBusinessScreen> {
  final _formKey = GlobalKey<FormState>();
  final String rapId = Keys.rapId;
  final String llwdspSmallBusinessKey =
      '${Keys.rapId}_${Keys.llwdspHouseholdSmallBusiness}';

  List<BusinessInfo> businessList = [
    BusinessInfo(
        refNo: '',
        businessType: AppConstants.notSelected,
        positionInBusiness: AppConstants.notSelected,
        useOfIncome: AppConstants.notSelected,
        numPersonsInvolved: '0')
  ];

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = AppPrefs().prefs;
    final saved = prefs?.getString(llwdspSmallBusinessKey);
    if (saved != null) {
      final decoded = jsonDecode(saved);
      final data = ListBusinessInfo.fromJson(decoded);
      setState(() {
        businessList = data.businessInfoList;
      });
    }
  }

  void _addRow() {
    setState(() {
      businessList.add(BusinessInfo(
          refNo: '',
          businessType: AppConstants.notSelected,
          positionInBusiness: AppConstants.notSelected,
          useOfIncome: AppConstants.notSelected,
          numPersonsInvolved: '0'));
    });
  }

  void _removeRow(int index) {
    setState(() {
      businessList.removeAt(index);
    });
  }

  Future<void> _saveForm() async {
    if (_formKey.currentState!.validate()) {
      final data = ListBusinessInfo(
        rapId: rapId,
        businessInfoList: businessList,
      );
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(llwdspSmallBusinessKey, jsonEncode(data.toJson()));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Business Info Saved'),
          backgroundColor: Colors.green,
        ),
      );
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pop(context, true);
      });
    }
  }

  Widget _buildRow(int index) {
    final item = businessList[index];
    return Row(
      children: [
        _textField(item.refNo, 'Ref No.', 120, (val) => item.refNo = val),
        _dropdown(
            item.businessType,
            AppConstants.businessTypeChoices,
            'Business type',
            300,
            (val) => setState(() => item.businessType = val)),
        _dropdown(
            item.positionInBusiness,
            AppConstants.positionInBusinessChoices,
            'Position',
            300,
            (val) => setState(() => item.positionInBusiness = val)),
        _dropdown(
            item.useOfIncome,
            AppConstants.useOfIncomeChoices,
            'Use of income',
            300,
            (val) => setState(() => item.useOfIncome = val)),
        _textField(item.numPersonsInvolved, 'Num Persons', 120,
            (val) => item.numPersonsInvolved = val),
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
        )
      ],
    );
  }

  Widget _textField(String value, String hint, double width,
          void Function(String) onChanged) =>
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

  Widget _dropdown(String value, List<String> items, String hint, double width,
          void Function(String) onChanged) =>
      SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            value: value == '' ? null : value,
            decoration: InputDecoration(hintText: hint),
            onChanged: (val) => onChanged(val!),
            validator: (val) => val == null || val == AppConstants.notSelected
                ? 'Required'
                : null,
            items: items
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
          ),
        ),
      );

  Widget _buildHeader() => Container(
        color: Colors.blue,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: const Row(
          children: [
            _HeaderCell('Ref No.', width: 120),
            _HeaderCell('Business Type', width: 300),
            _HeaderCell('Position in Business', width: 300),
            _HeaderCell('Use of Income', width: 300),
            _HeaderCell('Num Persons Involved', width: 120),
            SizedBox(width: 100),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Business Information")),
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
                    width: 1300,
                    child: Column(
                      children: [
                        _buildHeader(),
                        const Divider(height: 0),
                        Expanded(
                          child: ListView.separated(
                            itemCount: businessList.length,
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
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _addRow,
                    icon: const Icon(Icons.add),
                    label: const Text("Add Row"),
                  ),
                  CommonSubmitButton(onPressed: _saveForm)
                ],
              ),
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

import 'dart:convert';

import 'package:cims/data_model/asset_coowner_model.dart';
import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/constants.dart';
import 'package:cims/utils/keys.dart';
import 'package:cims/utils/submit_button.dart';
import 'package:cims/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssetCoOwnerScreen extends StatefulWidget {
  const AssetCoOwnerScreen({super.key});

  @override
  State<AssetCoOwnerScreen> createState() => _AssetCoOwnerScreenState();
}

class _AssetCoOwnerScreenState extends State<AssetCoOwnerScreen> {
  final _formKey = GlobalKey<FormState>();
  final String rapId = Keys.rapId;
  final String storageKey = '${Keys.rapId}_${Keys.assetCoowner}';

  String firstName = '';
  String lastName = '';
  String physicalAddress = '';
  String contactCell = '';
  String idType = 'None';
  String idNumber = '';
  String? idExpiryDate;
  String bankName = '';

  late TextEditingController idExpiryController;
  bool get showIdFields => idType != 'None';

  @override
  void initState() {
    super.initState();
    idExpiryController = TextEditingController();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = AppPrefs().prefs;
    final saved = prefs?.getString(storageKey);
    if (saved != null) {
      final data = AssetCoOwnerDto.fromJson(jsonDecode(saved));
      setState(() {
        firstName = data.firstName;
        lastName = data.lastName;
        physicalAddress = data.physicalAddress;
        contactCell = data.contactCell;
        idType = data.idType;
        idNumber = data.idNumber;
        idExpiryDate = data.idExpiryDate;
        idExpiryController.text = idExpiryDate ?? '';
        bankName = data.bankName;
      });
    }
  }

  Future<void> saveForm() async {
    if (_formKey.currentState!.validate()) {
      final dto = AssetCoOwnerDto(
        rapId: rapId,
        firstName: firstName,
        lastName: lastName,
        physicalAddress: physicalAddress,
        contactCell: contactCell,
        idType: idType,
        idNumber: idNumber,
        idExpiryDate: idExpiryDate ?? '',
        bankName: bankName,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(storageKey, jsonEncode(dto.toJson()));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Data saved successfully'),
            backgroundColor: Colors.green),
      );
      Future.delayed(const Duration(milliseconds: 500),
          () => Navigator.pop(context, true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Asset Co-Owner')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField(
                    'First name', firstName, (val) => firstName = val),
                _buildTextField('Last name', lastName, (val) => lastName = val),
                _buildTextField('Physical address', physicalAddress,
                    (val) => physicalAddress = val),
                _buildTextField(
                    'Contact cell', contactCell, (val) => contactCell = val,
                    keyboardType: TextInputType.phone),
                DropdownButtonFormField<String>(
                  isExpanded: true,
                  decoration: const InputDecoration(
                      labelText: 'Type of identification'),
                  value: idType,
                  items: AppConstants.idTypes
                      .map((type) =>
                          DropdownMenuItem(value: type, child: Text(type)))
                      .toList(),
                  onChanged: (val) => setState(() => idType = val ?? 'None'),
                ),
                if (showIdFields) ...[
                  _buildTextField('Identification number', idNumber,
                      (val) => idNumber = val),
                  TextFormField(
                    controller: idExpiryController,
                    readOnly: true,
                    decoration: const InputDecoration(labelText: 'Expiry date'),
                    onTap: () async {
                      final selected = await Utility.selectDate(context);
                      if (selected != null) {
                        final expiry =
                            DateFormat('yyyy-MM-dd').format(selected);
                        setState(() {
                          idExpiryDate = expiry;
                          idExpiryController.text = expiry;
                        });
                      }
                    },
                    validator: (val) =>
                        val == null || val.isEmpty ? 'Required' : null,
                  ),
                ],
                const SizedBox(height: 10),
                _buildTextField('Bank name', bankName, (val) => bankName = val),
                const SizedBox(height: 24),
                CommonSubmitButton(onPressed: saveForm),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String value, Function(String) onChanged,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        initialValue: value,
        textInputAction: TextInputAction.next,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            labelText: label, hintText: 'enter $label'.toLowerCase()),
        onChanged: onChanged,
        validator: (val) =>
            val == null || val.trim().isEmpty ? 'Required' : null,
      ),
    );
  }
}

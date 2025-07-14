import 'dart:convert';

import 'package:cims/data_model/asset_beneficiary_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cims/utils/constants.dart';
import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/keys.dart';
import 'package:cims/utils/submit_button.dart';
import 'package:cims/utils/utility.dart';

class AssetBeneficiaryScreen extends StatefulWidget {
  const AssetBeneficiaryScreen({super.key});

  @override
  State<AssetBeneficiaryScreen> createState() => _AssetBeneficiaryScreenState();
}

class _AssetBeneficiaryScreenState extends State<AssetBeneficiaryScreen> {
  final _formKey = GlobalKey<FormState>();
  final String rapId = Keys.rapId;
  final String storageKey = '${Keys.rapId}_${Keys.assetBeneficiary}';

  String firstName = '';
  String lastName = '';
  String village = '';
  bool isMinor = false;
  String? dateOfBirth;
  String physicalAddress = '';
  String postalAddress = '';
  String contactCell = '';
  String idType = 'None';
  String idNumber = '';
  String? idExpiryDate;
  String bankingDetails = '';

  late TextEditingController dobController;
  late TextEditingController idExpiryController;

  bool get showIdFields => idType != 'None';

  @override
  void initState() {
    super.initState();
    dobController = TextEditingController();
    idExpiryController = TextEditingController();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = AppPrefs().prefs;
    final saved = prefs?.getString(storageKey);
    if (saved != null) {
      final data = AssetBeneficiaryDto.fromJson(jsonDecode(saved));
      setState(() {
        firstName = data.firstName;
        lastName = data.lastName;
        village = data.village;
        isMinor = data.isMinor;
        dateOfBirth = data.dateOfBirth;
        dobController.text = dateOfBirth ?? '';
        physicalAddress = data.physicalAddress;
        postalAddress = data.postalAddress;
        contactCell = data.contactCell;
        idType = data.idType;
        idNumber = data.idNumber;
        idExpiryDate = data.idExpiryDate;
        idExpiryController.text = idExpiryDate ?? '';
        bankingDetails = data.bankingDetails;
      });
    }
  }

  Future<void> saveForm() async {
    if (_formKey.currentState!.validate()) {
      final dto = AssetBeneficiaryDto(
        rapId: rapId,
        firstName: firstName,
        lastName: lastName,
        village: village,
        isMinor: isMinor,
        dateOfBirth: dateOfBirth ?? '',
        physicalAddress: physicalAddress,
        postalAddress: postalAddress,
        contactCell: contactCell,
        idType: idType,
        idNumber: idNumber,
        idExpiryDate: idExpiryDate ?? '',
        bankingDetails: bankingDetails,
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
      appBar: AppBar(
          title: const Text('01 Asset Registration - Beneficiary Details')),
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
                _buildTextField('Village', village, (val) => village = val),
                CheckboxListTile(
                  value: isMinor,
                  title: const Text('Minor'),
                  onChanged: (val) => setState(() => isMinor = val ?? false),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                TextFormField(
                  controller: dobController,
                  readOnly: true,
                  decoration: const InputDecoration(labelText: 'Date of birth'),
                  onTap: () async {
                    final selected = await Utility.selectDate(context);
                    if (selected != null) {
                      final dob = DateFormat('yyyy-MM-dd').format(selected);
                      setState(() {
                        dateOfBirth = dob;
                        dobController.text = dob;
                      });
                    }
                  },
                  validator: (val) =>
                      val == null || val.isEmpty ? 'Required' : null,
                ),
                _buildTextField('Physical address', physicalAddress,
                    (val) => physicalAddress = val),
                _buildTextField('Postal address', postalAddress,
                    (val) => postalAddress = val),
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
                _buildTextField('Banking details', bankingDetails,
                    (val) => bankingDetails = val),
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

import 'dart:convert';

import 'package:cims/data_model/asset_household_model.dart';
import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/constants.dart';
import 'package:cims/utils/keys.dart';
import 'package:cims/utils/submit_button.dart';
import 'package:cims/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssetHouseholdScreen extends StatefulWidget {
  const AssetHouseholdScreen({super.key});

  @override
  State<AssetHouseholdScreen> createState() => _AssetHouseholdScreenState();
}

class _AssetHouseholdScreenState extends State<AssetHouseholdScreen> {
  final _formKey = GlobalKey<FormState>();
  final String rapId = Keys.rapId;
  final String assetHouseHoldKey = '${Keys.rapId}_${Keys.assetsHouseHold}';
  String routeName = AppConstants.notSelected;
  String papNumber = '';
  String firstName = '';
  String lastName = '';
  String gender = AppConstants.notSelected;
  String identificationType = 'None';
  String idNumber = '';

  String? idExpiryDate;

  String originalVillage = '';
  String residentialVillage = '';
  String occupation = '';
  String cellphone = '';
  bool get showIdFields => identificationType != 'None';
  late TextEditingController idExpiryDateController;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = AppPrefs().prefs;
    final saved = prefs?.getString(assetHouseHoldKey);
    if (saved != null) {
      final decoded = jsonDecode(saved);
      final data = AssetHouseholdDto.fromJson(decoded);
      setState(() {
        routeName = data.routeName;
        papNumber = data.papNumber;
        firstName = data.firstName;
        lastName = data.lastName;
        gender = data.gender;
        identificationType = data.identificationType;
        idNumber = data.idNumber;
        idExpiryDate = data.idExpiryDate;
        originalVillage = data.originalVillage;
        residentialVillage = data.residentialVillage;
        occupation = data.occupation;
        cellphone = data.cellphone;
        idExpiryDateController =
            TextEditingController(text: idExpiryDate ?? '');
      });
    }
  }

  Future<void> saveForm() async {
    if (_formKey.currentState!.validate()) {
      final dto = AssetHouseholdDto(
        rapId: rapId,
        routeName: routeName,
        papNumber: papNumber,
        firstName: firstName,
        lastName: lastName,
        gender: gender,
        identificationType: identificationType,
        idNumber: idNumber,
        idExpiryDate: idExpiryDate ?? '',
        originalVillage: originalVillage,
        residentialVillage: residentialVillage,
        occupation: occupation,
        cellphone: cellphone,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(assetHouseHoldKey, jsonEncode(dto.toJson()));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data saved successfully'),
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
      appBar: AppBar(title: const Text('Asset Household Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  isExpanded: true,
                  decoration: const InputDecoration(labelText: 'Route name'),
                  value:
                      routeName.isEmpty ? AppConstants.notSelected : routeName,
                  items: AppConstants.routes
                      .map((route) =>
                          DropdownMenuItem(value: route, child: Text(route)))
                      .toList(),
                  onChanged: (val) => setState(() => routeName = val ?? ''),
                  validator: (val) {
                    if (val == null || val == AppConstants.notSelected) {
                      return 'Select';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: papNumber,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(labelText: 'Pap number'),
                  onChanged: (val) => papNumber = val.trim(),
                  validator: (val) =>
                      val == null || val.trim().isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: firstName,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(labelText: 'First name'),
                  onChanged: (val) => firstName = val,
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: lastName,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(labelText: 'Last name'),
                  onChanged: (val) => lastName = val,
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Gender'),
                  value: gender,
                  items: AppConstants.genderList
                      .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                      .toList(),
                  onChanged: (val) =>
                      setState(() => gender = val ?? '---------'),
                  validator: (val) {
                    if (val == null || val == AppConstants.notSelected) {
                      return 'Select';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                      labelText: 'Type of identification'),
                  value: identificationType,
                  items: AppConstants.idTypes
                      .map((type) =>
                          DropdownMenuItem(value: type, child: Text(type)))
                      .toList(),
                  onChanged: (val) =>
                      setState(() => identificationType = val ?? 'None'),
                ),
                const SizedBox(height: 12),
                if (showIdFields) ...[
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    initialValue: idNumber,
                    decoration: const InputDecoration(labelText: 'ID Number'),
                    onChanged: (val) => setState(() => idNumber = val),
                    validator: (val) => val!.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                      controller: idExpiryDateController,
                      readOnly: true,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'ID Expiry Date',
                      ),
                      onTap: () async {
                        final selected = await Utility.selectDate(context);
                        if (selected != null) {
                          setState(() {
                            var date =
                                DateFormat('yyyy-MM-dd').format(selected);
                            idExpiryDate = date;
                            idExpiryDateController.text = date;
                          });
                        }
                      },
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Required';
                        }
                      }),
                ],
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: originalVillage,
                  textInputAction: TextInputAction.next,
                  decoration:
                      const InputDecoration(labelText: 'Original village name'),
                  onChanged: (val) => originalVillage = val,
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: residentialVillage,
                  textInputAction: TextInputAction.next,
                  decoration:
                      const InputDecoration(labelText: 'Residential village'),
                  onChanged: (val) => residentialVillage = val,
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: occupation,
                  textInputAction: TextInputAction.next,
                  decoration:
                      const InputDecoration(labelText: 'Occupation of pap'),
                  onChanged: (val) => occupation = val,
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: cellphone,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(labelText: 'Cellphone no'),
                  keyboardType: TextInputType.phone,
                  onChanged: (val) => cellphone = val,
                  validator: (val) {
                    if (val == null || val.isEmpty) return 'Required';

                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CommonSubmitButton(onPressed: saveForm)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

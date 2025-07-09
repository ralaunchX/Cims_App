import 'dart:convert';

import 'package:cims/data_model/crop_field_model.dart';
import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/constants.dart';
import 'package:cims/utils/keys.dart';
import 'package:cims/utils/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LlwdspCropfieldScreen extends StatefulWidget {
  final LlwdspCropFieldModel? llwdspCropFieldModel;
  const LlwdspCropfieldScreen({super.key, this.llwdspCropFieldModel});

  @override
  State<LlwdspCropfieldScreen> createState() => _LlwdspCropfieldScreenState();
}

class _LlwdspCropfieldScreenState extends State<LlwdspCropfieldScreen> {
  final _formKey = GlobalKey<FormState>();
  String rapId = Keys.rapId;
  String llwdspCropFieldKey = '${Keys.rapId}_${Keys.llwdspCropField}';

  int? fieldsOwned;
  int? fieldsCultivated;
  String selectedNonCultivationReason = AppConstants.notSelected;

  List<CropFieldEntry> cropFields = [
    CropFieldEntry(
        cropUse: AppConstants.notSelected,
        cultivationMethod: AppConstants.notSelected,
        fertilization: AppConstants.notSelected,
        mainCrop: AppConstants.notSelected,
        ownership: AppConstants.notSelected,
        secondCrop: AppConstants.notSelected,
        seedType: AppConstants.notSelected)
  ];

  @override
  void initState() {
    super.initState();
    final prefs = AppPrefs().prefs;
    var cropFieldData = widget.llwdspCropFieldModel;
    String? cropFieldString = prefs?.getString(llwdspCropFieldKey);
    if (cropFieldString != null) {
      final json = jsonDecode(cropFieldString);
      cropFieldData = LlwdspCropFieldModel.fromJson(json);
    }
    if (cropFieldData != null) {
      fieldsOwned = cropFieldData.fieldsOwned;
      fieldsCultivated = cropFieldData.fieldsCultivated;
      selectedNonCultivationReason = cropFieldData.selectedNonCultivationReason;
      cropFields = cropFieldData.cropFields;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crop Fields Information')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: fieldsOwned?.toString(),
                decoration:
                    const InputDecoration(labelText: 'Number of Fields Owned'),
                onChanged: (val) => fieldsOwned = int.parse(val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              TextFormField(
                initialValue: fieldsCultivated?.toString(),
                decoration: const InputDecoration(
                    labelText: 'Number of Fields Cultivated'),
                onChanged: (val) => fieldsCultivated = int.parse(val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Non-Cultivation Reason',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ...AppConstants.nonCultivationReasons
                  .map((reason) => RadioListTile<String>(
                        title: Text(reason),
                        value: reason,
                        groupValue: selectedNonCultivationReason,
                        onChanged: (value) {
                          setState(() {
                            selectedNonCultivationReason = value!;
                          });
                        },
                      )),
              const SizedBox(height: 24),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: const Row(
                          children: [
                            SizedBox(
                                width: 120,
                                child: Text(
                                  'Field No',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                )),
                            SizedBox(
                                width: 300,
                                child: Text('Ownership',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center)),
                            SizedBox(
                                width: 300,
                                child: Text('Cultivation',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center)),
                            SizedBox(
                                width: 150,
                                child: Text('Main Crop',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center)),
                            SizedBox(
                                width: 150,
                                child: Text('Second Crop',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center)),
                            SizedBox(
                                width: 300,
                                child: Text('Seed Type',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center)),
                            SizedBox(
                                width: 300,
                                child: Text('Fertilization',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center)),
                            SizedBox(
                                width: 250,
                                child: Text('Crop Use',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center)),
                          ],
                        ),
                      ),
                      Column(
                        children: cropFields.asMap().entries.map((entry) {
                          final index = entry.key;
                          final field = entry.value;

                          return Row(
                            children: [
                              SizedBox(
                                width: 120,
                                child: TextFormField(
                                  initialValue: field.fieldNumber,
                                  decoration: const InputDecoration(),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  onChanged: (val) => field.fieldNumber = val,
                                  validator: (val) {
                                    if (val == null || val == '') {
                                      return 'Fill';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 300,
                                child: DropdownButtonFormField<String>(
                                  isExpanded: true,
                                  value: field.ownership,
                                  decoration: const InputDecoration(),
                                  items: AppConstants.ownershipChoices
                                      .map((e) => DropdownMenuItem(
                                          value: e, child: Text(e)))
                                      .toList(),
                                  onChanged: (val) =>
                                      setState(() => field.ownership = val),
                                  validator: (val) {
                                    if (val == null ||
                                        val == AppConstants.notSelected) {
                                      return 'Select';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 300,
                                child: DropdownButtonFormField<String>(
                                  value: field.cultivationMethod,
                                  isExpanded: true,
                                  decoration: const InputDecoration(),
                                  items: AppConstants.cultivationMethodChoices
                                      .map((e) => DropdownMenuItem(
                                          value: e, child: Text(e)))
                                      .toList(),
                                  onChanged: (val) => setState(
                                      () => field.cultivationMethod = val),
                                  validator: (val) {
                                    if (val == null ||
                                        val == AppConstants.notSelected) {
                                      return 'Select';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                child: DropdownButtonFormField<String>(
                                  isExpanded: true,
                                  value: field.mainCrop,
                                  decoration: const InputDecoration(),
                                  items: AppConstants.cropGrownHarvested
                                      .map((e) => DropdownMenuItem(
                                          value: e, child: Text(e)))
                                      .toList(),
                                  onChanged: (val) =>
                                      setState(() => field.mainCrop = val),
                                  validator: (val) {
                                    if (val == null ||
                                        val == AppConstants.notSelected) {
                                      return 'Select';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                child: DropdownButtonFormField<String>(
                                  isExpanded: true,
                                  value: field.secondCrop,
                                  decoration: const InputDecoration(),
                                  items: AppConstants.cropGrownHarvested
                                      .map((e) => DropdownMenuItem(
                                          value: e, child: Text(e)))
                                      .toList(),
                                  onChanged: (val) =>
                                      setState(() => field.secondCrop = val),
                                  validator: (val) {
                                    if (val == null ||
                                        val == AppConstants.notSelected) {
                                      return 'Select';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 300,
                                child: DropdownButtonFormField<String>(
                                  isExpanded: true,
                                  value: field.seedType,
                                  decoration: const InputDecoration(),
                                  items: AppConstants.seedChoices
                                      .map((e) => DropdownMenuItem(
                                          value: e, child: Text(e)))
                                      .toList(),
                                  onChanged: (val) =>
                                      setState(() => field.seedType = val),
                                  validator: (val) {
                                    if (val == null ||
                                        val == AppConstants.notSelected) {
                                      return 'Select';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 300,
                                child: DropdownButtonFormField<String>(
                                  isExpanded: true,
                                  value: field.fertilization,
                                  decoration: const InputDecoration(),
                                  items: AppConstants.fertilizationChoices
                                      .map((e) => DropdownMenuItem(
                                          value: e, child: Text(e)))
                                      .toList(),
                                  onChanged: (val) =>
                                      setState(() => field.fertilization = val),
                                  validator: (val) {
                                    if (val == null ||
                                        val == AppConstants.notSelected) {
                                      return 'Select';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 250,
                                child: DropdownButtonFormField<String>(
                                  value: field.cropUse,
                                  isExpanded: true,
                                  decoration: const InputDecoration(),
                                  items: AppConstants.cropUseChoices
                                      .map((e) => DropdownMenuItem(
                                          value: e, child: Text(e)))
                                      .toList(),
                                  onChanged: (val) =>
                                      setState(() => field.cropUse = val),
                                  validator: (val) {
                                    if (val == null ||
                                        val == AppConstants.notSelected) {
                                      return 'Select';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.remove_circle,
                                    color: Colors.red),
                                onPressed: () =>
                                    setState(() => cropFields.removeAt(index)),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => setState(() => cropFields.add(
                        CropFieldEntry(
                            cropUse: AppConstants.notSelected,
                            cultivationMethod: AppConstants.notSelected,
                            fertilization: AppConstants.notSelected,
                            mainCrop: AppConstants.notSelected,
                            ownership: AppConstants.notSelected,
                            secondCrop: AppConstants.notSelected,
                            seedType: AppConstants.notSelected))),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      shape: const RoundedRectangleBorder(),
                    ),
                    child:
                        const Text('Add Field', style: TextStyle(fontSize: 14)),
                  ),
                  CommonSubmitButton(onPressed: () {
                    saveForm();
                  })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveForm() async {
    if (_formKey.currentState!.validate()) {
      final llwdspCropFieldData = LlwdspCropFieldModel(
          rapId: rapId,
          fieldsOwned: fieldsOwned ?? 0,
          fieldsCultivated: fieldsCultivated ?? 0,
          selectedNonCultivationReason: selectedNonCultivationReason,
          cropFields: cropFields);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          llwdspCropFieldKey, jsonEncode(llwdspCropFieldData.toJson()));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Crop Field Form Submitted'),
            backgroundColor: Colors.green),
      );
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pop(context, true);
      });
    }
  }
}

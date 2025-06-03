import 'dart:convert';
import 'package:cims/data_model/llwdsp_assets_model.dart';
import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/constants.dart';
import 'package:cims/utils/keys.dart';
import 'package:cims/utils/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LlwdspAssetsScreen extends StatefulWidget {
  final LLdwspAssetsModel? lLdwspAssetsModel;

  const LlwdspAssetsScreen({super.key, this.lLdwspAssetsModel});

  @override
  State<LlwdspAssetsScreen> createState() => _LlwdspAssetsScreenState();
}

class _LlwdspAssetsScreenState extends State<LlwdspAssetsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String rapId = Keys.rapId;
  String llwdspAssetsKey = '${Keys.rapId}_${Keys.llwdspAssets}';

  int dwellingOwnership = 0;
  int wallMaterial = 0;
  int roofMaterial = 0;
  int floorMaterial = 0;

  List<int> selectedStructuresServices = [];
  List<int> selectedOtherStructures = [];
  List<int> selectedHouseholdItems = [];
  List<int> selectedAppliances = [];
  List<int> selectedAgriculturalEquipment = [];

  @override
  void initState() {
    super.initState();
    final prefs = AppPrefs().prefs;
    var assetData = widget.lLdwspAssetsModel;
    String? assetsString = prefs?.getString(llwdspAssetsKey);
    if (assetsString != null) {
      final json = jsonDecode(assetsString);
      assetData = LLdwspAssetsModel.fromJson(json);
    }
    if (assetData != null) {
      dwellingOwnership = assetData.dwellingOwnership;
      wallMaterial = assetData.wallMaterial;
      roofMaterial = assetData.roofMaterial;
      floorMaterial = assetData.floorMaterial;
      selectedStructuresServices = assetData.selectedStructuresServices;
      selectedOtherStructures = assetData.selectedOtherStructures;
      selectedHouseholdItems = assetData.selectedHouseholdItems;
      selectedAppliances = assetData.selectedAppliances;
      selectedAgriculturalEquipment = assetData.selectedAgriculturalEquipment;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LLWDSP Assets')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRadioSection(
                  '1. Does the household own or rent this dwelling?',
                  AppConstants.dwellingOwnership,
                  dwellingOwnership,
                  (val) => setState(() => dwellingOwnership = val!)),
              _buildRadioSection(
                  '2. What material is used PREDOMINANTLY for the walls?',
                  AppConstants.wallMaterialOptions,
                  wallMaterial,
                  (val) => setState(() => wallMaterial = val!)),
              _buildRadioSection(
                  '3. What material is used PREDOMINANTLY for the roof?',
                  AppConstants.roofMaterialOptions,
                  roofMaterial,
                  (val) => setState(() => roofMaterial = val!)),
              _buildRadioSection(
                  '4. What material is used PREDOMINANTLY for the floor?',
                  AppConstants.floorMaterialOptions,
                  floorMaterial,
                  (val) => setState(() => floorMaterial = val!)),
              _buildMultiSelect(
                  '5. Structures and services on the homestead?',
                  AppConstants.structuresServicesOptions,
                  selectedStructuresServices),
              _buildMultiSelect('6. Additional structures elsewhere?',
                  AppConstants.otherStructuresOptions, selectedOtherStructures),
              _buildMultiSelect('7. Household items?',
                  AppConstants.householdItemsOptions, selectedHouseholdItems),
              _buildMultiSelect('8. Appliances?',
                  AppConstants.appliancesOptions, selectedAppliances),
              _buildMultiSelect(
                  '9. Agricultural equipment?',
                  AppConstants.agriculturalEquipmentOptions,
                  selectedAgriculturalEquipment),
              CommonSubmitButton(onPressed: saveForm)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioSection(String title, Map<int, String> options,
      int groupVal, void Function(int?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...options.entries.map((entry) => RadioListTile<int>(
              dense: true,
              visualDensity: VisualDensity.compact,
              title: Text(entry.value, style: const TextStyle(fontSize: 16)),
              value: entry.key,
              groupValue: groupVal,
              onChanged: onChanged,
            ))
      ],
    );
  }

  Widget _buildMultiSelect(
      String title, Map<int, String> options, List<int> selectedList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ...options.entries.map((entry) => CheckboxListTile(
              dense: true,
              visualDensity: VisualDensity.compact,
              title: Text(entry.value, style: const TextStyle(fontSize: 16)),
              controlAffinity: ListTileControlAffinity.leading,
              value: selectedList.contains(entry.key),
              onChanged: (isChecked) {
                setState(() {
                  if (isChecked == true) {
                    selectedList.add(entry.key);
                  } else {
                    selectedList.remove(entry.key);
                  }
                });
              },
            )),
      ],
    );
  }

  Future<void> saveForm() async {
    if ([dwellingOwnership, wallMaterial, roofMaterial, floorMaterial]
        .contains(0)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please answer all required questions.'),
            backgroundColor: Colors.red),
      );
      return;
    }

    final model = LLdwspAssetsModel(
      caseId: rapId,
      dwellingOwnership: dwellingOwnership,
      wallMaterial: wallMaterial,
      roofMaterial: roofMaterial,
      floorMaterial: floorMaterial,
      selectedStructuresServices: selectedStructuresServices,
      selectedOtherStructures: selectedOtherStructures,
      selectedHouseholdItems: selectedHouseholdItems,
      selectedAppliances: selectedAppliances,
      selectedAgriculturalEquipment: selectedAgriculturalEquipment,
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(llwdspAssetsKey, jsonEncode(model.toJson()));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Assets Form Submitted'),
          backgroundColor: Colors.green),
    );

    Future.delayed(
        const Duration(milliseconds: 500), () => Navigator.pop(context, true));
  }
}

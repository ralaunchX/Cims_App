import 'dart:convert';
import 'dart:developer';

import 'package:cims/data_model/lldwdsp_assets_model.dart';
import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/constants.dart';
import 'package:cims/utils/keys.dart';
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

  String dwellingOwnership = AppConstants.notSelected;
  String wallMaterial = AppConstants.notSelected;
  String roofMaterial = AppConstants.notSelected;
  String floorMaterial = AppConstants.notSelected;

  List<String> selectedStructuresServices = [];
  List<String> selectedOtherStructures = [];
  List<String> selectedHouseholdItems = [];
  List<String> selectedAppliances = [];
  List<String> selectedAgriculturalEquipment = [];

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
              const Text(
                '1. Does the household own or rent this dwelling?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              _buildMaterialOptions(
                  'dwellingOwnership', AppConstants.dwellingOwnership),
              const SizedBox(height: 24),
              const Text(
                '2. What material is used PREDOMINANTLY for the walls?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              _buildMaterialOptions('wall', AppConstants.wallOptions),
              const SizedBox(height: 24),
              const Text(
                '3. What material is used PREDOMINANTLY for the roof?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              _buildMaterialOptions('roof', AppConstants.roofOptions),
              const SizedBox(height: 24),
              const Text(
                '4. What material is used PREDOMINANTLY for the floor?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              _buildMaterialOptions('floor', AppConstants.floorOptions),
              _buildMultiSelect(
                '5. Is there any of the following structures and services on the homestead the household occupies?',
                AppConstants.structuresServicesOptions,
                selectedStructuresServices,
              ),
              _buildMultiSelect(
                '6. Does the household have any of the following on the homestead it occupies, or elsewhere?',
                AppConstants.otherStructuresOptions,
                selectedOtherStructures,
              ),
              _buildMultiSelect(
                '7. Ask if the household or a household member has any of the following items?',
                AppConstants.householdItemsOptions,
                selectedHouseholdItems,
              ),
              _buildMultiSelect(
                '8. Does the household have any of the following appliances?',
                AppConstants.appliancesOptions,
                selectedAppliances,
              ),
              _buildMultiSelect(
                '9. Does the household have any of the following agricultural equipment and implements in working order?',
                AppConstants.agriculturalEquipmentOptions,
                selectedAgriculturalEquipment,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    saveForm();
                  },
                  child: const Text('Submit'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMaterialOptions(String type, List<String> options) {
    String groupValue;
    void Function(String?) onChanged;

    switch (type) {
      case 'dwellingOwnership':
        groupValue = dwellingOwnership;
        onChanged = (val) => setState(() => dwellingOwnership = val!);
        break;
      case 'wall':
        groupValue = wallMaterial;
        onChanged = (val) => setState(() => wallMaterial = val!);
        break;
      case 'roof':
        groupValue = roofMaterial;
        onChanged = (val) => setState(() => roofMaterial = val!);
        break;
      case 'floor':
        groupValue = floorMaterial;
        onChanged = (val) => setState(() => floorMaterial = val!);
        break;
      default:
        groupValue = '';
        onChanged = (_) {};
    }

    return Column(
      children: options.map((option) {
        return RadioListTile<String>(
          dense: true,
          visualDensity: VisualDensity.compact,
          title: Text(option, style: const TextStyle(fontSize: 16)),
          value: option,
          groupValue: groupValue,
          onChanged: onChanged,
        );
      }).toList(),
    );
  }

  Widget _buildMultiSelect(
      String title, List<String> options, List<String> selectedList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...options.map((option) {
          return CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            visualDensity: VisualDensity.compact,
            title: Text(option, style: const TextStyle(fontSize: 16)),
            controlAffinity: ListTileControlAffinity.leading,
            value: selectedList.contains(option),
            onChanged: (isSelected) {
              setState(() {
                if (isSelected == true) {
                  selectedList.add(option);
                } else {
                  selectedList.remove(option);
                }
              });
            },
          );
        }).toList(),
        const SizedBox(height: 24),
      ],
    );
  }

  Future<void> saveForm() async {
    if (dwellingOwnership == AppConstants.notSelected ||
        wallMaterial == AppConstants.notSelected ||
        roofMaterial == AppConstants.notSelected ||
        floorMaterial == AppConstants.notSelected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please answer all required questions.'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      final llwdspAssetData = LLdwspAssetsModel(
          dwellingOwnership: dwellingOwnership,
          wallMaterial: wallMaterial,
          roofMaterial: roofMaterial,
          floorMaterial: floorMaterial,
          selectedStructuresServices: selectedStructuresServices,
          selectedOtherStructures: selectedOtherStructures,
          selectedHouseholdItems: selectedHouseholdItems,
          selectedAppliances: selectedAppliances,
          selectedAgriculturalEquipment: selectedAgriculturalEquipment);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          llwdspAssetsKey, jsonEncode(llwdspAssetData.toJson()));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Assets Form Submitted'),
            backgroundColor: Colors.green),
      );

      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pop(context, true);
      });
    }
  }
}

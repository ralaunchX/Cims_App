import 'dart:convert';
import 'dart:io';

import 'package:cims/data_model/asset_details_model.dart';
import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/constants.dart';
import 'package:cims/utils/keys.dart';
import 'package:cims/utils/submit_button.dart';
import 'package:cims/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssetDetailsScreen extends StatefulWidget {
  const AssetDetailsScreen({super.key});

  @override
  State<AssetDetailsScreen> createState() => _AssetDetailsState();
}

class _AssetDetailsState extends State<AssetDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final String rapId = Keys.rapId;
  final String assetDetailsKey = '${Keys.rapId}_${Keys.assetDetails}';
  String assetType = AppConstants.notSelected;
  String assetCategory = AppConstants.notSelected;
  String village = '';
  String gpsCoordinates = '';
  File? _contract;
  File? _affectedAsset;

  late TextEditingController gpsCoordinatesController;

  Future<void> saveForm() async {
    if (_formKey.currentState!.validate()) {
      final dto = AssetDetailsDto(
          rapId: rapId,
          assetType: assetType,
          assetCategory: assetCategory,
          village: village,
          gpsCoordinates: gpsCoordinates,
          affectedPhoto: _affectedAsset?.path,
          contract: _contract?.path);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(assetDetailsKey, jsonEncode(dto.toJson()));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Asset details saved successfully'),
          backgroundColor: Colors.green,
        ),
      );
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pop(context, true);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = AppPrefs().prefs;
    final saved = prefs?.getString(assetDetailsKey);
    if (saved != null) {
      final decoded = jsonDecode(saved);
      final data = AssetDetailsDto.fromJson(decoded);
      setState(() {
        assetType = data.assetType;
        assetCategory = data.assetCategory;
        village = data.village;
        gpsCoordinates = data.gpsCoordinates;
        _contract = data.contract != null ? File(data.contract!) : null;
        _affectedAsset =
            data.affectedPhoto != null ? File(data.affectedPhoto!) : null;
      });
    }
    gpsCoordinatesController = TextEditingController(text: gpsCoordinates);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Asset Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  isExpanded: true,
                  decoration: const InputDecoration(labelText: 'Asset type'),
                  value: assetType,
                  items: AppConstants.assetType
                      .map((type) => DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          ))
                      .toList(),
                  validator: (val) =>
                      (val == null || val == AppConstants.notSelected)
                          ? 'Select'
                          : null,
                  onChanged: (val) => setState(() => assetType = val!),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  isExpanded: true,
                  decoration:
                      const InputDecoration(labelText: 'Asset category'),
                  value: assetCategory,
                  items: AppConstants.assetCategory
                      .map((cat) => DropdownMenuItem(
                            value: cat,
                            child: Text(cat),
                          ))
                      .toList(),
                  onChanged: (val) => setState(() => assetCategory = val!),
                  validator: (val) =>
                      (val == null || val == AppConstants.notSelected)
                          ? 'Select'
                          : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: village,
                  decoration: const InputDecoration(
                      labelText: 'Village', hintText: 'enter village'),
                  onChanged: (val) => village = val.trim(),
                  validator: (val) =>
                      val == null || val.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: gpsCoordinatesController,
                  decoration: InputDecoration(
                    labelText: 'GPS Coordinates',
                    helperText: 'Click on Location Icon To Autofill',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.location_on),
                      onPressed: () async {
                        try {
                          gpsCoordinatesController.text = 'Wait...';

                          final coords = await Utility.getCurrentCoordinates();
                          setState(() {
                            gpsCoordinates = coords!;
                            gpsCoordinatesController.text = gpsCoordinates;
                          });
                        } catch (e) {
                          gpsCoordinatesController.text = gpsCoordinates;

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())),
                          );
                        }
                      },
                    ),
                  ),
                  onChanged: (val) => setState(() => gpsCoordinates = val),
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Upload Asset Contract:',
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () async {
                    final picked = await Utility.pickImageFromGallery();
                    if (picked != null) {
                      setState(() {
                        _contract = picked;
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: _contract == null
                            ? 'No file chosen'
                            : _contract!.path.split('/').last,
                        suffixIcon: ElevatedButton(
                          onPressed: () async {
                            final picked = await Utility.pickImageFromGallery();
                            if (picked != null) {
                              setState(() {
                                _contract = picked;
                              });
                            }
                          },
                          child: Text('Choose file'),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        filled: true,
                      ),
                      readOnly: true,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                if (_contract != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      _contract!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                const SizedBox(height: 16),
                const Text('Upload photographs of affected assets :'),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () async {
                    final picked = await Utility.pickImageFromGallery();
                    if (picked != null) {
                      setState(() {
                        _affectedAsset = picked;
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: _affectedAsset == null
                            ? 'No file chosen'
                            : _affectedAsset!.path.split('/').last,
                        suffixIcon: ElevatedButton(
                          onPressed: () async {
                            final picked = await Utility.pickImageFromGallery();
                            if (picked != null) {
                              setState(() {
                                _affectedAsset = picked;
                              });
                            }
                          },
                          child: Text('Choose file'),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        filled: true,
                      ),
                      readOnly: true,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                if (_affectedAsset != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      _affectedAsset!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                const SizedBox(height: 24),
                CommonSubmitButton(onPressed: saveForm)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

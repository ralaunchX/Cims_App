import 'dart:convert';

import 'package:cims/data_model/llwdsp_assets_model.dart';
import 'package:cims/data_model/llwdsp_social_network_model.dart';
import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/constants.dart';
import 'package:cims/utils/keys.dart';
import 'package:cims/utils/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LlwdspSocialnetworkScreen extends StatefulWidget {
  final LlwdspSocialNetworkModel? llwdspSocialNetworkModel;

  const LlwdspSocialnetworkScreen({super.key, this.llwdspSocialNetworkModel});

  @override
  State<LlwdspSocialnetworkScreen> createState() =>
      _LlwdspSocialnetworkScreenState();
}

class _LlwdspSocialnetworkScreenState extends State<LlwdspSocialnetworkScreen> {
  final _formKey = GlobalKey<FormState>();
  String rapId = Keys.rapId;
  String llwdspSocialNetworkKey = '${Keys.rapId}_${Keys.llwdspSocialNetwork}';
  String? givingSupportCategory = AppConstants.notSelected;
  String? givingSupportFrequency = AppConstants.notSelected;
  String? givingSupportRelation = AppConstants.notSelected;

  String? receivingSupportCategory = AppConstants.notSelected;
  String? receivingSupportFrequency = AppConstants.notSelected;
  String? receivingSupportRelation = AppConstants.notSelected;

  @override
  void initState() {
    super.initState();
    final prefs = AppPrefs().prefs;
    var socialNetworkData = widget.llwdspSocialNetworkModel;
    String? socialNetworkString = prefs?.getString(llwdspSocialNetworkKey);
    if (socialNetworkString != null) {
      final json = jsonDecode(socialNetworkString);
      socialNetworkData = LlwdspSocialNetworkModel.fromJson(json);
    }
    if (socialNetworkData != null) {
      givingSupportCategory = socialNetworkData.givingSupportCategory;
      givingSupportFrequency = socialNetworkData.givingSupportFrequency;
      givingSupportRelation = socialNetworkData.givingSupportRelation;

      receivingSupportCategory = socialNetworkData.receivingSupportCategory;
      receivingSupportFrequency = socialNetworkData.receivingSupportFrequency;
      receivingSupportRelation = socialNetworkData.receivingSupportRelation;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Social Network ${Keys.rapId}"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                  'Q. Ask if this household renders support to another household in this village or elsewhere, what type of support is rendered, the frequency of support, and the household’s relationship to the supported household. MUTIPLE RESPONSES'),
              const SizedBox(height: 24),
              const Text("Household Giving Support",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                decoration:
                    const InputDecoration(labelText: 'Support Category'),
                items: AppConstants.householdGivingSupportChoices
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                value: givingSupportCategory,
                validator: (val) {
                  if (val == null || val == AppConstants.notSelected) {
                    return 'Please Select a Response';
                  }
                  return null;
                },
                onChanged: (value) =>
                    setState(() => givingSupportCategory = value),
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Frequency'),
                items: AppConstants.frequencyChoices
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                value: givingSupportFrequency,
                validator: (val) {
                  if (val == null || val == AppConstants.notSelected) {
                    return 'Please Select a Response';
                  }
                  return null;
                },
                onChanged: (value) =>
                    setState(() => givingSupportFrequency = value),
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                    labelText: 'Relation to Supported Household'),
                items: AppConstants.relationSupportedHouseholdChoices
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                validator: (val) {
                  if (val == null || val == AppConstants.notSelected) {
                    return 'Please Select a Response';
                  }
                  return null;
                },
                value: givingSupportRelation,
                onChanged: (value) =>
                    setState(() => givingSupportRelation = value),
              ),
              const SizedBox(height: 32),
              const Text(
                  'Q.  Ask if this household receives support from another household in this village or elsewhere, what type of support is received, the frequency of support received and the household’s relationship to the household providing support'),
              const SizedBox(height: 24),
              const Text("Household Receiving Support",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                decoration:
                    const InputDecoration(labelText: 'Support Category'),
                items: AppConstants.householdGivingSupportChoices
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                value: receivingSupportCategory,
                validator: (val) {
                  if (val == null || val == AppConstants.notSelected) {
                    return 'Please Select a Response';
                  }
                  return null;
                },
                onChanged: (value) =>
                    setState(() => receivingSupportCategory = value),
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Frequency'),
                items: AppConstants.frequencyChoices
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                value: receivingSupportFrequency,
                validator: (val) {
                  if (val == null || val == AppConstants.notSelected) {
                    return 'Please Select a Response';
                  }
                  return null;
                },
                onChanged: (value) =>
                    setState(() => receivingSupportFrequency = value),
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                    labelText: 'Relation to Supporting Household'),
                items: AppConstants.relationSupportedHouseholdChoices
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                value: receivingSupportRelation,
                validator: (val) {
                  if (val == null || val == AppConstants.notSelected) {
                    return 'Please Select a Response';
                  }
                  return null;
                },
                onChanged: (value) =>
                    setState(() => receivingSupportRelation = value),
              ),
              const SizedBox(height: 24),
              CommonSubmitButton(onPressed: () {
                saveForm();
              })
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveForm() async {
    if (_formKey.currentState!.validate()) {
      final llwdspSocialNetworkData = LlwdspSocialNetworkModel(
          givingSupportCategory: givingSupportCategory,
          givingSupportFrequency: givingSupportFrequency,
          givingSupportRelation: givingSupportRelation,
          receivingSupportCategory: receivingSupportCategory,
          receivingSupportFrequency: receivingSupportFrequency,
          receivingSupportRelation: receivingSupportRelation);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          llwdspSocialNetworkKey, jsonEncode(llwdspSocialNetworkData.toJson()));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Social Network Form Submitted'),
            backgroundColor: Colors.green),
      );
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pop(context, true);
      });
    }
  }
}

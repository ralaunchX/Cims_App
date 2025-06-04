import 'dart:convert';

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

  int givingSupportCategory = 0;
  int givingSupportFrequency = 0;
  int givingSupportRelation = 0;

  int receivingSupportCategory = 0;
  int receivingSupportFrequency = 0;
  int receivingSupportRelation = 0;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    String? socialNetworkString = prefs.getString(llwdspSocialNetworkKey);

    LlwdspSocialNetworkModel? socialNetworkData =
        widget.llwdspSocialNetworkModel;

    if (socialNetworkString != null) {
      final json = jsonDecode(socialNetworkString);
      socialNetworkData = LlwdspSocialNetworkModel.fromJson(json);
    }

    if (socialNetworkData != null) {
      setState(() {
        givingSupportCategory = socialNetworkData!.givingSupportCategory ?? 0;
        givingSupportFrequency = socialNetworkData.givingSupportFrequency ?? 0;
        givingSupportRelation = socialNetworkData.givingSupportRelation ?? 0;

        receivingSupportCategory =
            socialNetworkData.receivingSupportCategory ?? 0;
        receivingSupportFrequency =
            socialNetworkData.receivingSupportFrequency ?? 0;
        receivingSupportRelation =
            socialNetworkData.receivingSupportRelation ?? 0;
      });
    }
  }

  DropdownButtonFormField<int> buildDropdown({
    required String label,
    required int value,
    required Map<int, String> itemsMap,
    required void Function(int?) onChanged,
  }) {
    return DropdownButtonFormField<int>(
      decoration: InputDecoration(labelText: label),
      value: value,
      items: itemsMap.entries
          .map((entry) =>
              DropdownMenuItem<int>(value: entry.key, child: Text(entry.value)))
          .toList(),
      onChanged: onChanged,
      validator: (val) {
        if (val == null || val == 0) {
          return 'Please select a response';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Social Network $rapId"),
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
              buildDropdown(
                label: 'Support Category',
                value: givingSupportCategory,
                itemsMap: AppConstants.householdGivingSupportChoicesMap,
                onChanged: (val) => setState(() {
                  givingSupportCategory = val ?? 0;
                }),
              ),
              buildDropdown(
                label: 'Frequency',
                value: givingSupportFrequency,
                itemsMap: AppConstants.frequencyChoicesMap,
                onChanged: (val) => setState(() {
                  givingSupportFrequency = val ?? 0;
                }),
              ),
              buildDropdown(
                label: 'Relation to Supported Household',
                value: givingSupportRelation,
                itemsMap: AppConstants.relationSupportedHouseholdChoicesMap,
                onChanged: (val) => setState(() {
                  givingSupportRelation = val ?? 0;
                }),
              ),
              const SizedBox(height: 32),
              const Text(
                  'Q.  Ask if this household receives support from another household in this village or elsewhere, what type of support is received, the frequency of support received and the household’s relationship to the household providing support'),
              const SizedBox(height: 24),
              const Text("Household Receiving Support",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              buildDropdown(
                label: 'Support Category',
                value: receivingSupportCategory,
                itemsMap: AppConstants.householdGivingSupportChoicesMap,
                onChanged: (val) => setState(() {
                  receivingSupportCategory = val ?? 0;
                }),
              ),
              buildDropdown(
                label: 'Frequency',
                value: receivingSupportFrequency,
                itemsMap: AppConstants.frequencyChoicesMap,
                onChanged: (val) => setState(() {
                  receivingSupportFrequency = val ?? 0;
                }),
              ),
              buildDropdown(
                label: 'Relation to Supporting Household',
                value: receivingSupportRelation,
                itemsMap: AppConstants.relationSupportedHouseholdChoicesMap,
                onChanged: (val) => setState(() {
                  receivingSupportRelation = val ?? 0;
                }),
              ),
              const SizedBox(height: 24),
              CommonSubmitButton(onPressed: saveForm),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveForm() async {
    if (_formKey.currentState!.validate()) {
      final llwdspSocialNetworkData = LlwdspSocialNetworkModel(
        rapId: rapId,
        givingSupportCategory: givingSupportCategory,
        givingSupportFrequency: givingSupportFrequency,
        givingSupportRelation: givingSupportRelation,
        receivingSupportCategory: receivingSupportCategory,
        receivingSupportFrequency: receivingSupportFrequency,
        receivingSupportRelation: receivingSupportRelation,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        llwdspSocialNetworkKey,
        jsonEncode(llwdspSocialNetworkData.toJson()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Social Network Form Submitted'),
          backgroundColor: Colors.green,
        ),
      );

      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pop(context, true);
      });
    }
  }
}

import 'dart:convert';

import 'package:cims/data_model/llwdsp_transport_model.dart';
import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/constants.dart';
import 'package:cims/utils/keys.dart';
import 'package:cims/utils/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LlwdspTransportScreen extends StatefulWidget {
  final LlwdspTransportModel? llwdspTransportModel;
  const LlwdspTransportScreen({super.key, this.llwdspTransportModel});

  @override
  State<LlwdspTransportScreen> createState() => _LlwdspTransportScreenState();
}

class _LlwdspTransportScreenState extends State<LlwdspTransportScreen> {
  final _formKey = GlobalKey<FormState>();
  String rapId = Keys.rapId;
  String llwdspTransportKey = '${Keys.rapId}_${Keys.llwdspTransport}';
  final _distanceController = TextEditingController();

  String transportFrequency = AppConstants.notSelected;
  final Map<String, String> destinationToKey = {
    'School': 'school_transport',
    'Health facility (Clinic, Hospital, Chemist)': 'health_transport',
    'Shops (groceries, farm supplies, etc.)': 'shops_transport',
    'Roller mill': 'roller_mill_transport',
    'Community Council offices': 'community_council_transport',
    'Police': 'police_transport',
  };

  Map<String, String> transportModes = {};

  @override
  void initState() {
    super.initState();
    transportModes = {
      for (var key in destinationToKey.values) key: AppConstants.notSelected,
    };

    final prefs = AppPrefs().prefs;
    var llwdspTransportData = widget.llwdspTransportModel;
    String? llwdspTransportString = prefs?.getString(llwdspTransportKey);
    if (llwdspTransportString != null) {
      final json = jsonDecode(llwdspTransportString);
      llwdspTransportData = LlwdspTransportModel.fromJson(json);
    }
    if (llwdspTransportData != null) {
      _distanceController.text = llwdspTransportData.distanceToTransport;
      transportFrequency = llwdspTransportData.transportFrequency;
      transportModes = llwdspTransportData.transportModes;
    }
  }

  @override
  void dispose() {
    _distanceController.dispose();
    super.dispose();
  }

  Future<void> submitForm() async {
    if (_formKey.currentState!.validate()) {
      final llwdspTransportData = LlwdspTransportModel(
        rapId: rapId,
        distanceToTransport: _distanceController.text,
        transportFrequency: transportFrequency,
        transportModes: transportModes,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        llwdspTransportKey,
        jsonEncode(llwdspTransportData.toJson()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Transport Form Submitted'),
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
      appBar: AppBar(title: const Text('Transport Survey')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Distance to Public Transport (In Minutes)'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _distanceController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) =>
                      val == null || val.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 24),
                const Text(
                  'How often is public transport available?',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...AppConstants.transportFrequency.map((option) {
                  return RadioListTile<String>(
                    title: Text(option),
                    value: option,
                    groupValue: transportFrequency,
                    onChanged: (val) =>
                        setState(() => transportFrequency = val!),
                  );
                }).toList(),
                const SizedBox(height: 24),
                const Text(
                  'Transport Modes for Different Destinations',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Table(
                  border: TableBorder.all(),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(2),
                  },
                  children: [
                    const TableRow(
                      decoration: BoxDecoration(color: Colors.blue),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Destination',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Mode of Transport',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    ...destinationToKey.entries.map((entry) {
                      final label = entry.key;
                      final key = entry.value;

                      return TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(label),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              validator: (val) => (val == null ||
                                      val == AppConstants.notSelected)
                                  ? 'Please select'
                                  : null,
                              value: transportModes[key],
                              items: AppConstants.transportModes
                                  .map((mode) => DropdownMenuItem(
                                        value: mode,
                                        child: Text(mode),
                                      ))
                                  .toList(),
                              onChanged: (val) {
                                setState(() {
                                  transportModes[key] = val!;
                                });
                              },
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder()),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
                const SizedBox(height: 24),
                CommonSubmitButton(onPressed: () {
                  submitForm();
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

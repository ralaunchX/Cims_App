import 'dart:convert';
import 'package:cims/data_model/llwdsp_enegysource_model.dart';
import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/keys.dart';
import 'package:cims/utils/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LlwdspEnergysourcesScreen extends StatefulWidget {
  const LlwdspEnergysourcesScreen({super.key});

  @override
  State<LlwdspEnergysourcesScreen> createState() =>
      _LlwdspEnergysourcesScreenState();
}

class _LlwdspEnergysourcesScreenState extends State<LlwdspEnergysourcesScreen> {
  final _formKey = GlobalKey<FormState>();
  final String rapId = Keys.rapId;
  final String llwdspEnergySourceKey =
      '${Keys.rapId}_${Keys.llwdspEnergySources}';
  EnergySourcesDto energySources = EnergySourcesDto(
      rapId: '',
      electricityLighting: "No",
      gasLighting: "No",
      paraffinLighting: "No",
      woodLighting: "No",
      candleLighting: "No",
      batteryLighting: "No",
      solarLighting: "No",
      generatorLighting: "No",
      brushwoodLighting: "No",
      electricityCooking: "No",
      gasCooking: "No",
      paraffinCooking: "No",
      woodCooking: "No",
      batteryCooking: "No",
      generatorCooking: "No");

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final prefs = AppPrefs().prefs;
    final data = prefs?.getString(llwdspEnergySourceKey);
    if (data != null) {
      setState(() {
        energySources = EnergySourcesDto.fromJson(jsonDecode(data));
      });
    }
  }

  Future<void> saveForm() async {
    if (_formKey.currentState!.validate()) {
      final data = energySources;
      energySources.rapId = rapId;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(llwdspEnergySourceKey, jsonEncode(data.toJson()));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Energy Info Saved'),
          backgroundColor: Colors.green,
        ),
      );
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pop(context, true);
      });
    }
  }

  Widget _buildRadioRow(
      String label, String? value, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(label)),
          Row(
            children: [
              Radio<String>(
                value: "Yes",
                groupValue: value,
                onChanged: (val) => onChanged(val!),
              ),
              const Text("Yes"),
              Radio<String>(
                value: "No",
                groupValue: value,
                onChanged: (val) => onChanged(val!),
              ),
              const Text("No"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColumn(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const Divider(),
          ...children,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Energy Sources Survey")),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildColumn("Lighting Sources", [
                  _buildRadioRow(
                      "Electricity",
                      energySources.electricityLighting,
                      (val) => setState(
                          () => energySources.electricityLighting = val)),
                  _buildRadioRow("Gas", energySources.gasLighting,
                      (val) => setState(() => energySources.gasLighting = val)),
                  _buildRadioRow(
                      "Paraffin",
                      energySources.paraffinLighting,
                      (val) =>
                          setState(() => energySources.paraffinLighting = val)),
                  _buildRadioRow(
                      "Wood",
                      energySources.woodLighting,
                      (val) =>
                          setState(() => energySources.woodLighting = val)),
                  _buildRadioRow(
                      "Candle",
                      energySources.candleLighting,
                      (val) =>
                          setState(() => energySources.candleLighting = val)),
                  _buildRadioRow(
                      "Battery",
                      energySources.batteryLighting,
                      (val) =>
                          setState(() => energySources.batteryLighting = val)),
                  _buildRadioRow(
                      "Solar",
                      energySources.solarLighting,
                      (val) =>
                          setState(() => energySources.solarLighting = val)),
                  _buildRadioRow(
                      "Generator",
                      energySources.generatorLighting,
                      (val) => setState(
                          () => energySources.generatorLighting = val)),
                  _buildRadioRow(
                      "Brushwood",
                      energySources.brushwoodLighting,
                      (val) => setState(
                          () => energySources.brushwoodLighting = val)),
                ]),
                _buildColumn("Cooking Sources", [
                  _buildRadioRow(
                      "Electricity",
                      energySources.electricityCooking,
                      (val) => setState(
                          () => energySources.electricityCooking = val)),
                  _buildRadioRow("Gas", energySources.gasCooking,
                      (val) => setState(() => energySources.gasCooking = val)),
                  _buildRadioRow(
                      "Paraffin",
                      energySources.paraffinCooking,
                      (val) =>
                          setState(() => energySources.paraffinCooking = val)),
                  _buildRadioRow("Wood", energySources.woodCooking,
                      (val) => setState(() => energySources.woodCooking = val)),
                  _buildRadioRow(
                      "Battery",
                      energySources.batteryCooking,
                      (val) =>
                          setState(() => energySources.batteryCooking = val)),
                  _buildRadioRow(
                      "Generator",
                      energySources.generatorCooking,
                      (val) =>
                          setState(() => energySources.generatorCooking = val)),
                ]),
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

import 'dart:convert';

import 'package:cims/data_model/llwdsp_livestock_model.dart';
import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/keys.dart';
import 'package:cims/utils/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LlwdspLivestockScreen extends StatefulWidget {
  final LlwdspLivestockListDto? llwdspLivestockListDto;

  const LlwdspLivestockScreen({super.key, this.llwdspLivestockListDto});

  @override
  State<LlwdspLivestockScreen> createState() => _LlwdspLivestockScreenState();
}

class _LlwdspLivestockScreenState extends State<LlwdspLivestockScreen> {
  String rapId = Keys.rapId;
  String llwdspLivestockKey = '${Keys.rapId}_${Keys.llwdspLivestock}';
  final List<String> livestockTypes = [
    'Bulls',
    'Cows',
    'Oxen',
    'Calves',
    'Rams',
    'Ewes',
    'Lambs',
    'Buck',
    'Does',
    'Kids',
    'Horse',
    'Donkey',
    'Pig',
    'Chicken',
    'Duck',
    'Geese',
    'Rabbit',
  ];

  List<LlwdspLivestockDto> livestockData = [];

  @override
  void initState() {
    super.initState();
    livestockData = livestockTypes
        .map((e) => LlwdspLivestockDto(
              type: e,
              owned: 0,
              died: 0,
              slaughtered: 0,
              sold: 0,
              stolen: 0,
              price: 0,
            ))
        .toList();

    final prefs = AppPrefs().prefs;
    var storedData = widget.llwdspLivestockListDto;
    String? livestockString = prefs?.getString(llwdspLivestockKey);
    if (livestockString != null) {
      final json = jsonDecode(livestockString);
      storedData = LlwdspLivestockListDto.fromJson(json);
    }
    if (storedData != null) {
      livestockData = storedData.livestock;
    }
  }

  Widget buildTable(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            const Divider(),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        _HeaderCell('Type', width: 100),
                        _HeaderCell('Owned'),
                        _HeaderCell('Sold (2024)'),
                        _HeaderCell('Slaughtered (2024)'),
                        _HeaderCell('Stolen (2024)'),
                        _HeaderCell('Died (2024)'),
                        _HeaderCell('Price per Unit'),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: livestockData.map((entry) {
                            return Row(
                              children: [
                                SizedBox(width: 100, child: Text(entry.type)),
                                buildNumberField(entry, 'owned'),
                                buildNumberField(entry, 'sold'),
                                buildNumberField(entry, 'slaughtered'),
                                buildNumberField(entry, 'stolen'),
                                buildNumberField(entry, 'died'),
                                buildNumberField(entry, 'price'),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildNumberField(LlwdspLivestockDto entry, String field) {
    return SizedBox(
      width: 120,
      child: TextFormField(
        initialValue: _getFieldValue(entry, field).toString(),
        keyboardType: TextInputType.number,
        onChanged: (val) {
          setState(() {
            _setFieldValue(entry, field, int.tryParse(val) ?? 0);
          });
        },
      ),
    );
  }

  int _getFieldValue(LlwdspLivestockDto entry, String field) {
    switch (field) {
      case 'owned':
        return entry.owned;
      case 'sold':
        return entry.sold;
      case 'slaughtered':
        return entry.slaughtered;
      case 'stolen':
        return entry.stolen;
      case 'died':
        return entry.died;
      case 'price':
        return entry.price;
      default:
        return 0;
    }
  }

  void _setFieldValue(LlwdspLivestockDto entry, String field, int value) {
    switch (field) {
      case 'owned':
        entry.owned = value;
        break;
      case 'sold':
        entry.sold = value;
        break;
      case 'slaughtered':
        entry.slaughtered = value;
        break;
      case 'stolen':
        entry.stolen = value;
        break;
      case 'died':
        entry.died = value;
        break;
      case 'price':
        entry.price = 0;
        break;
    }
  }

  Future<void> saveForm() async {
    final listOfLivestockData =
        LlwdspLivestockListDto(rapId: rapId, livestock: livestockData);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        llwdspLivestockKey, jsonEncode(listOfLivestockData.toJson()));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('LiveStock Form Submitted'),
          backgroundColor: Colors.green),
    );
    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.pop(context, true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Livestock Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Center(
              child: Text(
                'Livestock Details Form',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(child: buildTable(context)),
            const SizedBox(height: 16),
            CommonSubmitButton(onPressed: () {
              saveForm();
            })
          ],
        ),
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String label;
  final double width;

  const _HeaderCell(this.label, {this.width = 120, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

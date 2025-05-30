import 'dart:convert';
import 'dart:developer';

import 'package:cims/data_model/llwdsp_fruittree_model.dart';
import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/constants.dart';
import 'package:cims/utils/keys.dart';
import 'package:cims/utils/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LlwdspFruitTressScreen extends StatefulWidget {
  final LlwdspFruitTreeList? llwdspFruitTreeList;
  const LlwdspFruitTressScreen({super.key, this.llwdspFruitTreeList});

  @override
  State<LlwdspFruitTressScreen> createState() => _LlwdspFruitTressScreenState();
}

class _LlwdspFruitTressScreenState extends State<LlwdspFruitTressScreen> {
  final _formKey = GlobalKey<FormState>();
  String rapId = Keys.rapId;
  String llwdspFruitTreesKey = '${Keys.rapId}_${Keys.llwdspFruitTrees}';

  List<FruitTreeDto> treeList = [
    FruitTreeDto(type: AppConstants.notSelected, numberOwned: 0, use: '')
  ];

  void _addMoreTrees() {
    setState(() {
      treeList.add(FruitTreeDto(type: '', numberOwned: 0, use: ''));
    });
  }

  @override
  void initState() {
    super.initState();
    final prefs = AppPrefs().prefs;
    var fruitTreeData = widget.llwdspFruitTreeList;
    String? fruitTreeString = prefs?.getString(llwdspFruitTreesKey);
    if (fruitTreeString != null) {
      final json = jsonDecode(fruitTreeString);
      fruitTreeData = LlwdspFruitTreeList.fromJson(json);
    }
    if (fruitTreeData != null) {
      treeList = fruitTreeData.trees;
    }
  }

  Future<void> saveForm() async {
    if (_formKey.currentState!.validate()) {
      final LlwdspFruitTreeData =
          LlwdspFruitTreeList(rapId: rapId, trees: treeList);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          llwdspFruitTreesKey, jsonEncode(LlwdspFruitTreeData.toJson()));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Fruit Trees Form Submitted'),
            backgroundColor: Colors.green),
      );
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pop(context, true);
      });
    }
  }

  Widget _buildTreeRow(FruitTreeDto tree, int index) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: DropdownButtonFormField<String>(
              isExpanded: true,
              value: tree.type.isEmpty ? null : tree.type,
              items: AppConstants.treeTypes
                  .map((type) =>
                      DropdownMenuItem(value: type, child: Text(type)))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  tree.type = val!;
                });
              },
              validator: (val) {
                if (val == null || val == AppConstants.notSelected) {
                  return 'Select Tree Type';
                }
                return null;
              },
            ),
          ),
          SizedBox(
            width: 100,
            height: 40,
            child: TextFormField(
              initialValue: tree.numberOwned.toString(),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (val) {
                tree.numberOwned = int.tryParse(val) ?? 0;
              },
            ),
          ),
          SizedBox(width: 150, child: _buildRadio(tree, 'all_consumed', index)),
          SizedBox(
              width: 180, child: _buildRadio(tree, 'mostly_consumed', index)),
          SizedBox(width: 180, child: _buildRadio(tree, 'mostly_sold', index)),
          IconButton(
            icon: const Icon(Icons.remove_circle, color: Colors.red),
            onPressed: () => setState(() => treeList.removeAt(index)),
          ),
        ],
      ),
    );
  }

  Widget _buildRadio(FruitTreeDto tree, String value, int index) {
    String label = {
      'all_consumed': 'All consumed',
      'mostly_consumed': 'Most consumed,\nsome sold',
      'mostly_sold': 'Most sold,\nsome consumed'
    }[value]!;

    return RadioListTile<String>(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(label, style: const TextStyle(fontSize: 16)),
      value: value,
      groupValue: tree.use,
      onChanged: (val) {
        setState(() {
          tree.use = val!;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fruit Tree Table')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                height: 50,
                color: Colors.blue,
                child: const Row(
                  children: [
                    Text('Type of Tree',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 40),
                    Text('Number Owned',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 20),
                    Text('Use', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: treeList.length,
                  itemBuilder: (context, index) =>
                      _buildTreeRow(treeList[index], index),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 3),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _addMoreTrees,
                    icon: const Icon(Icons.add),
                    label: const Text("Add More Trees"),
                  ),
                  const SizedBox(width: 20),
                  CommonSubmitButton(onPressed: saveForm)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

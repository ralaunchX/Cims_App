import 'dart:convert';
import 'package:cims/data_model/llwdsp_additionalinfo_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cims/utils/submit_button.dart';
import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/keys.dart';

class LlwdspHouseholdadditionalinfoScreen extends StatefulWidget {
  const LlwdspHouseholdadditionalinfoScreen({super.key});

  @override
  State<LlwdspHouseholdadditionalinfoScreen> createState() =>
      _LlwdspHouseholdadditionalinfoScreeState();
}

class _LlwdspHouseholdadditionalinfoScreeState
    extends State<LlwdspHouseholdadditionalinfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController projectCommentController =
      TextEditingController();
  final TextEditingController interviewerCommentController =
      TextEditingController();
  final String rapId = Keys.rapId;
  final String llwdspAdditionalInfoKey =
      '${Keys.rapId}_${Keys.llwdspAdditionalInfo}';

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final prefs = AppPrefs().prefs;
    final data = prefs?.getString(llwdspAdditionalInfoKey);
    if (data != null) {
      final dto = HouseholdAdditionalInfoDto.fromJson(jsonDecode(data));
      setState(() {
        projectCommentController.text = dto.projectComments ?? '';
        interviewerCommentController.text = dto.interviewerComments ?? '';
      });
    }
  }

  Future<void> saveForm() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      final dto = HouseholdAdditionalInfoDto(
        rapId: rapId,
        projectComments: projectCommentController.text.trim(),
        interviewerComments: interviewerCommentController.text.trim(),
      );
      await prefs.setString(llwdspAdditionalInfoKey, jsonEncode(dto.toJson()));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Additional Comments Saved'),
          backgroundColor: Colors.green,
        ),
      );

      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pop(context, true);
      });
    }
  }

  Widget _buildCommentField(
      String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: 5,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          ),
          validator: (value) => null, // Optional validation
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Resettlement Survey Form Additional Comments')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildCommentField(
                  "Comments about the Project",
                  "Enter any comments about the Project",
                  projectCommentController,
                ),
                _buildCommentField(
                  "Interviewer Comments",
                  "Enter additional interviewer comments",
                  interviewerCommentController,
                ),
                const SizedBox(height: 24),
                CommonSubmitButton(onPressed: saveForm),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

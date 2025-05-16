import 'dart:convert';
import 'package:cims/data_model/resettlement_llwdsp.dart';
import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/keys.dart';
import 'package:cims/utils/submit_button.dart';
import 'package:cims/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LlwdspResettlement extends StatefulWidget {
  final ResettlementLlwdspModel? resettlementLlwdspModel;
  const LlwdspResettlement({super.key, this.resettlementLlwdspModel});

  @override
  State<LlwdspResettlement> createState() => _LlwdspResettlementState();
}

class _LlwdspResettlementState extends State<LlwdspResettlement> {
  final _formKey = GlobalKey<FormState>();
  String rapId = Keys.rapId;
  String llwdspResettlementKey = '${Keys.rapId}_${Keys.llwdspResettlement}';

  String interviewerName = '';
  String village = '';
  String communityCouncil = '';
  String householdNumber = '';
  String householdHead = '';
  String respondentName = '';
  String contactNumber = '';
  String date = '';
  bool isHeadOrSpousePresent = false;
  String ifNotPresentRecord = '';
  String gpsNorthing = '';
  String gpsEasting = '';

  final FocusNode interviewerNameFocus = FocusNode();
  final FocusNode villageFocus = FocusNode();
  final FocusNode communityCouncilFocus = FocusNode();
  final FocusNode householdNumberFocus = FocusNode();
  final FocusNode householdHeadFocus = FocusNode();
  final FocusNode respondentNameFocus = FocusNode();
  final FocusNode contactNumberFocus = FocusNode();
  final FocusNode dateFocus = FocusNode();
  final FocusNode ifNotPresentRecordFocus = FocusNode();
  final FocusNode gpsNorthingFocus = FocusNode();
  final FocusNode gpsEastingFocus = FocusNode();
  late TextEditingController dateController;

  @override
  void initState() {
    super.initState();
    final prefs = AppPrefs().prefs;
    var resettlementData = widget.resettlementLlwdspModel;
    String? resettlementString = prefs?.getString(llwdspResettlementKey);
    if (resettlementString != null) {
      final json = jsonDecode(resettlementString);
      resettlementData = ResettlementLlwdspModel.fromJson(json);
    }
    if (resettlementData != null) {
      interviewerName = resettlementData.interviewerName;
      village = resettlementData.village;
      communityCouncil = resettlementData.communityCouncil;
      householdNumber = resettlementData.householdNumber;
      householdHead = resettlementData.householdHead;
      respondentName = resettlementData.respondentName;
      contactNumber = resettlementData.contactNumber;
      date = resettlementData.date;
      isHeadOrSpousePresent = resettlementData.isHeadOrSpousePresent;
      ifNotPresentRecord = resettlementData.ifNotPresentRecord;
      gpsNorthing = resettlementData.gpsNorthing;
      gpsEasting = resettlementData.gpsEasting;
    }
    dateController = TextEditingController(text: date);
  }

  @override
  void dispose() {
    interviewerNameFocus.dispose();
    villageFocus.dispose();
    communityCouncilFocus.dispose();
    householdNumberFocus.dispose();
    householdHeadFocus.dispose();
    respondentNameFocus.dispose();
    contactNumberFocus.dispose();
    dateFocus.dispose();
    ifNotPresentRecordFocus.dispose();
    gpsNorthingFocus.dispose();
    gpsEastingFocus.dispose();
    dateController.dispose();

    super.dispose();
  }

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      final llwdspResettlementData = ResettlementLlwdspModel(
          interviewerName: interviewerName,
          village: village,
          communityCouncil: communityCouncil,
          householdNumber: householdNumber,
          householdHead: householdHead,
          respondentName: respondentName,
          contactNumber: contactNumber,
          date: date,
          isHeadOrSpousePresent: isHeadOrSpousePresent,
          ifNotPresentRecord: ifNotPresentRecord,
          gpsNorthing: gpsNorthing,
          gpsEasting: gpsEasting);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          llwdspResettlementKey, jsonEncode(llwdspResettlementData.toJson()));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Resettlement Form Submitted'),
            backgroundColor: Colors.green),
      );

      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pop(context, true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              const Text('LLWDSP Phase III Resettlement Action Plan Survey')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: interviewerName,
                decoration:
                    const InputDecoration(labelText: 'Name of Interviewer'),
                onChanged: (val) => interviewerName = val,
                validator: (val) => val!.isEmpty ? 'Required' : null,
                focusNode: interviewerNameFocus,
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                initialValue: village,
                decoration: const InputDecoration(labelText: 'Village'),
                onChanged: (val) => village = val,
                validator: (val) => val!.isEmpty ? 'Required' : null,
                focusNode: villageFocus,
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                initialValue: communityCouncil,
                decoration:
                    const InputDecoration(labelText: 'Community Council'),
                onChanged: (val) => communityCouncil = val,
                validator: (val) => val!.isEmpty ? 'Required' : null,
                focusNode: communityCouncilFocus,
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                initialValue: householdNumber,
                decoration: const InputDecoration(
                    labelText: 'Household Number LLWDSP III HH No.'),
                onChanged: (val) => householdNumber = val,
                validator: (val) => val!.isEmpty ? 'Required' : null,
                focusNode: householdNumberFocus,
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                initialValue: householdHead,
                decoration: const InputDecoration(labelText: 'Household Head'),
                onChanged: (val) => householdHead = val,
                validator: (val) => val!.isEmpty ? 'Required' : null,
                focusNode: householdHeadFocus,
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                initialValue: respondentName,
                decoration:
                    const InputDecoration(labelText: 'Name of Respondent'),
                onChanged: (val) => respondentName = val,
                validator: (val) => val!.isEmpty ? 'Required' : null,
                focusNode: respondentNameFocus,
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                initialValue: contactNumber,
                decoration: const InputDecoration(labelText: 'Contact Number'),
                onChanged: (val) => contactNumber = val,
                validator: (val) => val!.isEmpty ? 'Required' : null,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                focusNode: contactNumberFocus,
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Date',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () async {
                  final selected = await Utility.selectDate(context);
                  if (selected != null) {
                    setState(() {
                      date = selected;
                      dateController.text = selected;
                    });
                  }
                },
                readOnly: true,
                validator: (val) => val!.isEmpty ? 'Required' : null,
                focusNode: dateFocus,
                textInputAction: TextInputAction.next,
                controller: dateController,
              ),
              const SizedBox(height: 12),
              CheckboxListTile(
                  title: const Text('Is household head or spouse present?'),
                  value: isHeadOrSpousePresent,
                  onChanged: (val) {
                    setState(() => isHeadOrSpousePresent = val!);
                    FocusScope.of(context).requestFocus(
                      isHeadOrSpousePresent
                          ? gpsNorthingFocus
                          : ifNotPresentRecordFocus,
                    );
                  }),
              Visibility(
                visible: isHeadOrSpousePresent == false,
                child: TextFormField(
                  focusNode: ifNotPresentRecordFocus,
                  textInputAction: TextInputAction.next,
                  initialValue: ifNotPresentRecord,
                  decoration:
                      const InputDecoration(labelText: 'If NO, record:'),
                  onChanged: (val) => ifNotPresentRecord = val,
                  validator: (val) {
                    if (!isHeadOrSpousePresent && val!.isEmpty) {
                      return 'Required when not present';
                    }
                    return null;
                  },
                ),
              ),
              TextFormField(
                focusNode: gpsNorthingFocus,
                textInputAction: TextInputAction.next,
                initialValue: gpsNorthing,
                decoration: const InputDecoration(labelText: 'GPS Northing'),
                onChanged: (val) => gpsNorthing = val,
              ),
              TextFormField(
                focusNode: gpsEastingFocus,
                textInputAction: TextInputAction.next,
                initialValue: gpsEasting,
                decoration: const InputDecoration(labelText: 'GPS Easting'),
                onChanged: (val) => gpsEasting = val,
              ),
              const SizedBox(height: 30),
              CommonSubmitButton(
                onPressed: _saveForm,
              )
            ],
          ),
        ),
      ),
    );
  }
}

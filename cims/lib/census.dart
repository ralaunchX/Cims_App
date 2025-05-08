import 'dart:convert';
import 'dart:developer';

import 'package:cims/data_model/census_household.dart';
import 'package:cims/data_model/census_institution.dart';
import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/keys.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils/constants.dart';

class CensusFormsScreen extends StatefulWidget {
  const CensusFormsScreen({super.key});

  @override
  State<CensusFormsScreen> createState() => _CensusFormsScreenState();
}

class _CensusFormsScreenState extends State<CensusFormsScreen> {
  final List<Map<String, dynamic>> censusForms = [
    {
      'title': 'Census Household Form',
      'widget': const CensusHouseholdFormScreen(),
    },
    {
      'title': 'Census Institution Form',
      'widget': const CensusInstitutionFormScreen(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Census Forms')),
      body: ListView.builder(
        itemCount: censusForms.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: ListTile(
              leading: const Icon(Icons.description),
              title: Text(censusForms[index]['title']),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => censusForms[index]['widget'],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class CensusHouseholdFormScreen extends StatefulWidget {
  final CensusHousehold? existingHousehold;

  const CensusHouseholdFormScreen({super.key, this.existingHousehold});

  @override
  State<CensusHouseholdFormScreen> createState() =>
      _CensusHouseholdFormScreenState();
}

class _CensusHouseholdFormScreenState extends State<CensusHouseholdFormScreen> {
  final _formKey = GlobalKey<FormState>();

  String idType = 'None';
  String spouseIdType = 'None';
  String maritalStatus = 'Single';
  String marriageType = 'In Community of Property';
  String district = 'Botha-Bothe';
  String route = 'Select a Route';
  String communityCouncil = 'Community Council 1';

  String idNumber = '';
  String idExpiryDate = '';
  String spouseIdNumber = '';
  String spouseIdExpiryDate = '';
  String spouseFirstName = '';
  String spouseSurname = '';
  String householdHeadFirstName = '';
  String householdHeadSurname = '';
  String gender = 'Male';
  String contactCell = '';
  String principalChief = '';
  String villageChief = '';
  String gpsCoordinates = '';

  bool get showIdFields => idType != 'None';
  bool get showSpouseIdFields => spouseIdType != 'None';
  bool get showSpouseForm => maritalStatus != 'Single';
  String censusHouseKey = '${Keys.rapId}_${Keys.censusHousehold}';

  @override
  void initState() {
    super.initState();
    var householdData = widget.existingHousehold;
    final prefs = AppPrefs().prefs;

    if (householdData == null) {
      String? houseHoldString = prefs?.getString(censusHouseKey);
      if (houseHoldString != null) {
        final json = jsonDecode(houseHoldString);
        householdData = CensusHousehold.fromJson(json);
      }
    }

    if (householdData != null) {
      idType = householdData.idType;
      spouseIdType = householdData.spouseIdType;
      maritalStatus = householdData.maritalStatus;
      marriageType = householdData.marriageType;
      district = householdData.district;
      route = householdData.route;
      communityCouncil = householdData.communityCouncil;

      idNumber = householdData.idNumber;
      idExpiryDate = householdData.idExpiryDate;
      spouseIdNumber = householdData.spouseIdNumber;
      spouseIdExpiryDate = householdData.spouseIdExpiryDate;
      spouseFirstName = householdData.spouseFirstName;
      spouseSurname = householdData.spouseSurname;
      householdHeadFirstName = householdData.householdHeadFirstName;
      householdHeadSurname = householdData.householdHeadSurname;
      gender = householdData.gender;
      contactCell = householdData.contactCell;
      principalChief = householdData.principalChief;
      villageChief = householdData.villageChief;
      gpsCoordinates = householdData.gpsCoordinates;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Census Household Form')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Household Head Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextFormField(
                initialValue: householdHeadFirstName,
                decoration: const InputDecoration(
                    labelText: 'Household Head First Name'),
                onChanged: (val) =>
                    setState(() => householdHeadFirstName = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                initialValue: householdHeadSurname,
                decoration: const InputDecoration(labelText: 'Head Surname'),
                onChanged: (val) => setState(() => householdHeadSurname = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Gender'),
                value: gender,
                items: ['Male', 'Female', 'Other']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  setState(() => gender = value!);
                },
                validator: (val) => val == null ? 'Required' : null,
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'ID Type'),
                value: idType,
                items: AppConstants.idTypes
                    .map((e) =>
                        DropdownMenuItem<String>(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  setState(() => idType = value!);
                },
                validator: (val) => val == null ? 'Required' : null,
              ),
              if (showIdFields) ...[
                TextFormField(
                  initialValue: idNumber,
                  decoration: const InputDecoration(labelText: 'ID Number'),
                  onChanged: (val) => setState(() => idNumber = val),
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  initialValue: idExpiryDate,
                  decoration:
                      const InputDecoration(labelText: 'ID Expiry Date'),
                  onChanged: (val) => setState(() => idExpiryDate = val),
                ),
              ],
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Marital Status'),
                value: maritalStatus,
                items: AppConstants.maritalStatuses
                    .map((e) =>
                        DropdownMenuItem<String>(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  setState(() => maritalStatus = value!);
                },
                validator: (val) => val == null ? 'Required' : null,
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Marriage Type'),
                value: marriageType,
                items: AppConstants.marriageTypes
                    .map((e) =>
                        DropdownMenuItem<String>(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  setState(() => marriageType = value!);
                },
                validator: (val) => val == null ? 'Required' : null,
              ),
              TextFormField(
                initialValue: contactCell,
                decoration: const InputDecoration(labelText: 'Contact Cell'),
                onChanged: (val) => setState(() => contactCell = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              const Text('Household Location Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                decoration:
                    const InputDecoration(labelText: 'Community Council'),
                value: communityCouncil,
                items: AppConstants.communityCouncils
                    .map((e) =>
                        DropdownMenuItem<String>(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  setState(() => communityCouncil = value!);
                },
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'District'),
                value: district,
                items: AppConstants.districts
                    .map((e) =>
                        DropdownMenuItem<String>(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  setState(() => district = value!);
                },
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Route Name'),
                value: route,
                items: AppConstants.routes
                    .map((e) =>
                        DropdownMenuItem<String>(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  setState(() => route = value!);
                },
              ),
              TextFormField(
                initialValue: principalChief,
                decoration: const InputDecoration(labelText: 'Principal Chief'),
                onChanged: (val) => setState(() => principalChief = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                initialValue: villageChief,
                decoration:
                    const InputDecoration(labelText: 'Village Chief/Headman'),
                onChanged: (val) => setState(() => villageChief = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                initialValue: gpsCoordinates,
                decoration: const InputDecoration(labelText: 'GPS Coordinates'),
                onChanged: (val) => setState(() => gpsCoordinates = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              if (showSpouseForm) ...[
                const SizedBox(height: 20),
                const Text('Spouse Details',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextFormField(
                  initialValue: spouseFirstName,
                  decoration:
                      const InputDecoration(labelText: 'Spouse First Name'),
                  onChanged: (val) => setState(() => spouseFirstName = val),
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  initialValue: spouseSurname,
                  decoration:
                      const InputDecoration(labelText: 'Spouse Surname'),
                  onChanged: (val) => setState(() => spouseSurname = val),
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                ),
                DropdownButtonFormField<String>(
                  decoration:
                      const InputDecoration(labelText: 'Spouse ID Type'),
                  value: spouseIdType,
                  items: AppConstants.idTypes
                      .map((e) =>
                          DropdownMenuItem<String>(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    setState(() => spouseIdType = value!);
                  },
                ),
                if (showSpouseIdFields) ...[
                  TextFormField(
                    initialValue: spouseIdNumber,
                    decoration:
                        const InputDecoration(labelText: 'Spouse ID Number'),
                    onChanged: (val) => setState(() => spouseIdNumber = val),
                    validator: (val) => val!.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    initialValue: spouseIdExpiryDate,
                    decoration: const InputDecoration(
                        labelText: 'Spouse ID Expiry Date'),
                    onChanged: (val) =>
                        setState(() => spouseIdExpiryDate = val),
                  ),
                ],
              ],
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final household = CensusHousehold(
                        householdHeadFirstName: householdHeadFirstName,
                        householdHeadSurname: householdHeadSurname,
                        gender: gender,
                        idType: idType,
                        idNumber: idNumber,
                        idExpiryDate: idExpiryDate,
                        maritalStatus: maritalStatus,
                        marriageType: marriageType,
                        contactCell: contactCell,
                        communityCouncil: communityCouncil,
                        district: district,
                        route: route,
                        principalChief: principalChief,
                        villageChief: villageChief,
                        gpsCoordinates: gpsCoordinates,
                        spouseFirstName: spouseFirstName,
                        spouseSurname: spouseSurname,
                        spouseIdType: spouseIdType,
                        spouseIdNumber: spouseIdNumber,
                        spouseIdExpiryDate: spouseIdExpiryDate,
                      );
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString(
                          censusHouseKey, jsonEncode(household.toJson()));

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Form Submitted')),
                      );
                    }
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
}

class CensusInstitutionFormScreen extends StatefulWidget {
  final CensusInstitution? existingInstitution;

  const CensusInstitutionFormScreen({super.key, this.existingInstitution});

  @override
  State<CensusInstitutionFormScreen> createState() =>
      _CensusInstitutionFormScreenState();
}

class _CensusInstitutionFormScreenState
    extends State<CensusInstitutionFormScreen> {
  final _formKey = GlobalKey<FormState>();

  String institutionName = '';
  String institutionType = 'Business';
  String responsibleFirstName = '';
  String responsibleSurname = '';
  String physicalAddress = '';
  String postalAddress = '';
  String contactCell = '';

  String communityCouncil = 'Community Council 1';
  String district = 'Botha-Bothe';
  String villageName = '';
  String route = 'Select a Route';
  String principalChief = '';
  String villageChief = '';
  String gpsCoordinates = '';

  String communityResponsibleFirstName = '';
  String communityResponsibleSurname = '';
  String communityContactCell = '';

  String censusInstituteKey = '${Keys.rapId}_${Keys.censusInstitution}';

  @override
  void initState() {
    super.initState();
    var instituteData = widget.existingInstitution;
    final prefs = AppPrefs().prefs;

    if (instituteData == null) {
      String? institutionString = prefs?.getString(censusInstituteKey);
      if (institutionString != null) {
        final json = jsonDecode(institutionString);
        instituteData = CensusInstitution.fromJson(json);
      }
    }
    if (instituteData != null) {
      institutionName = instituteData.name;
      institutionType = instituteData.type;
      responsibleFirstName = instituteData.responsibleFirstName;
      responsibleSurname = instituteData.responsibleSurname;
      physicalAddress = instituteData.physicalAddress;
      postalAddress = instituteData.postalAddress;
      contactCell = instituteData.contactCell;

      communityCouncil = instituteData.communityCouncil;
      district = instituteData.district;
      villageName = instituteData.villageName;
      route = instituteData.route;
      principalChief = instituteData.principalChief;
      villageChief = instituteData.villageChief;
      gpsCoordinates = instituteData.gpsCoordinates;

      communityResponsibleFirstName =
          instituteData.communityResponsibleFirstName;
      communityResponsibleSurname = instituteData.communityResponsibleSurname;
      communityContactCell = instituteData.communityContactCell;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Census Institution Form')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Institution Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextFormField(
                initialValue: institutionName,
                decoration:
                    const InputDecoration(labelText: 'Institution Name'),
                onChanged: (val) => setState(() => institutionName = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              DropdownButtonFormField<String>(
                decoration:
                    const InputDecoration(labelText: 'Institution Type'),
                value: institutionType,
                items: AppConstants.institutionTypes
                    .map((e) =>
                        DropdownMenuItem<String>(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  setState(() => institutionType = value!);
                },
                validator: (val) =>
                    (val == null || val == 'Select Type') ? 'Required' : null,
              ),
              TextFormField(
                initialValue: responsibleFirstName,
                decoration:
                    const InputDecoration(labelText: 'Responsible First Name'),
                onChanged: (val) => setState(() => responsibleFirstName = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                initialValue: responsibleSurname,
                decoration:
                    const InputDecoration(labelText: 'Responsible Surname'),
                onChanged: (val) => setState(() => responsibleSurname = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                initialValue: physicalAddress,
                decoration:
                    const InputDecoration(labelText: 'Physical Address'),
                onChanged: (val) => setState(() => physicalAddress = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                initialValue: postalAddress,
                decoration: const InputDecoration(labelText: 'Postal Address'),
                onChanged: (val) => setState(() => postalAddress = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                initialValue: contactCell,
                decoration: const InputDecoration(labelText: 'Contact Cell'),
                onChanged: (val) => setState(() => contactCell = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              const Text('Institution Location Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                decoration:
                    const InputDecoration(labelText: 'Community Council'),
                value: communityCouncil,
                items: AppConstants.communityCouncils
                    .map((e) =>
                        DropdownMenuItem<String>(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => setState(() => communityCouncil = value!),
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'District'),
                value: district,
                items: AppConstants.districts
                    .map((e) =>
                        DropdownMenuItem<String>(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => setState(() => district = value!),
              ),
              TextFormField(
                initialValue: villageName,
                decoration: const InputDecoration(labelText: 'Village Name'),
                onChanged: (val) => setState(() => villageName = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Route Name'),
                value: route,
                items: AppConstants.routes
                    .map((e) =>
                        DropdownMenuItem<String>(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => setState(() => route = value!),
              ),
              TextFormField(
                initialValue: principalChief,
                decoration: const InputDecoration(labelText: 'Principal Chief'),
                onChanged: (val) => setState(() => principalChief = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                initialValue: villageChief,
                decoration:
                    const InputDecoration(labelText: 'Village Chief/Headman'),
                onChanged: (val) => setState(() => villageChief = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                initialValue: gpsCoordinates,
                decoration: const InputDecoration(labelText: 'GPS Coordinates'),
                onChanged: (val) => setState(() => gpsCoordinates = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              const Text('Community Form',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextFormField(
                initialValue: communityResponsibleFirstName,
                decoration:
                    const InputDecoration(labelText: 'Responsible First Name'),
                onChanged: (val) =>
                    setState(() => communityResponsibleFirstName = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                initialValue: communityResponsibleSurname,
                decoration:
                    const InputDecoration(labelText: 'Responsible Surname'),
                onChanged: (val) =>
                    setState(() => communityResponsibleSurname = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                initialValue: communityContactCell,
                decoration: const InputDecoration(labelText: 'Contact Cell'),
                onChanged: (val) => setState(() => communityContactCell = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final institution = CensusInstitution(
                        name: institutionName,
                        type: institutionType,
                        responsibleFirstName: responsibleFirstName,
                        responsibleSurname: responsibleSurname,
                        physicalAddress: physicalAddress,
                        postalAddress: postalAddress,
                        contactCell: contactCell,
                        communityCouncil: communityCouncil,
                        district: district,
                        villageName: villageName,
                        route: route,
                        principalChief: principalChief,
                        villageChief: villageChief,
                        gpsCoordinates: gpsCoordinates,
                        communityResponsibleFirstName:
                            communityResponsibleFirstName,
                        communityResponsibleSurname:
                            communityResponsibleSurname,
                        communityContactCell: communityContactCell,
                      );
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString(
                          censusInstituteKey, jsonEncode(institution.toJson()));

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Institution Form Submitted')),
                      );
                    }
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
}

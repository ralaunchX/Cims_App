import 'dart:convert';
import 'dart:developer';

import 'package:cims/data_model/census_household.dart';
import 'package:cims/data_model/census_institution.dart';
import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/keys.dart';
import 'package:cims/utils/submit_button.dart';
import 'package:cims/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
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
      'key': Keys.censusHousehold
    },
    {
      'title': 'Census Institution Form',
      'widget': const CensusInstitutionFormScreen(),
      'key': Keys.censusInstitution
    },
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onPop,
      child: Scaffold(
        appBar: AppBar(title: Text('Census Forms ${Keys.rapId}')),
        body: ListView.builder(
          itemCount: censusForms.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: ListTile(
                tileColor: AppPrefs().prefs!.containsKey(
                        '${Keys.rapId}_${censusForms[index]['key']}')
                    ? Colors.green
                    : Colors.transparent,
                leading: const Icon(Icons.description),
                title: Text(censusForms[index]['title']),
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => censusForms[index]['widget'],
                    ),
                  );
                  if (result == true) {
                    setState(() {});
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Future<bool> onPop() async {
    Navigator.pop(context, true);
    return true;
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
  String maritalStatus = AppConstants.notSelected;
  String marriageType = AppConstants.notSelected;
  String district = AppConstants.notSelected;
  String route = AppConstants.notSelected;
  String communityCouncil = AppConstants.notSelected;
  String gender = AppConstants.notSelected;

  String idNumber = '';
  String? houseHoldId = '';

  String? papNumber;
  String? firstName;
  String? lastName;
  String? typeOfIdentification = 'None';
  String? expiryDate;
  String? originalVillage;
  String? residentialVillage;
  String? cellphoneNo;

  String? idExpiryDate;
  String spouseIdNumber = '';
  String? spouseIdExpiryDate;
  String spouseFirstName = '';
  String spouseSurname = '';
  String householdHeadFirstName = '';
  String householdHeadSurname = '';
  String contactCell = '';
  String principalChief = '';
  String villageName = '';
  String villageChief = '';
  String gpsCoordinates = '';

  bool get showIdFields => idType != 'None';
  bool get showSpouseIdFields => spouseIdType != 'None';
  bool existingHouseHold = true;

  final FocusNode idTypeFocus = FocusNode();
  final FocusNode spouseIdTypeFocus = FocusNode();
  final FocusNode maritalStatusFocus = FocusNode();
  final FocusNode marriageTypeFocus = FocusNode();
  final FocusNode districtFocus = FocusNode();
  final FocusNode routeFocus = FocusNode();
  final FocusNode communityCouncilFocus = FocusNode();
  final FocusNode genderFocus = FocusNode();

  final FocusNode idNumberFocus = FocusNode();
  final FocusNode idExpiryDateFocus = FocusNode();
  final FocusNode spouseIdNumberFocus = FocusNode();
  final FocusNode spouseIdExpiryDateFocus = FocusNode();
  final FocusNode spouseFirstNameFocus = FocusNode();
  final FocusNode spouseSurnameFocus = FocusNode();
  final FocusNode householdHeadFirstNameFocus = FocusNode();
  final FocusNode householdHeadSurnameFocus = FocusNode();
  final FocusNode contactCellFocus = FocusNode();
  final FocusNode principalChiefFocus = FocusNode();
  final FocusNode villageNameFocus = FocusNode();

  final FocusNode villageChiefFocus = FocusNode();
  final FocusNode gpsCoordinatesFocus = FocusNode();

  String rapId = Keys.rapId;
  String censusHouseKey = '${Keys.rapId}_${Keys.censusHousehold}';
  late TextEditingController gpsCoordinatesController;
  late TextEditingController idExpiryDateController;
  late TextEditingController spouseIdExpiryDateController;
  late TextEditingController expiryDateController;

  @override
  void dispose() {
    idTypeFocus.dispose();
    spouseIdTypeFocus.dispose();
    maritalStatusFocus.dispose();
    marriageTypeFocus.dispose();
    districtFocus.dispose();
    routeFocus.dispose();
    communityCouncilFocus.dispose();
    genderFocus.dispose();
    villageNameFocus.dispose();
    idNumberFocus.dispose();
    idExpiryDateFocus.dispose();
    spouseIdNumberFocus.dispose();
    spouseIdExpiryDateFocus.dispose();
    spouseFirstNameFocus.dispose();
    spouseSurnameFocus.dispose();
    householdHeadFirstNameFocus.dispose();
    householdHeadSurnameFocus.dispose();
    contactCellFocus.dispose();
    principalChiefFocus.dispose();
    villageChiefFocus.dispose();
    gpsCoordinatesFocus.dispose();
    gpsCoordinatesController.dispose();
    idExpiryDateController.dispose();
    spouseIdExpiryDateController.dispose();
    expiryDateController.dispose();

    super.dispose();
  }

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
      houseHoldId = householdData.householdId;
      spouseIdType = householdData.spouseIdType;
      maritalStatus = householdData.maritalStatus;
      marriageType = householdData.marriageType;
      district = householdData.district;
      route = householdData.route;
      communityCouncil = householdData.communityCouncil;
      villageName = householdData.villageName;
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
      papNumber = householdData.papNumber;
      firstName = householdData.firstName;
      typeOfIdentification = householdData.typeOfIdentification;
      originalVillage = householdData.originalVillage;
      expiryDate = householdData.expiryDate;
      lastName = householdData.lastName;
      residentialVillage = householdData.residentialVillage;
      cellphoneNo = householdData.cellphoneNo;
      existingHouseHold = houseHoldId?.isNotEmpty ?? true;
    }
    gpsCoordinatesController = TextEditingController(text: gpsCoordinates);
    idExpiryDateController = TextEditingController(text: idExpiryDate ?? '');
    spouseIdExpiryDateController =
        TextEditingController(text: spouseIdExpiryDate ?? '');
    expiryDateController = TextEditingController(text: expiryDate ?? '');
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
              CheckboxListTile(
                title: const Text("Use Existing Household Record"),
                value: existingHouseHold,
                onChanged: (val) {
                  setState(() {
                    existingHouseHold = val!;
                  });
                },
              ),
              if (existingHouseHold == true)
                TextFormField(
                  textInputAction: TextInputAction.next,
                  initialValue: houseHoldId,
                  decoration: const InputDecoration(labelText: 'Household Id'),
                  onChanged: (val) => setState(() => houseHoldId = val),
                  validator: (val) =>
                      (existingHouseHold == true && val!.isEmpty)
                          ? 'Required'
                          : null,
                ),
              /////
              if (existingHouseHold == false)
                Column(
                  children: [
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      initialValue: papNumber,
                      decoration:
                          const InputDecoration(labelText: 'PAP Number'),
                      onChanged: (val) => setState(() => papNumber = val),
                      validator: (val) =>
                          (existingHouseHold == false && val!.isEmpty)
                              ? 'Required'
                              : null,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      initialValue: firstName,
                      decoration:
                          const InputDecoration(labelText: 'First Name'),
                      onChanged: (val) => setState(() => firstName = val),
                      validator: (val) =>
                          (existingHouseHold == false && val!.isEmpty)
                              ? 'Required'
                              : null,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      initialValue: lastName,
                      decoration: const InputDecoration(labelText: 'Last Name'),
                      onChanged: (val) => setState(() => lastName = val),
                      validator: (val) =>
                          (existingHouseHold == false && val!.isEmpty)
                              ? 'Required'
                              : null,
                    ),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                          labelText: 'Identification Type'),
                      value: typeOfIdentification,
                      items: AppConstants.idTypes
                          .map((e) => DropdownMenuItem<String>(
                              value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) {
                        setState(() => typeOfIdentification = value!);
                      },
                      validator: (val) =>
                          (existingHouseHold == false && val!.isEmpty)
                              ? 'Required'
                              : null,
                    ),
                    if (typeOfIdentification != 'None')
                      TextFormField(
                          controller: expiryDateController,
                          readOnly: true,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            labelText: 'Expiry Date',
                            helperText: 'Format: dd-MM-yyyy',
                          ),
                          onTap: () async {
                            final selected = await Utility.selectDate(context);
                            if (selected != null) {
                              setState(() {
                                var date =
                                    DateFormat('yyyy-MM-dd').format(selected);
                                expiryDate = date;
                                expiryDateController.text = date;
                              });
                            }
                          },
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Required';
                            }
                          }),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      initialValue: originalVillage,
                      decoration:
                          const InputDecoration(labelText: 'Original Village'),
                      onChanged: (val) => setState(() => originalVillage = val),
                      validator: (val) =>
                          (existingHouseHold == false && val!.isEmpty)
                              ? 'Required'
                              : null,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      initialValue: residentialVillage,
                      decoration: const InputDecoration(
                          labelText: 'Residential Village'),
                      onChanged: (val) =>
                          setState(() => residentialVillage = val),
                      validator: (val) =>
                          (existingHouseHold == false && val!.isEmpty)
                              ? 'Required'
                              : null,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      initialValue: cellphoneNo,
                      decoration:
                          const InputDecoration(labelText: 'Cellphone Number'),
                      onChanged: (val) => setState(() => cellphoneNo = val),
                      validator: (val) =>
                          (existingHouseHold == false && val!.isEmpty)
                              ? 'Required'
                              : null,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ],
                ),
              TextFormField(
                focusNode: householdHeadFirstNameFocus,
                textInputAction: TextInputAction.next,
                initialValue: householdHeadFirstName,
                decoration: const InputDecoration(
                    labelText: 'Household Head First Name'),
                onChanged: (val) =>
                    setState(() => householdHeadFirstName = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                focusNode: householdHeadSurnameFocus,
                textInputAction: TextInputAction.next,
                initialValue: householdHeadSurname,
                decoration: const InputDecoration(labelText: 'Head Surname'),
                onChanged: (val) => setState(() => householdHeadSurname = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              DropdownButtonFormField<String>(
                focusNode: genderFocus,
                decoration: const InputDecoration(labelText: 'Gender'),
                value: gender,
                items: AppConstants.genderList
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  setState(() => gender = value!);
                },
                validator: (val) {
                  if (val == null || val == AppConstants.notSelected) {
                    return 'Please select Gender';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                focusNode: idTypeFocus,
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
                  focusNode: idNumberFocus,
                  textInputAction: TextInputAction.next,
                  initialValue: idNumber,
                  decoration: const InputDecoration(labelText: 'ID Number'),
                  onChanged: (val) => setState(() => idNumber = val),
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                    focusNode: idExpiryDateFocus,
                    controller: idExpiryDateController,
                    readOnly: true,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'ID Expiry Date',
                      helperText: 'Format: dd-MM-yyyy',
                    ),
                    onTap: () async {
                      final selected = await Utility.selectDate(context);
                      if (selected != null) {
                        setState(() {
                          var date = DateFormat('yyyy-MM-dd').format(selected);
                          idExpiryDate = date;
                          idExpiryDateController.text = date;
                        });
                      }
                    },
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Required';
                      }
                    }),
              ],
              DropdownButtonFormField<String>(
                focusNode: maritalStatusFocus,
                decoration: const InputDecoration(labelText: 'Marital Status'),
                value: maritalStatus,
                items: AppConstants.maritalStatuses
                    .map((e) =>
                        DropdownMenuItem<String>(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  setState(() => maritalStatus = value!);
                },
                validator: (val) {
                  if (val == null || val == AppConstants.notSelected) {
                    return 'Please select marital status';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                focusNode: marriageTypeFocus,
                decoration: const InputDecoration(labelText: 'Marriage Type'),
                value: marriageType,
                items: AppConstants.marriageTypes
                    .map((e) =>
                        DropdownMenuItem<String>(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  setState(() => marriageType = value!);
                },
                validator: (val) {
                  if (val == null || val == AppConstants.notSelected) {
                    return 'Please select marriage type';
                  }
                  return null;
                },
              ),
              TextFormField(
                focusNode: contactCellFocus,
                initialValue: contactCell,
                decoration: const InputDecoration(labelText: 'Contact Cell'),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(communityCouncilFocus);
                },
                onChanged: (val) => setState(() => contactCell = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(height: 20),
              const Text('Household Location Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                focusNode: communityCouncilFocus,
                decoration:
                    const InputDecoration(labelText: 'Community Council'),
                value: communityCouncil,
                items: AppConstants.communityCouncils
                    .map((e) =>
                        DropdownMenuItem<String>(value: e, child: Text(e)))
                    .toList(),
                validator: (val) {
                  if (val == null || val == AppConstants.notSelected) {
                    return 'Please select community council';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() => communityCouncil = value!);
                },
              ),
              DropdownButtonFormField<String>(
                focusNode: districtFocus,
                decoration: const InputDecoration(labelText: 'District'),
                value: district,
                items: AppConstants.districts
                    .map((e) =>
                        DropdownMenuItem<String>(value: e, child: Text(e)))
                    .toList(),
                validator: (val) {
                  if (val == null || val == AppConstants.notSelected) {
                    return 'Please select District';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() => district = value!);
                },
              ),
              TextFormField(
                focusNode: villageNameFocus,
                initialValue: villageName,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Village name'),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(routeFocus);
                },
                onChanged: (val) => setState(() => villageName = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              DropdownButtonFormField<String>(
                focusNode: routeFocus,
                isExpanded: true,
                decoration: const InputDecoration(labelText: 'Route Name'),
                value: route,
                items: AppConstants.routes
                    .map((e) =>
                        DropdownMenuItem<String>(value: e, child: Text(e)))
                    .toList(),
                validator: (val) {
                  if (val == null || val == AppConstants.notSelected) {
                    return 'Please select Route';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() => route = value!);
                },
              ),
              TextFormField(
                focusNode: principalChiefFocus,
                textInputAction: TextInputAction.next,
                initialValue: principalChief,
                decoration: const InputDecoration(labelText: 'Principal Chief'),
                onChanged: (val) => setState(() => principalChief = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                focusNode: villageChiefFocus,
                textInputAction: TextInputAction.next,
                initialValue: villageChief,
                decoration:
                    const InputDecoration(labelText: 'Village Chief/Headman'),
                onChanged: (val) => setState(() => villageChief = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                focusNode: gpsCoordinatesFocus,
                textInputAction: TextInputAction.next,
                controller: gpsCoordinatesController,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(spouseFirstNameFocus);
                },
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
              ...[
                const SizedBox(height: 20),
                const Text('Spouse Details',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextFormField(
                  focusNode: spouseFirstNameFocus,
                  textInputAction: TextInputAction.next,
                  initialValue: spouseFirstName,
                  decoration:
                      const InputDecoration(labelText: 'Spouse First Name'),
                  onChanged: (val) => setState(() => spouseFirstName = val),
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  focusNode: spouseSurnameFocus,
                  textInputAction: TextInputAction.next,
                  initialValue: spouseSurname,
                  decoration:
                      const InputDecoration(labelText: 'Spouse Surname'),
                  onChanged: (val) => setState(() => spouseSurname = val),
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                ),
                DropdownButtonFormField<String>(
                  focusNode: spouseIdTypeFocus,
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
                    focusNode: spouseIdNumberFocus,
                    textInputAction: TextInputAction.next,
                    initialValue: spouseIdNumber,
                    decoration:
                        const InputDecoration(labelText: 'Spouse ID Number'),
                    onChanged: (val) => setState(() => spouseIdNumber = val),
                    validator: (val) => val!.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                      focusNode: spouseIdExpiryDateFocus,
                      textInputAction: TextInputAction.next,
                      controller: spouseIdExpiryDateController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Spouse ID Expiry Date',
                        helperText: 'Format: yyyy-MM-dd',
                      ),
                      onTap: () async {
                        final selected = await Utility.selectDate(context);
                        if (selected != null) {
                          setState(() {
                            var date =
                                DateFormat('yyyy-MM-dd').format(selected);
                            spouseIdExpiryDate = date;
                            spouseIdExpiryDateController.text = date;
                          });
                        }
                      },
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Required';
                        }
                      }),
                ],
              ],
              const SizedBox(height: 30),
              CommonSubmitButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final household = CensusHousehold(
                      rapId: rapId,
                      householdId: houseHoldId?.trim() ?? '',
                      householdHeadFirstName: householdHeadFirstName,
                      householdHeadSurname: householdHeadSurname,
                      gender: gender,
                      idType: idType,
                      idNumber: idNumber,
                      idExpiryDate: idExpiryDate,
                      maritalStatus: maritalStatus,
                      marriageType: marriageType,
                      contactCell: contactCell,
                      villageName: villageName,
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
                      papNumber: papNumber,
                      firstName: firstName,
                      typeOfIdentification: typeOfIdentification,
                      originalVillage: originalVillage,
                      expiryDate: expiryDate,
                      lastName: lastName,
                      residentialVillage: residentialVillage,
                      cellphoneNo: cellphoneNo,
                    );
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString(
                        censusHouseKey, jsonEncode(household.toJson()));

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Household Form Submitted'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Future.delayed(const Duration(milliseconds: 500), () {
                      Navigator.pop(context, true);
                    });
                  }
                },
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
  String rapId = Keys.rapId;
  String censusInstituteKey = '${Keys.rapId}_${Keys.censusInstitution}';
  String? houseHoldId = '';

  String? papNumber;
  String? firstName;
  String? lastName;
  String? typeOfIdentification = 'None';
  String? expiryDate;
  String? originalVillage;
  String? residentialVillage;
  String? cellphoneNo;
  String? gender;

  String institutionName = '';
  String institutionType = AppConstants.notSelected;
  String responsibleFirstName = '';
  String responsibleSurname = '';
  String physicalAddress = '';
  String postalAddress = '';
  String contactCell = '';

  String communityCouncil = AppConstants.notSelected;
  String district = AppConstants.notSelected;
  String villageName = '';
  String route = AppConstants.notSelected;
  String principalChief = '';
  String villageChief = '';
  String gpsCoordinates = '';

  String communityResponsibleFirstName = '';
  String communityResponsibleSurname = '';
  String communityContactCell = '';

  final FocusNode institutionNameFocus = FocusNode();
  final FocusNode institutionTypeFocus = FocusNode();
  final FocusNode responsibleFirstNameFocus = FocusNode();
  final FocusNode responsibleSurnameFocus = FocusNode();
  final FocusNode physicalAddressFocus = FocusNode();
  final FocusNode postalAddressFocus = FocusNode();
  final FocusNode contactCellFocus = FocusNode();

  final FocusNode communityCouncilFocus = FocusNode();
  final FocusNode districtFocus = FocusNode();
  final FocusNode villageNameFocus = FocusNode();
  final FocusNode routeFocus = FocusNode();
  final FocusNode principalChiefFocus = FocusNode();
  final FocusNode villageChiefFocus = FocusNode();
  final FocusNode gpsCoordinatesFocus = FocusNode();

  final FocusNode communityResponsibleFirstNameFocus = FocusNode();
  final FocusNode communityResponsibleSurnameFocus = FocusNode();
  final FocusNode communityContactCellFocus = FocusNode();

  late TextEditingController gpsCoordinatesController;
  late TextEditingController expiryDateController;

  bool existingHouseHold = true;

  @override
  void dispose() {
    institutionNameFocus.dispose();
    institutionTypeFocus.dispose();
    responsibleFirstNameFocus.dispose();
    responsibleSurnameFocus.dispose();
    physicalAddressFocus.dispose();
    postalAddressFocus.dispose();
    contactCellFocus.dispose();
    communityCouncilFocus.dispose();
    districtFocus.dispose();
    villageNameFocus.dispose();
    routeFocus.dispose();
    principalChiefFocus.dispose();
    villageChiefFocus.dispose();
    gpsCoordinatesFocus.dispose();
    communityResponsibleFirstNameFocus.dispose();
    communityResponsibleSurnameFocus.dispose();
    communityContactCellFocus.dispose();
    gpsCoordinatesController.dispose();
    expiryDateController.dispose();
    super.dispose();
  }

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
      houseHoldId = instituteData.householdId;
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
      papNumber = instituteData.papNumber;
      firstName = instituteData.firstName;
      typeOfIdentification = instituteData.typeOfIdentification;
      originalVillage = instituteData.originalVillage;
      expiryDate = instituteData.expiryDate;
      lastName = instituteData.lastName;
      residentialVillage = instituteData.residentialVillage;
      cellphoneNo = instituteData.cellphoneNo;
      gender = instituteData?.gender;
      existingHouseHold = houseHoldId?.isNotEmpty ?? true;
    }
    gpsCoordinatesController = TextEditingController(text: gpsCoordinates);
    expiryDateController = TextEditingController(text: expiryDate ?? '');
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
              CheckboxListTile(
                title: const Text("Use Existing Household Record"),
                value: existingHouseHold,
                onChanged: (val) {
                  setState(() {
                    existingHouseHold = val!;
                  });
                },
              ),
              if (existingHouseHold == true)
                TextFormField(
                  textInputAction: TextInputAction.next,
                  initialValue: houseHoldId,
                  decoration: const InputDecoration(labelText: 'Household Id'),
                  onChanged: (val) => setState(() => houseHoldId = val),
                  validator: (val) =>
                      (existingHouseHold == true && val!.isEmpty)
                          ? 'Required'
                          : null,
                ),
              if (existingHouseHold == false)
                Column(
                  children: [
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      initialValue: papNumber,
                      decoration:
                          const InputDecoration(labelText: 'PAP Number'),
                      onChanged: (val) => setState(() => papNumber = val),
                      validator: (val) =>
                          (existingHouseHold == false && val!.isEmpty)
                              ? 'Required'
                              : null,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      initialValue: firstName,
                      decoration:
                          const InputDecoration(labelText: 'First Name'),
                      onChanged: (val) => setState(() => firstName = val),
                      validator: (val) =>
                          (existingHouseHold == false && val!.isEmpty)
                              ? 'Required'
                              : null,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      initialValue: lastName,
                      decoration: const InputDecoration(labelText: 'Last Name'),
                      onChanged: (val) => setState(() => lastName = val),
                      validator: (val) =>
                          (existingHouseHold == false && val!.isEmpty)
                              ? 'Required'
                              : null,
                    ),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Gender'),
                      value: gender,
                      items: AppConstants.genderList
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) {
                        setState(() => gender = value!);
                      },
                      validator: (val) {
                        if (val == null || val == AppConstants.notSelected) {
                          return 'Please select Gender';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                          labelText: 'Identification Type'),
                      value: typeOfIdentification,
                      items: AppConstants.idTypes
                          .map((e) => DropdownMenuItem<String>(
                              value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) {
                        setState(() => typeOfIdentification = value!);
                      },
                      validator: (val) =>
                          (existingHouseHold == false && val!.isEmpty)
                              ? 'Required'
                              : null,
                    ),
                    if (typeOfIdentification != 'None')
                      TextFormField(
                          controller: expiryDateController,
                          readOnly: true,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            labelText: 'Expiry Date',
                            helperText: 'Format: dd-MM-yyyy',
                          ),
                          onTap: () async {
                            final selected = await Utility.selectDate(context);
                            if (selected != null) {
                              setState(() {
                                var date =
                                    DateFormat('yyyy-MM-dd').format(selected);
                                expiryDate = date;
                                expiryDateController.text = date;
                              });
                            }
                          },
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Required';
                            }
                          }),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      initialValue: originalVillage,
                      decoration:
                          const InputDecoration(labelText: 'Original Village'),
                      onChanged: (val) => setState(() => originalVillage = val),
                      validator: (val) =>
                          (existingHouseHold == false && val!.isEmpty)
                              ? 'Required'
                              : null,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      initialValue: residentialVillage,
                      decoration: const InputDecoration(
                          labelText: 'Residential Village'),
                      onChanged: (val) =>
                          setState(() => residentialVillage = val),
                      validator: (val) =>
                          (existingHouseHold == false && val!.isEmpty)
                              ? 'Required'
                              : null,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      initialValue: cellphoneNo,
                      decoration:
                          const InputDecoration(labelText: 'Cellphone Number'),
                      onChanged: (val) => setState(() => cellphoneNo = val),
                      validator: (val) =>
                          (existingHouseHold == false && val!.isEmpty)
                              ? 'Required'
                              : null,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ],
                ),
              TextFormField(
                initialValue: institutionName,
                focusNode: institutionNameFocus,
                textInputAction: TextInputAction.next,
                decoration:
                    const InputDecoration(labelText: 'Institution Name'),
                onChanged: (val) => setState(() => institutionName = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              DropdownButtonFormField<String>(
                focusNode: institutionTypeFocus,
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
                validator: (val) {
                  if (val == null || val == AppConstants.notSelected) {
                    return 'Please Select Type';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: responsibleFirstName,
                focusNode: responsibleFirstNameFocus,
                textInputAction: TextInputAction.next,
                decoration:
                    const InputDecoration(labelText: 'Responsible First Name'),
                onChanged: (val) => setState(() => responsibleFirstName = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                initialValue: responsibleSurname,
                focusNode: responsibleSurnameFocus,
                textInputAction: TextInputAction.next,
                decoration:
                    const InputDecoration(labelText: 'Responsible Surname'),
                onChanged: (val) => setState(() => responsibleSurname = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                initialValue: physicalAddress,
                focusNode: physicalAddressFocus,
                textInputAction: TextInputAction.next,
                decoration:
                    const InputDecoration(labelText: 'Physical Address'),
                onChanged: (val) => setState(() => physicalAddress = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                initialValue: postalAddress,
                focusNode: postalAddressFocus,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Postal Address'),
                onChanged: (val) => setState(() => postalAddress = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                initialValue: contactCell,
                focusNode: contactCellFocus,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Contact Cell'),
                onChanged: (val) => setState(() => contactCell = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(height: 20),
              const Text('Institution Location Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                focusNode: communityCouncilFocus,
                decoration:
                    const InputDecoration(labelText: 'Community Council'),
                value: communityCouncil,
                items: AppConstants.communityCouncils
                    .map((e) =>
                        DropdownMenuItem<String>(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => setState(() => communityCouncil = value!),
                validator: (val) {
                  if (val == null || val == AppConstants.notSelected) {
                    return 'Please select Council';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                focusNode: districtFocus,
                decoration: const InputDecoration(labelText: 'District'),
                value: district,
                items: AppConstants.districts
                    .map((e) =>
                        DropdownMenuItem<String>(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => setState(() => district = value!),
                validator: (val) {
                  if (val == null || val == AppConstants.notSelected) {
                    return 'Please select District';
                  }
                  return null;
                },
              ),
              TextFormField(
                focusNode: villageNameFocus,
                textInputAction: TextInputAction.next,
                initialValue: villageName,
                decoration: const InputDecoration(labelText: 'Village Name'),
                onChanged: (val) => setState(() => villageName = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              DropdownButtonFormField<String>(
                focusNode: routeFocus,
                isExpanded: true,
                decoration: const InputDecoration(labelText: 'Route Name'),
                value: route,
                items: AppConstants.routes
                    .map((e) =>
                        DropdownMenuItem<String>(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => setState(() => route = value!),
                validator: (val) {
                  if (val == null || val == AppConstants.notSelected) {
                    return 'Please select Route';
                  }
                  return null;
                },
              ),
              TextFormField(
                focusNode: principalChiefFocus,
                textInputAction: TextInputAction.next,
                initialValue: principalChief,
                decoration: const InputDecoration(labelText: 'Principal Chief'),
                onChanged: (val) => setState(() => principalChief = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                initialValue: villageChief,
                focusNode: villageChiefFocus,
                textInputAction: TextInputAction.next,
                decoration:
                    const InputDecoration(labelText: 'Village Chief/Headman'),
                onChanged: (val) => setState(() => villageChief = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                focusNode: gpsCoordinatesFocus,
                textInputAction: TextInputAction.next,
                controller: gpsCoordinatesController,
                onFieldSubmitted: (_) {
                  FocusScope.of(context)
                      .requestFocus(communityResponsibleFirstNameFocus);
                },
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
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              const Text('Community Form',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextFormField(
                initialValue: communityResponsibleFirstName,
                focusNode: communityResponsibleFirstNameFocus,
                textInputAction: TextInputAction.next,
                decoration:
                    const InputDecoration(labelText: 'Responsible First Name'),
                onChanged: (val) =>
                    setState(() => communityResponsibleFirstName = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                focusNode: communityResponsibleSurnameFocus,
                textInputAction: TextInputAction.next,
                initialValue: communityResponsibleSurname,
                decoration:
                    const InputDecoration(labelText: 'Responsible Surname'),
                onChanged: (val) =>
                    setState(() => communityResponsibleSurname = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                focusNode: communityContactCellFocus,
                textInputAction: TextInputAction.next,
                initialValue: communityContactCell,
                decoration: const InputDecoration(labelText: 'Contact Cell'),
                onChanged: (val) => setState(() => communityContactCell = val),
                validator: (val) => val!.isEmpty ? 'Required' : null,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(height: 30),
              CommonSubmitButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final institution = CensusInstitution(
                      rapId: rapId,
                      householdId: houseHoldId?.trim() ?? '',
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
                      communityResponsibleSurname: communityResponsibleSurname,
                      communityContactCell: communityContactCell,
                      papNumber: papNumber,
                      firstName: firstName,
                      typeOfIdentification: typeOfIdentification,
                      originalVillage: originalVillage,
                      expiryDate: expiryDate,
                      lastName: lastName,
                      gender: gender,
                      residentialVillage: residentialVillage,
                      cellphoneNo: cellphoneNo,
                    );
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString(
                        censusInstituteKey, jsonEncode(institution.toJson()));

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Institution Form Submitted'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Future.delayed(const Duration(milliseconds: 500), () {
                      Navigator.pop(context, true);
                    });
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

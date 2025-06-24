class CensusHousehold {
  final String rapId;
  final String householdId;
  final String householdHeadFirstName;
  final String householdHeadSurname;
  final String gender;
  final String idType;
  final String idNumber;
  final String? idExpiryDate;
  final String maritalStatus;
  final String marriageType;
  final String contactCell;
  final String communityCouncil;
  final String district;
  final String route;
  final String villageName;
  final String principalChief;
  final String villageChief;
  final String gpsCoordinates;

  // Spouse Details
  final String spouseFirstName;
  final String spouseSurname;
  final String spouseIdType;
  final String spouseIdNumber;
  final String? spouseIdExpiryDate;

  final String? papNumber;
  final String? firstName;
  final String? lastName;
  final String? typeOfIdentification;
  final String? expiryDate;
  final String? originalVillage;
  final String? residentialVillage;
  final String? cellphoneNo;

  CensusHousehold({
    required this.rapId,
    required this.householdId,
    required this.householdHeadFirstName,
    required this.householdHeadSurname,
    required this.gender,
    required this.idType,
    required this.idNumber,
    required this.idExpiryDate,
    required this.maritalStatus,
    required this.marriageType,
    required this.contactCell,
    required this.communityCouncil,
    required this.district,
    required this.route,
    required this.villageName,
    required this.principalChief,
    required this.villageChief,
    required this.gpsCoordinates,
    required this.spouseFirstName,
    required this.spouseSurname,
    required this.spouseIdType,
    required this.spouseIdNumber,
    required this.spouseIdExpiryDate,
    required this.papNumber,
    required this.firstName,
    required this.lastName,
    required this.typeOfIdentification,
    required this.expiryDate,
    required this.originalVillage,
    required this.residentialVillage,
    required this.cellphoneNo,
  });

  factory CensusHousehold.fromJson(Map<String, dynamic> json) {
    return CensusHousehold(
      rapId: json['case'] ?? '',
      householdId: json['household'] ?? '',
      householdHeadFirstName: json['head_first_name'] ?? '',
      householdHeadSurname: json['head_surname'] ?? '',
      gender: json['gender'] ?? '',
      idType: json['id_type'] ?? '',
      idNumber: json['id_number'] ?? '',
      idExpiryDate: json['id_expiry_date'],
      maritalStatus: json['marital_status'] ?? '',
      marriageType: json['marriage_type'] ?? '',
      contactCell: json['contact_cell'] ?? '',
      communityCouncil: json['project_area'] ?? '',
      district: json['district'] ?? '',
      route: json['route_name'] ?? '',
      villageName: json['village_name'] ?? '',
      principalChief: json['principal_chief'] ?? '',
      villageChief: json['village_chief'] ?? '',
      gpsCoordinates: json['gps_coordinates'] ?? '',
      spouseFirstName: json['spouse_first_name'] ?? '',
      spouseSurname: json['spouse_surname'] ?? '',
      spouseIdType: json['spouse_id_type'] ?? '',
      spouseIdNumber: json['spouse_id_number'] ?? '',
      spouseIdExpiryDate: json['spouse_id_expiry_date'],
      papNumber: json['pap_number'],
      cellphoneNo: json['cellphone_no'],
      expiryDate: json['expiry_date'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      originalVillage: json['original_village_name'],
      residentialVillage: json['residential_village'],
      typeOfIdentification: json['type_of_identification'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'case': rapId,
      'household': householdId,
      'head_first_name': householdHeadFirstName,
      'head_surname': householdHeadSurname,
      'gender': gender,
      'id_type': idType,
      'id_number': idNumber,
      'id_expiry_date': idExpiryDate,
      'marital_status': maritalStatus,
      'marriage_type': marriageType,
      'contact_cell': contactCell,
      'project_area': communityCouncil,
      'district': district,
      'route_name': route,
      'village_name': villageName,
      'principal_chief': principalChief,
      'village_chief': villageChief,
      'gps_coordinates': gpsCoordinates,
      'spouse_first_name': spouseFirstName,
      'spouse_surname': spouseSurname,
      'spouse_id_type': spouseIdType,
      'spouse_id_number': spouseIdNumber,
      'spouse_id_expiry_date': spouseIdExpiryDate,
      'pap_number': papNumber,
      'first_name': firstName,
      'last_name': lastName,
      'type_of_identification': typeOfIdentification,
      'expiry_date': expiryDate,
      'original_village_name': originalVillage,
      'residential_village': residentialVillage,
      'cellphone_no': cellphoneNo
    };
  }
}

class CensusHousehold {
  final String rapId;

  final String householdHeadFirstName;
  final String householdHeadSurname;
  final String gender;
  final String idType;
  final String idNumber;
  final String idExpiryDate;
  final String maritalStatus;
  final String marriageType;
  final String contactCell;
  final String communityCouncil;
  final String district;
  final String route;
  final String principalChief;
  final String villageChief;
  final String gpsCoordinates;

  // Spouse Details
  final String spouseFirstName;
  final String spouseSurname;
  final String spouseIdType;
  final String spouseIdNumber;
  final String spouseIdExpiryDate;

  CensusHousehold({
    required this.rapId,
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
    required this.principalChief,
    required this.villageChief,
    required this.gpsCoordinates,
    required this.spouseFirstName,
    required this.spouseSurname,
    required this.spouseIdType,
    required this.spouseIdNumber,
    required this.spouseIdExpiryDate,
  });

  factory CensusHousehold.fromJson(Map<String, dynamic> json) {
    return CensusHousehold(
      rapId: json['rapId'] ?? '',
      householdHeadFirstName: json['householdHeadFirstName'] ?? '',
      householdHeadSurname: json['householdHeadSurname'] ?? '',
      gender: json['gender'] ?? '',
      idType: json['idType'] ?? '',
      idNumber: json['idNumber'] ?? '',
      idExpiryDate: json['idExpiryDate'] ?? '',
      maritalStatus: json['maritalStatus'] ?? '',
      marriageType: json['marriageType'] ?? '',
      contactCell: json['contactCell'] ?? '',
      communityCouncil: json['communityCouncil'] ?? '',
      district: json['district'] ?? '',
      route: json['route'] ?? '',
      principalChief: json['principalChief'] ?? '',
      villageChief: json['villageChief'] ?? '',
      gpsCoordinates: json['gpsCoordinates'] ?? '',
      spouseFirstName: json['spouseFirstName'] ?? '',
      spouseSurname: json['spouseSurname'] ?? '',
      spouseIdType: json['spouseIdType'] ?? '',
      spouseIdNumber: json['spouseIdNumber'] ?? '',
      spouseIdExpiryDate: json['spouseIdExpiryDate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rapId': rapId,
      'householdHeadFirstName': householdHeadFirstName,
      'householdHeadSurname': householdHeadSurname,
      'gender': gender,
      'idType': idType,
      'idNumber': idNumber,
      'idExpiryDate': idExpiryDate,
      'maritalStatus': maritalStatus,
      'marriageType': marriageType,
      'contactCell': contactCell,
      'communityCouncil': communityCouncil,
      'district': district,
      'route': route,
      'principalChief': principalChief,
      'villageChief': villageChief,
      'gpsCoordinates': gpsCoordinates,
      'spouseFirstName': spouseFirstName,
      'spouseSurname': spouseSurname,
      'spouseIdType': spouseIdType,
      'spouseIdNumber': spouseIdNumber,
      'spouseIdExpiryDate': spouseIdExpiryDate,
    };
  }
}

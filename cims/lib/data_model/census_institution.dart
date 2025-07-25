class CensusInstitution {
  final String rapId;
  final String householdId;

  final String name;
  final String type;
  final String responsibleFirstName;
  final String responsibleSurname;
  final String physicalAddress;
  final String postalAddress;
  final String contactCell;
  final String communityCouncil;
  final String district;
  final String villageName;
  final String route;
  final String principalChief;
  final String villageChief;
  final String gpsCoordinates;
  final String communityResponsibleFirstName;
  final String communityResponsibleSurname;
  final String communityContactCell;

  final String? papNumber;
  final String? firstName;
  final String? lastName;
  final String? typeOfIdentification;
  final String? expiryDate;
  final String? originalVillage;
  final String? residentialVillage;
  final String? cellphoneNo;
  final String? gender;

  CensusInstitution({
    required this.rapId,
    required this.householdId,
    required this.name,
    required this.type,
    required this.responsibleFirstName,
    required this.responsibleSurname,
    required this.physicalAddress,
    required this.postalAddress,
    required this.contactCell,
    required this.communityCouncil,
    required this.district,
    required this.villageName,
    required this.route,
    required this.principalChief,
    required this.villageChief,
    required this.gpsCoordinates,
    required this.communityResponsibleFirstName,
    required this.communityResponsibleSurname,
    required this.communityContactCell,
    required this.papNumber,
    required this.firstName,
    required this.lastName,
    required this.typeOfIdentification,
    required this.expiryDate,
    required this.originalVillage,
    required this.residentialVillage,
    required this.cellphoneNo,
    required this.gender,
  });

  Map<String, dynamic> toJson() => {
        'case': rapId,
        'household': householdId,
        'name': name,
        'institution_type': type,
        'responsible_first_name': responsibleFirstName,
        'responsible_surname': responsibleSurname,
        'physical_address': physicalAddress,
        'postal_address': postalAddress,
        'contact_cell': contactCell,
        'project_area': communityCouncil,
        'district': district,
        'village_name': villageName,
        'route_name': route,
        'principal_chief': principalChief,
        'village_chief': villageChief,
        'gps_coordinates': gpsCoordinates,
        'community_responsible_first_name': communityResponsibleFirstName,
        'community_responsible_surname': communityResponsibleSurname,
        'community_contact_cell': communityContactCell,
        'pap_number': papNumber,
        'first_name': firstName,
        'last_name': lastName,
        'type_of_identification': typeOfIdentification,
        'expiry_date': expiryDate,
        'original_village_name': originalVillage,
        'residential_village': residentialVillage,
        'cellphone_no': cellphoneNo,
        'gender': gender,
      };

  factory CensusInstitution.fromJson(Map<String, dynamic> json) {
    return CensusInstitution(
      rapId: json['case'] ?? '',
      householdId: json['household'] ?? '',
      name: json['name'] ?? '',
      type: json['institution_type'] ?? '',
      responsibleFirstName: json['responsible_first_name'] ?? '',
      responsibleSurname: json['responsible_surname'] ?? '',
      physicalAddress: json['physical_address'] ?? '',
      postalAddress: json['postal_address'] ?? '',
      contactCell: json['contact_cell'] ?? '',
      communityCouncil: json['project_area'] ?? '',
      district: json['district'] ?? '',
      villageName: json['village_name'] ?? '',
      route: json['route_name'] ?? '',
      principalChief: json['principal_chief'] ?? '',
      villageChief: json['village_chief'] ?? '',
      gpsCoordinates: json['gps_coordinates'] ?? '',
      communityResponsibleFirstName:
          json['community_responsible_first_name'] ?? '',
      communityResponsibleSurname: json['community_responsible_surname'] ?? '',
      communityContactCell: json['community_contact_cell'] ?? '',
      papNumber: json['pap_number'],
      cellphoneNo: json['cellphone_no'],
      expiryDate: json['expiry_date'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      originalVillage: json['original_village_name'],
      residentialVillage: json['residential_village'],
      typeOfIdentification: json['type_of_identification'],
      gender: json['gender'],
    );
  }
}

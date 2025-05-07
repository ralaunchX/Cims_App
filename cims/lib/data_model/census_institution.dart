class CensusInstitution {
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
  CensusInstitution({
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
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
        'responsibleFirstName': responsibleFirstName,
        'responsibleSurname': responsibleSurname,
        'physicalAddress': physicalAddress,
        'postalAddress': postalAddress,
        'contactCell': contactCell,
        'communityCouncil': communityCouncil,
        'district': district,
        'villageName': villageName,
        'route': route,
        'principalChief': principalChief,
        'villageChief': villageChief,
        'gpsCoordinates': gpsCoordinates,
        'communityResponsibleFirstName': communityResponsibleFirstName,
        'communityResponsibleSurname': communityResponsibleSurname,
        'communityContactCell': communityContactCell,
      };

  factory CensusInstitution.fromJson(Map<String, dynamic> json) {
    return CensusInstitution(
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      responsibleFirstName: json['responsibleFirstName'] ?? '',
      responsibleSurname: json['responsibleSurname'] ?? '',
      physicalAddress: json['physicalAddress'] ?? '',
      postalAddress: json['postalAddress'] ?? '',
      contactCell: json['contactCell'] ?? '',
      communityCouncil: json['communityCouncil'] ?? '',
      district: json['district'] ?? '',
      villageName: json['villageName'] ?? '',
      route: json['route'] ?? '',
      principalChief: json['principalChief'] ?? '',
      villageChief: json['villageChief'] ?? '',
      gpsCoordinates: json['gpsCoordinates'] ?? '',
      communityResponsibleFirstName:
          json['communityResponsibleFirstName'] ?? '',
      communityResponsibleSurname: json['communityResponsibleSurname'] ?? '',
      communityContactCell: json['communityContactCell'] ?? '',
    );
  }
}

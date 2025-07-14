class AssetHouseholdDto {
  final String rapId;
  final String routeName;
  final String papNumber;
  final String firstName;
  final String lastName;
  final String gender;
  final String identificationType;
  final String idNumber;
  final String idExpiryDate;
  final String originalVillage;
  final String residentialVillage;
  final String occupation;
  final String cellphone;
  final String? photo;

  AssetHouseholdDto(
      {required this.rapId,
      required this.routeName,
      required this.papNumber,
      required this.firstName,
      required this.lastName,
      required this.gender,
      required this.identificationType,
      required this.idNumber,
      required this.idExpiryDate,
      required this.originalVillage,
      required this.residentialVillage,
      required this.occupation,
      required this.cellphone,
      required this.photo});

  Map<String, dynamic> toJson() => {
        'case': rapId,
        'route_name': routeName,
        'pap_number': papNumber,
        'first_name': firstName,
        'last_name': lastName,
        'gender': gender,
        'type_of_identification': identificationType,
        'id_number': idNumber,
        'expiry_date': idExpiryDate,
        'original_village_name': originalVillage,
        'residential_village': residentialVillage,
        'occupation_of_pap': occupation,
        'cellphone_no': cellphone,
        'upload_photographs': photo
      };

  factory AssetHouseholdDto.fromJson(Map<String, dynamic> json) =>
      AssetHouseholdDto(
          rapId: json['case'],
          routeName: json['route_name'],
          papNumber: json['pap_number'],
          firstName: json['first_name'],
          lastName: json['last_name'],
          gender: json['gender'],
          identificationType: json['type_of_identification'],
          idNumber: json['id_number'],
          idExpiryDate: json['expiry_date'],
          originalVillage: json['original_village_name'],
          residentialVillage: json['residential_village'],
          occupation: json['occupation_of_pap'],
          cellphone: json['cellphone_no'],
          photo: json['upload_photographs']);
}

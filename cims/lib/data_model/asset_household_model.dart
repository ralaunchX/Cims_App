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

  AssetHouseholdDto({
    required this.rapId,
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
  });

  Map<String, dynamic> toJson() => {
        'rapId': rapId,
        'routeName': routeName,
        'papNumber': papNumber,
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender,
        'identificationType': identificationType,
        'idNumber': idNumber,
        'idExpiryDate': idExpiryDate,
        'originalVillage': originalVillage,
        'residentialVillage': residentialVillage,
        'occupation': occupation,
        'cellphone': cellphone,
      };

  factory AssetHouseholdDto.fromJson(Map<String, dynamic> json) =>
      AssetHouseholdDto(
        rapId: json['rapId'],
        routeName: json['routeName'],
        papNumber: json['papNumber'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        gender: json['gender'],
        identificationType: json['identificationType'],
        idNumber: json['idNumber'],
        idExpiryDate: json['idExpiryDate'],
        originalVillage: json['originalVillage'],
        residentialVillage: json['residentialVillage'],
        occupation: json['occupation'],
        cellphone: json['cellphone'],
      );
}

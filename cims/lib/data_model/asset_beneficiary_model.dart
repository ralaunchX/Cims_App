class AssetBeneficiaryDto {
  final String rapId;
  final String firstName;
  final String lastName;
  final String village;
  final bool isMinor;
  final String dateOfBirth;
  final String physicalAddress;
  final String postalAddress;
  final String contactCell;
  final String idType;
  final String idNumber;
  final String idExpiryDate;
  final String bankingDetails;

  AssetBeneficiaryDto({
    required this.rapId,
    required this.firstName,
    required this.lastName,
    required this.village,
    required this.isMinor,
    required this.dateOfBirth,
    required this.physicalAddress,
    required this.postalAddress,
    required this.contactCell,
    required this.idType,
    required this.idNumber,
    required this.idExpiryDate,
    required this.bankingDetails,
  });

  Map<String, dynamic> toJson() => {
        'rapId': rapId,
        'firstName': firstName,
        'lastName': lastName,
        'village': village,
        'isMinor': isMinor,
        'dateOfBirth': dateOfBirth,
        'physicalAddress': physicalAddress,
        'postalAddress': postalAddress,
        'contactCell': contactCell,
        'idType': idType,
        'idNumber': idNumber,
        'idExpiryDate': idExpiryDate,
        'bankingDetails': bankingDetails,
      };

  factory AssetBeneficiaryDto.fromJson(Map<String, dynamic> json) =>
      AssetBeneficiaryDto(
        rapId: json['rapId'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        village: json['village'],
        isMinor: json['isMinor'] ?? false,
        dateOfBirth: json['dateOfBirth'],
        physicalAddress: json['physicalAddress'],
        postalAddress: json['postalAddress'],
        contactCell: json['contactCell'],
        idType: json['idType'],
        idNumber: json['idNumber'],
        idExpiryDate: json['idExpiryDate'],
        bankingDetails: json['bankingDetails'],
      );
}

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
        'case': rapId,
        'first_name': firstName,
        'last_name': lastName,
        'village': village,
        'minor': isMinor,
        'date_of_birth': dateOfBirth,
        'physical_address': physicalAddress,
        'postal_address': postalAddress,
        'contact_cell': contactCell,
        'type_of_identification': idType,
        'identification_number': idNumber,
        'expiry_date': idExpiryDate,
        'banking_details': bankingDetails,
      };

  factory AssetBeneficiaryDto.fromJson(Map<String, dynamic> json) =>
      AssetBeneficiaryDto(
        rapId: json['case'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        village: json['village'],
        isMinor: json['minor'] ?? false,
        dateOfBirth: json['date_of_birth'],
        physicalAddress: json['physical_address'],
        postalAddress: json['postal_address'],
        contactCell: json['contact_cell'],
        idType: json['type_of_identification'],
        idNumber: json['identification_number'],
        idExpiryDate: json['expiry_date'],
        bankingDetails: json['banking_details'],
      );
}

class AssetCoOwnerDto {
  final String rapId;
  final String firstName;
  final String lastName;
  final String physicalAddress;
  final String contactCell;
  final String idType;
  final String idNumber;
  final String idExpiryDate;
  final String bankName;

  AssetCoOwnerDto({
    required this.rapId,
    required this.firstName,
    required this.lastName,
    required this.physicalAddress,
    required this.contactCell,
    required this.idType,
    required this.idNumber,
    required this.idExpiryDate,
    required this.bankName,
  });

  Map<String, dynamic> toJson() => {
        'case': rapId,
        'first_name': firstName,
        'last_name': lastName,
        'physical_address': physicalAddress,
        'contact_cell': contactCell,
        'type_of_identification': idType,
        'identification_number': idNumber,
        'expiry_date': idExpiryDate,
        'bank_name': bankName,
      };

  factory AssetCoOwnerDto.fromJson(Map<String, dynamic> json) =>
      AssetCoOwnerDto(
        rapId: json['case'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        physicalAddress: json['physical_address'],
        contactCell: json['contact_cell'],
        idType: json['type_of_identification'],
        idNumber: json['identification_number'],
        idExpiryDate: json['expiry_date'],
        bankName: json['bank_name'],
      );
}

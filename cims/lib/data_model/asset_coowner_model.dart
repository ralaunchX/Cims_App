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
        'rapId': rapId,
        'firstName': firstName,
        'lastName': lastName,
        'physicalAddress': physicalAddress,
        'contactCell': contactCell,
        'idType': idType,
        'idNumber': idNumber,
        'idExpiryDate': idExpiryDate,
        'bankName': bankName,
      };

  factory AssetCoOwnerDto.fromJson(Map<String, dynamic> json) =>
      AssetCoOwnerDto(
        rapId: json['rapId'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        physicalAddress: json['physicalAddress'],
        contactCell: json['contactCell'],
        idType: json['idType'],
        idNumber: json['idNumber'],
        idExpiryDate: json['idExpiryDate'],
        bankName: json['bankName'],
      );
}

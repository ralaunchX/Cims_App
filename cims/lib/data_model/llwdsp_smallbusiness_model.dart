class BusinessInfo {
  String refNo;
  String businessType;
  String positionInBusiness;
  String useOfIncome;
  String numPersonsInvolved;

  BusinessInfo({
    required this.refNo,
    required this.businessType,
    required this.positionInBusiness,
    required this.useOfIncome,
    required this.numPersonsInvolved,
  });

  Map<String, dynamic> toJson() => {
        'refNo': refNo,
        'businessType': businessType,
        'positionInBusiness': positionInBusiness,
        'useOfIncome': useOfIncome,
        'numPersonsInvolved': numPersonsInvolved,
      };

  factory BusinessInfo.fromJson(Map<String, dynamic> json) => BusinessInfo(
        refNo: json['refNo'] ?? '',
        businessType: json['businessType'] ?? '',
        positionInBusiness: json['positionInBusiness'] ?? '',
        useOfIncome: json['useOfIncome'] ?? '',
        numPersonsInvolved: json['numPersonsInvolved'] ?? '',
      );
}

class ListBusinessInfo {
  String rapId;
  List<BusinessInfo> businessInfoList;

  ListBusinessInfo({required this.rapId, required this.businessInfoList});

  Map<String, dynamic> toJson() => {
        'rapId': rapId,
        'businessInfoList': businessInfoList.map((e) => e.toJson()).toList(),
      };

  factory ListBusinessInfo.fromJson(Map<String, dynamic> json) =>
      ListBusinessInfo(
        rapId: json['rapId'] ?? '',
        businessInfoList: (json['businessInfoList'] as List)
            .map((e) => BusinessInfo.fromJson(e))
            .toList(),
      );
}

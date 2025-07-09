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
        'ref_no': refNo,
        'business_type': businessType,
        'position_in_business': positionInBusiness,
        'use_of_income': useOfIncome,
        'num_persons_involved': numPersonsInvolved,
      };

  factory BusinessInfo.fromJson(Map<String, dynamic> json) => BusinessInfo(
        refNo: json['ref_no'] ?? '',
        businessType: json['business_type'] ?? '',
        positionInBusiness: json['position_in_business'] ?? '',
        useOfIncome: json['use_of_income'] ?? '',
        numPersonsInvolved: json['num_persons_involved'] ?? '',
      );
}

class ListBusinessInfo {
  String rapId;
  List<BusinessInfo> businessInfoList;

  ListBusinessInfo({required this.rapId, required this.businessInfoList});

  Map<String, dynamic> toJson() => {
        'case': rapId,
        'businessInfoList': businessInfoList.map((e) => e.toJson()).toList(),
      };

  factory ListBusinessInfo.fromJson(Map<String, dynamic> json) =>
      ListBusinessInfo(
        rapId: json['case'] ?? '',
        businessInfoList: (json['businessInfoList'] as List)
            .map((e) => BusinessInfo.fromJson(e))
            .toList(),
      );
}

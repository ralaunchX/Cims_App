class UnemploymentInfo {
  String refNo;
  String reasonForUnemployment;
  String yearsOfUnemployment;

  UnemploymentInfo({
    required this.refNo,
    required this.reasonForUnemployment,
    required this.yearsOfUnemployment,
  });

  Map<String, dynamic> toJson() => {
        'refNo': refNo,
        'reasonForUnemployment': reasonForUnemployment,
        'yearsOfUnemployment': yearsOfUnemployment,
      };

  factory UnemploymentInfo.fromJson(Map<String, dynamic> json) =>
      UnemploymentInfo(
        refNo: json['refNo'] ?? '',
        reasonForUnemployment: json['reasonForUnemployment'] ?? '',
        yearsOfUnemployment: json['yearsOfUnemployment'] ?? '',
      );
}

class ListUnEmploymentInfo {
  String rapId;
  List<UnemploymentInfo> unEmploymentInfoList;

  ListUnEmploymentInfo({
    required this.rapId,
    required this.unEmploymentInfoList,
  });

  Map<String, dynamic> toJson() => {
        'rapId': rapId,
        'unEmploymentInfoList':
            unEmploymentInfoList.map((e) => e.toJson()).toList(),
      };

  factory ListUnEmploymentInfo.fromJson(Map<String, dynamic> json) =>
      ListUnEmploymentInfo(
        rapId: json['rapId'] ?? '',
        unEmploymentInfoList: (json['unEmploymentInfoList'] as List)
                .map((e) => UnemploymentInfo.fromJson(e))
                .toList() ??
            [],
      );
}

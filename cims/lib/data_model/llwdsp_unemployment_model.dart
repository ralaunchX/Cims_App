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
        'ref_no': refNo,
        'reason_for_unemployment': reasonForUnemployment,
        'years_unemployed': yearsOfUnemployment,
      };

  factory UnemploymentInfo.fromJson(Map<String, dynamic> json) =>
      UnemploymentInfo(
        refNo: json['ref_no'] ?? '',
        reasonForUnemployment: json['reason_for_unemployment'] ?? '',
        yearsOfUnemployment: json['years_unemployed'] ?? '',
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
        'case': rapId,
        'unEmploymentInfoList':
            unEmploymentInfoList.map((e) => e.toJson()).toList(),
      };

  factory ListUnEmploymentInfo.fromJson(Map<String, dynamic> json) =>
      ListUnEmploymentInfo(
        rapId: json['case'] ?? '',
        unEmploymentInfoList: (json['unEmploymentInfoList'] as List)
                .map((e) => UnemploymentInfo.fromJson(e))
                .toList() ??
            [],
      );
}

class EmploymentInfo {
  String refNo;
  String typeOfEmployment;
  String employmentSector;
  String employmentCategory;
  String placeOfWork;

  EmploymentInfo({
    required this.refNo,
    required this.typeOfEmployment,
    required this.employmentSector,
    required this.employmentCategory,
    required this.placeOfWork,
  });

  Map<String, dynamic> toJson() => {
        'refNo': refNo,
        'typeOfEmployment': typeOfEmployment,
        'employmentSector': employmentSector,
        'employmentCategory': employmentCategory,
        'placeOfWork': placeOfWork,
      };

  factory EmploymentInfo.fromJson(Map<String, dynamic> json) => EmploymentInfo(
        refNo: json['refNo'] ?? '',
        typeOfEmployment: json['typeOfEmployment'] ?? '',
        employmentSector: json['employmentSector'] ?? '',
        employmentCategory: json['employmentCategory'] ?? '',
        placeOfWork: json['placeOfWork'] ?? '',
      );
}

class ListEmploymentInfo {
  String rapId;
  List<EmploymentInfo> employmentInfoList;

  ListEmploymentInfo({
    required this.rapId,
    required this.employmentInfoList,
  });

  Map<String, dynamic> toJson() => {
        'rapId': rapId,
        'employmentInfoList':
            employmentInfoList.map((e) => e.toJson()).toList(),
      };

  factory ListEmploymentInfo.fromJson(Map<String, dynamic> json) =>
      ListEmploymentInfo(
        rapId: json['rapId'] ?? '',
        employmentInfoList: (json['employmentInfoList'] as List)
                ?.map((e) => EmploymentInfo.fromJson(e))
                .toList() ??
            [],
      );
}

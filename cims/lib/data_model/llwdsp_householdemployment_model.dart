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
        'ref_no': refNo,
        'employment_type': typeOfEmployment,
        'employment_sector': employmentSector,
        'employment_category': employmentCategory,
        'place_of_work': placeOfWork,
      };

  factory EmploymentInfo.fromJson(Map<String, dynamic> json) => EmploymentInfo(
        refNo: json['ref_no'] ?? '',
        typeOfEmployment: json['employment_type'] ?? '',
        employmentSector: json['employment_sector'] ?? '',
        employmentCategory: json['employment_category'] ?? '',
        placeOfWork: json['place_of_work'] ?? '',
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
        'case': rapId,
        'employmentInfoList':
            employmentInfoList.map((e) => e.toJson()).toList(),
      };

  factory ListEmploymentInfo.fromJson(Map<String, dynamic> json) =>
      ListEmploymentInfo(
        rapId: json['case'] ?? '',
        employmentInfoList: (json['employmentInfoList'] as List)
                ?.map((e) => EmploymentInfo.fromJson(e))
                .toList() ??
            [],
      );
}

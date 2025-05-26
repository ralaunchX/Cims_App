class EducationInfo {
  String refNo;
  String attendingSchool;
  String schoolLevel;
  String reasonForNonAttendance;

  EducationInfo({
    required this.refNo,
    required this.attendingSchool,
    required this.schoolLevel,
    required this.reasonForNonAttendance,
  });

  Map<String, dynamic> toJson() {
    return {
      'refNo': refNo,
      'attendingSchool': attendingSchool,
      'schoolLevel': schoolLevel,
      'reasonForNonAttendance': reasonForNonAttendance,
    };
  }

  factory EducationInfo.fromJson(Map<String, dynamic> json) {
    return EducationInfo(
      refNo: json['refNo'] ?? '',
      attendingSchool: json['attendingSchool'] ?? '',
      schoolLevel: json['schoolLevel'] ?? '',
      reasonForNonAttendance: json['reasonForNonAttendance'] ?? '',
    );
  }
}

class ListEducationInfo {
  String rapId;
  List<EducationInfo> educationInfoList;

  ListEducationInfo({
    required this.rapId,
    required this.educationInfoList,
  });

  Map<String, dynamic> toJson() {
    return {
      'rapId': rapId,
      'educationInfoList': educationInfoList.map((e) => e.toJson()).toList(),
    };
  }

  factory ListEducationInfo.fromJson(Map<String, dynamic> json) {
    return ListEducationInfo(
      rapId: json['rapId'] ?? '',
      educationInfoList: (json['educationInfoList'] as List<dynamic>?)
              ?.map((e) => EducationInfo.fromJson(e))
              .toList() ??
          [],
    );
  }
}

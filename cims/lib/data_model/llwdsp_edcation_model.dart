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
      'ref_no': refNo,
      'attending_school': attendingSchool,
      'school_level': schoolLevel,
      'non_attendance_reason': reasonForNonAttendance,
    };
  }

  factory EducationInfo.fromJson(Map<String, dynamic> json) {
    return EducationInfo(
      refNo: json['ref_no'] ?? '',
      attendingSchool: json['attending_school'] ?? '',
      schoolLevel: json['school_level'] ?? '',
      reasonForNonAttendance: json['non_attendance_reason'] ?? '',
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
      'case': rapId,
      'educationInfoList': educationInfoList.map((e) => e.toJson()).toList(),
    };
  }

  factory ListEducationInfo.fromJson(Map<String, dynamic> json) {
    return ListEducationInfo(
      rapId: json['case'] ?? '',
      educationInfoList: (json['educationInfoList'] as List<dynamic>?)
              ?.map((e) => EducationInfo.fromJson(e))
              .toList() ??
          [],
    );
  }
}

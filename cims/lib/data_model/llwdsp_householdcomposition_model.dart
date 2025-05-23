class HouseholdMemberDto {
  String refNo;
  String name;
  String relation;
  String sex;
  DateTime? dob;
  String maritalStatus;
  String residentialStatus;
  String educationLevel;
  String occupation;
  String disability;
  String illness;

  HouseholdMemberDto({
    required this.refNo,
    required this.name,
    required this.relation,
    required this.sex,
    required this.dob,
    required this.maritalStatus,
    required this.residentialStatus,
    required this.educationLevel,
    required this.occupation,
    required this.disability,
    required this.illness,
  });

  factory HouseholdMemberDto.fromJson(Map<String, dynamic> json) {
    return HouseholdMemberDto(
      refNo: json['refNo'] as String? ?? '',
      name: json['name'] as String? ?? '',
      relation: json['relation'] as String? ?? '',
      sex: json['sex'] as String? ?? '',
      dob: json['dob'] != null ? DateTime.tryParse(json['dob']) : null,
      maritalStatus: json['maritalStatus'] as String? ?? '',
      residentialStatus: json['residentialStatus'] as String? ?? '',
      educationLevel: json['educationLevel'] as String? ?? '',
      occupation: json['occupation'] as String? ?? '',
      disability: json['disability'] as String? ?? '',
      illness: json['illness'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'refNo': refNo,
      'name': name,
      'relation': relation,
      'sex': sex,
      'dob': dob?.toIso8601String(),
      'maritalStatus': maritalStatus,
      'residentialStatus': residentialStatus,
      'educationLevel': educationLevel,
      'occupation': occupation,
      'disability': disability,
      'illness': illness,
    };
  }
}

class ListHouseholdMemberDto {
  final String rapId;
  final List<HouseholdMemberDto> members;

  ListHouseholdMemberDto({
    required this.rapId,
    required this.members,
  });

  factory ListHouseholdMemberDto.fromJson(Map<String, dynamic> json) {
    return ListHouseholdMemberDto(
      rapId: json['rapId'] as String,
      members: (json['members'] as List<dynamic>)
          .map((e) => HouseholdMemberDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rapId': rapId,
      'members': members.map((e) => e.toJson()).toList(),
    };
  }
}

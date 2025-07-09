class HouseholdMemberDto {
  String refNo;
  String name;
  String relation;
  String sex;
  String dob;
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
      refNo: json['ref_no'] as String? ?? '',
      name: json['name'] as String? ?? '',
      relation: json['relation_to_hh_head'] as String? ?? '',
      sex: json['sex'] as String? ?? '',
      dob: json['year_of_birth'] as String ?? '',
      maritalStatus: json['marital_status'] as String? ?? '',
      residentialStatus: json['residential_status'] as String? ?? '',
      educationLevel: json['education_level'] as String? ?? '',
      occupation: json['main_occupation'] as String? ?? '',
      disability: json['disability'] as String? ?? '',
      illness: json['chronic_illness'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ref_no': refNo,
      'name': name,
      'relation_to_hh_head': relation,
      'sex': sex,
      'year_of_birth': dob,
      'marital_status': maritalStatus,
      'residential_status': residentialStatus,
      'education_level': educationLevel,
      'main_occupation': occupation,
      'disability': disability,
      'chronic_illness': illness,
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
      rapId: json['case'] as String,
      members: (json['members'] as List<dynamic>)
          .map((e) => HouseholdMemberDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'case': rapId,
      'members': members.map((e) => e.toJson()).toList(),
    };
  }
}

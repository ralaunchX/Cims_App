class HouseholdAdditionalInfoDto {
  String? rapId;
  String? projectComments;
  String? interviewerComments;

  HouseholdAdditionalInfoDto({
    required this.rapId,
    required this.projectComments,
    required this.interviewerComments,
  });

  Map<String, dynamic> toJson() => {
        'rapId': rapId,
        'projectComments': projectComments,
        'interviewerComments': interviewerComments,
      };

  factory HouseholdAdditionalInfoDto.fromJson(Map<String, dynamic> json) =>
      HouseholdAdditionalInfoDto(
        rapId: json['rapId'] ?? '',
        projectComments: json['projectComments'],
        interviewerComments: json['interviewerComments'],
      );
}

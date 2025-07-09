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
        'case': rapId,
        'project_comments': projectComments,
        'interviewer_comments': interviewerComments,
      };

  factory HouseholdAdditionalInfoDto.fromJson(Map<String, dynamic> json) =>
      HouseholdAdditionalInfoDto(
        rapId: json['case'] ?? '',
        projectComments: json['project_comments'],
        interviewerComments: json['interviewer_comments'],
      );
}

class ResettlementLlwdspModel {
  String rapCase;
  String interviewerName;
  String village;
  String communityCouncil;
  String householdNumber;
  String householdHead;
  String respondentName;
  String contactNumber;
  String date;
  bool isPresent;
  String absenceNotes;
  String gpsNorthing;
  String gpsEasting;

  ResettlementLlwdspModel({
    required this.rapCase,
    required this.interviewerName,
    required this.village,
    required this.communityCouncil,
    required this.householdNumber,
    required this.householdHead,
    required this.respondentName,
    required this.contactNumber,
    required this.date,
    required this.isPresent,
    required this.absenceNotes,
    required this.gpsNorthing,
    required this.gpsEasting,
  });

  Map<String, dynamic> toJson() {
    return {
      'case': rapCase,
      'interviewer_name': interviewerName,
      'village': village,
      'community_council': communityCouncil,
      'household_number': householdNumber,
      'household_head': householdHead,
      'respondent_name': respondentName,
      'contact_number': contactNumber,
      'date': date,
      'is_present': isPresent,
      'absence_notes': absenceNotes,
      'gps_northing': gpsNorthing,
      'gps_easting': gpsEasting,
    };
  }

  factory ResettlementLlwdspModel.fromJson(Map<String, dynamic> json) {
    return ResettlementLlwdspModel(
      rapCase: json['case'] ?? '',
      interviewerName: json['interviewer_name'] ?? '',
      village: json['village'] ?? '',
      communityCouncil: json['community_council'] ?? '',
      householdNumber: json['household_number'] ?? '',
      householdHead: json['household_head'] ?? '',
      respondentName: json['respondent_name'] ?? '',
      contactNumber: json['contact_number'] ?? '',
      date: json['date'] ?? '',
      isPresent: json['is_present'] ?? false,
      absenceNotes: json['absence_notes'] ?? '',
      gpsNorthing: json['gps_northing'] ?? '',
      gpsEasting: json['gps_easting'] ?? '',
    );
  }
}

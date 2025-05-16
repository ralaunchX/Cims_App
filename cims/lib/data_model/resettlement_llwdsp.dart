class ResettlementLlwdspModel {
  String rapId;
  String interviewerName;
  String village;
  String communityCouncil;
  String householdNumber;
  String householdHead;
  String respondentName;
  String contactNumber;
  String date;
  bool isHeadOrSpousePresent;
  String ifNotPresentRecord;
  String gpsNorthing;
  String gpsEasting;

  ResettlementLlwdspModel({
    required this.rapId,
    required this.interviewerName,
    required this.village,
    required this.communityCouncil,
    required this.householdNumber,
    required this.householdHead,
    required this.respondentName,
    required this.contactNumber,
    required this.date,
    required this.isHeadOrSpousePresent,
    required this.ifNotPresentRecord,
    required this.gpsNorthing,
    required this.gpsEasting,
  });

  Map<String, dynamic> toJson() {
    return {
      'rapId': rapId,
      'interviewerName': interviewerName,
      'village': village,
      'communityCouncil': communityCouncil,
      'householdNumber': householdNumber,
      'householdHead': householdHead,
      'respondentName': respondentName,
      'contactNumber': contactNumber,
      'date': date,
      'isHeadOrSpousePresent': isHeadOrSpousePresent,
      'ifNotPresentRecord': ifNotPresentRecord,
      'gpsNorthing': gpsNorthing,
      'gpsEasting': gpsEasting,
    };
  }

  factory ResettlementLlwdspModel.fromJson(Map<String, dynamic> json) {
    return ResettlementLlwdspModel(
      rapId: json['rapId'] ?? '',
      interviewerName: json['interviewerName'] ?? '',
      village: json['village'] ?? '',
      communityCouncil: json['communityCouncil'] ?? '',
      householdNumber: json['householdNumber'] ?? '',
      householdHead: json['householdHead'] ?? '',
      respondentName: json['respondentName'] ?? '',
      contactNumber: json['contactNumber'] ?? '',
      date: json['date'] ?? '',
      isHeadOrSpousePresent: json['isHeadOrSpousePresent'] ?? false,
      ifNotPresentRecord: json['ifNotPresentRecord'] ?? '',
      gpsNorthing: json['gpsNorthing'] ?? '',
      gpsEasting: json['gpsEasting'] ?? '',
    );
  }
}

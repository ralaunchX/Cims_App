class FundingClubData {
  String caseId;
  String memberReference;
  String typeOfGroup;
  String contributionFrequency;
  String receiptFrequency;
  String sourceOfIncome;
  String contributionToLivelihood;

  FundingClubData({
    required this.caseId,
    required this.memberReference,
    required this.typeOfGroup,
    required this.contributionFrequency,
    required this.receiptFrequency,
    required this.sourceOfIncome,
    required this.contributionToLivelihood,
  });

  Map<String, dynamic> toJson() {
    return {
      'case': caseId,
      'household_member_ref': memberReference,
      'type_of_group': typeOfGroup,
      'contribution_frequency': contributionFrequency,
      'receipt_frequency': receiptFrequency,
      'income_source': sourceOfIncome,
      'livelihood_contribution': contributionToLivelihood,
    };
  }

  factory FundingClubData.fromJson(Map<String, dynamic> json) {
    return FundingClubData(
      caseId: json['case'],
      memberReference: json['household_member_ref'] ?? '',
      typeOfGroup: json['type_of_group'],
      contributionFrequency: json['contribution_frequency'],
      receiptFrequency: json['receipt_frequency'],
      sourceOfIncome: json['income_source'],
      contributionToLivelihood: json['livelihood_contribution'],
    );
  }
}

class LLwdspListFunding {
  final String rapId;
  final List<FundingClubData> fundingData;

  LLwdspListFunding({required this.rapId, required this.fundingData});

  Map<String, dynamic> toJson() {
    return {
      'case': rapId,
      'fundingData': fundingData.map((item) => item.toJson()).toList(),
    };
  }

  factory LLwdspListFunding.fromJson(Map<String, dynamic> json) {
    return LLwdspListFunding(
      rapId: json['case'],
      fundingData: (json['fundingData'] as List<dynamic>)
          .map((item) => FundingClubData.fromJson(item))
          .toList(),
    );
  }
}

class FundingClubData {
  String memberReference;
  String typeOfGroup;
  String contributionFrequency;
  String receiptFrequency;
  String sourceOfIncome;
  String contributionToLivelihood;

  FundingClubData({
    required this.memberReference,
    required this.typeOfGroup,
    required this.contributionFrequency,
    required this.receiptFrequency,
    required this.sourceOfIncome,
    required this.contributionToLivelihood,
  });

  Map<String, dynamic> toJson({required String rapid}) {
    return {
      'rapid': rapid,
      'memberReference': memberReference,
      'typeOfGroup': typeOfGroup,
      'contributionFrequency': contributionFrequency,
      'receiptFrequency': receiptFrequency,
      'sourceOfIncome': sourceOfIncome,
      'contributionToLivelihood': contributionToLivelihood,
    };
  }

  factory FundingClubData.fromJson(Map<String, dynamic> json) {
    return FundingClubData(
      memberReference: json['memberReference'] ?? '',
      typeOfGroup: json['typeOfGroup'],
      contributionFrequency: json['contributionFrequency'],
      receiptFrequency: json['receiptFrequency'],
      sourceOfIncome: json['sourceOfIncome'],
      contributionToLivelihood: json['contributionToLivelihood'],
    );
  }
}

class LLwdspListFunding {
  final String rapId;
  final List<FundingClubData> fundingData;

  LLwdspListFunding({required this.rapId, required this.fundingData});

  Map<String, dynamic> toJson() {
    return {
      'rapId': rapId,
      'fundingData':
          fundingData.map((item) => item.toJson(rapid: rapId)).toList(),
    };
  }

  factory LLwdspListFunding.fromJson(Map<String, dynamic> json) {
    return LLwdspListFunding(
      rapId: json['rapId'],
      fundingData: (json['fundingData'] as List<dynamic>)
          .map((item) => FundingClubData.fromJson(item))
          .toList(),
    );
  }
}

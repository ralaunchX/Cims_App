class LlwdspLivelihoodModel {
  final String caseId;
  final String primaryLivelihood;
  final String secondaryLivelihood;
  final List<String> regularIncomeSources;
  final String otherRegularIncome;
  final List<String> lastMonthIncomeSources;
  final String otherLastMonthIncome;
  final List<String> grantsReceived;

  LlwdspLivelihoodModel({
    required this.caseId,
    required this.primaryLivelihood,
    required this.secondaryLivelihood,
    required this.regularIncomeSources,
    required this.otherRegularIncome,
    required this.lastMonthIncomeSources,
    required this.otherLastMonthIncome,
    required this.grantsReceived,
  });

  factory LlwdspLivelihoodModel.fromJson(Map<String, dynamic> json) {
    return LlwdspLivelihoodModel(
      caseId: json['case'] ?? '',
      primaryLivelihood: json['primary_livelihood'] ?? '',
      secondaryLivelihood: json['secondary_livelihood'] ?? '',
      regularIncomeSources:
          List<String>.from(json['income_sources_regular'] ?? []),
      otherRegularIncome: json['otherRegularIncome'] ?? '',
      lastMonthIncomeSources:
          List<String>.from(json['lastMonthIncomeSources'] ?? []),
      otherLastMonthIncome: json['income_sources_last_month'] ?? '',
      grantsReceived: List<String>.from(json['grants_received'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'case': caseId,
      'primary_livelihood': primaryLivelihood,
      'secondary_livelihood': secondaryLivelihood,
      'income_sources_regular': regularIncomeSources,
      'otherRegularIncome': otherRegularIncome,
      'income_sources_last_month': lastMonthIncomeSources,
      'otherLastMonthIncome': otherLastMonthIncome,
      'grants_received': grantsReceived,
    };
  }
}

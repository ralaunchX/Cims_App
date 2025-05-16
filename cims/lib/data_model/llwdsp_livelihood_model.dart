class LlwdspLivelihoodModel {
  final String rapId;
  final String primaryLivelihood;
  final String secondaryLivelihood;
  final List<String> regularIncomeSources;
  final String otherRegularIncome;
  final List<String> lastMonthIncomeSources;
  final String otherLastMonthIncome;
  final List<String> grantsReceived;

  LlwdspLivelihoodModel({
    required this.rapId,
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
      rapId: json['rapId'] ?? '',
      primaryLivelihood: json['primaryLivelihood'] ?? '',
      secondaryLivelihood: json['secondaryLivelihood'] ?? '',
      regularIncomeSources:
          List<String>.from(json['regularIncomeSources'] ?? []),
      otherRegularIncome: json['otherRegularIncome'] ?? '',
      lastMonthIncomeSources:
          List<String>.from(json['lastMonthIncomeSources'] ?? []),
      otherLastMonthIncome: json['otherLastMonthIncome'] ?? '',
      grantsReceived: List<String>.from(json['grantsReceived'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rapId': rapId,
      'primaryLivelihood': primaryLivelihood,
      'secondaryLivelihood': secondaryLivelihood,
      'regularIncomeSources': regularIncomeSources,
      'otherRegularIncome': otherRegularIncome,
      'lastMonthIncomeSources': lastMonthIncomeSources,
      'otherLastMonthIncome': otherLastMonthIncome,
      'grantsReceived': grantsReceived,
    };
  }
}

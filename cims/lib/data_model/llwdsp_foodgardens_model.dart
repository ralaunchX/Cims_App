class LlwdspFoodgardensModel {
  List<String> cropsGrown;
  List<String> cropsHarvested;
  String gardenChoice;
  String cropUse;
  String irrigationMethod;
  String fertilizerType;

  LlwdspFoodgardensModel({
    required this.cropsGrown,
    required this.cropsHarvested,
    required this.gardenChoice,
    required this.cropUse,
    required this.irrigationMethod,
    required this.fertilizerType,
  });

  Map<String, dynamic> toJson() {
    return {
      'cropsGrown': cropsGrown,
      'cropsHarvested': cropsHarvested,
      'gardenChoice': gardenChoice,
      'cropUse': cropUse,
      'irrigationMethod': irrigationMethod,
      'fertilizerType': fertilizerType,
    };
  }

  factory LlwdspFoodgardensModel.fromJson(Map<String, dynamic> json) {
    return LlwdspFoodgardensModel(
      cropsGrown: List<String>.from(json['cropsGrown'] ?? []),
      cropsHarvested: List<String>.from(json['cropsHarvested'] ?? []),
      gardenChoice: json['gardenChoice'],
      cropUse: json['cropUse'],
      irrigationMethod: json['irrigationMethod'],
      fertilizerType: json['fertilizerType'],
    );
  }
}

class LlwdspFoodgardensModel {
  final String rapId;

  List<String> cropsGrown;
  List<String> cropsHarvested;
  String gardenChoice;
  String cropUse;
  String irrigationMethod;
  String fertilizerType;

  LlwdspFoodgardensModel({
    required this.rapId,
    required this.cropsGrown,
    required this.cropsHarvested,
    required this.gardenChoice,
    required this.cropUse,
    required this.irrigationMethod,
    required this.fertilizerType,
  });

  Map<String, dynamic> toJson() {
    return {
      'case': rapId,
      'crops_grown': cropsGrown,
      'crops_harvested': cropsHarvested,
      'food_garden_type': gardenChoice,
      'crop_use': cropUse,
      'irrigation_method': irrigationMethod,
      'fertilizer_type': fertilizerType,
    };
  }

  factory LlwdspFoodgardensModel.fromJson(Map<String, dynamic> json) {
    return LlwdspFoodgardensModel(
      rapId: json['case'] ?? '',
      cropsGrown: List<String>.from(json['crops_grown'] ?? []),
      cropsHarvested: List<String>.from(json['crops_harvested'] ?? []),
      gardenChoice: json['food_garden_type'],
      cropUse: json['crop_use'],
      irrigationMethod: json['irrigation_method'],
      fertilizerType: json['fertilizer_type'],
    );
  }
}

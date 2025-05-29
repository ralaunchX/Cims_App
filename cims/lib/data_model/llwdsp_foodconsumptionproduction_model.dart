class FoodProductionConsumptionDto {
  String rapId;
  List<String> selectedStapleMonths;
  String? stapleStorage;
  String? sideDishSource;
  List<String> selectedSideDishMonths;

  FoodProductionConsumptionDto({
    required this.rapId,
    required this.selectedStapleMonths,
    this.stapleStorage,
    this.sideDishSource,
    required this.selectedSideDishMonths,
  });

  factory FoodProductionConsumptionDto.fromJson(Map<String, dynamic> json) {
    return FoodProductionConsumptionDto(
      rapId: json['rapId'] ?? '',
      selectedStapleMonths:
          List<String>.from(json['selectedStapleMonths'] ?? []),
      stapleStorage: json['stapleStorage'],
      sideDishSource: json['sideDishSource'],
      selectedSideDishMonths:
          List<String>.from(json['selectedSideDishMonths'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rapId': rapId,
      'selectedStapleMonths': selectedStapleMonths,
      'stapleStorage': stapleStorage,
      'sideDishSource': sideDishSource,
      'selectedSideDishMonths': selectedSideDishMonths,
    };
  }
}

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
      rapId: json['case'] ?? '',
      selectedStapleMonths:
          List<String>.from(json['staple_consumption_months'] ?? []),
      stapleStorage: json['staple_storage_method'],
      sideDishSource: json['side_dish_source'],
      selectedSideDishMonths:
          List<String>.from(json['side_dish_consumption_months'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'case': rapId,
      'staple_consumption_months': selectedStapleMonths,
      'staple_storage_method': stapleStorage,
      'side_dish_source': sideDishSource,
      'side_dish_consumption_months': selectedSideDishMonths,
    };
  }
}

class FoodSecurityDto {
  String? rapId;
  bool? foodShortageLastYear;
  String? primaryStapleFood;
  String? stapleFoodSource;

  FoodSecurityDto({
    this.rapId,
    this.foodShortageLastYear,
    this.primaryStapleFood,
    this.stapleFoodSource,
  });

  Map<String, dynamic> toJson() => {
        'case': rapId,
        'has_food_shortage': foodShortageLastYear,
        'primary_staple': primaryStapleFood,
        'staple_source': stapleFoodSource,
      };

  factory FoodSecurityDto.fromJson(Map<String, dynamic> json) =>
      FoodSecurityDto(
        rapId: json['case'],
        foodShortageLastYear: json['has_food_shortage'],
        primaryStapleFood: json['primary_staple'],
        stapleFoodSource: json['staple_source'],
      );
}

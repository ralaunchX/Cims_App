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
        'rapId': rapId,
        'foodShortageLastYear': foodShortageLastYear,
        'primaryStapleFood': primaryStapleFood,
        'stapleFoodSource': stapleFoodSource,
      };

  factory FoodSecurityDto.fromJson(Map<String, dynamic> json) =>
      FoodSecurityDto(
        rapId: json['rapId'],
        foodShortageLastYear: json['foodShortageLastYear'],
        primaryStapleFood: json['primaryStapleFood'],
        stapleFoodSource: json['stapleFoodSource'],
      );
}

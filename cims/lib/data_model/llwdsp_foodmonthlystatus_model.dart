class MonthlyFoodDto {
  String? month;
  bool? wasHungry;
  String? hungerReason;

  MonthlyFoodDto({this.month, this.wasHungry, this.hungerReason});

  Map<String, dynamic> toJson() => {
        'month': month,
        'was_hungry': wasHungry,
        'hunger_reasons': hungerReason,
      };

  factory MonthlyFoodDto.fromJson(Map<String, dynamic> json) => MonthlyFoodDto(
        month: json['month'],
        wasHungry: json['was_hungry'],
        hungerReason: json['hunger_reasons'],
      );
}

class ListMonthlyFoodDto {
  String rapId;

  List<MonthlyFoodDto> items;

  ListMonthlyFoodDto({required this.rapId, required this.items});

  Map<String, dynamic> toJson() => {
        'case': rapId,
        'monthly_food_status': items.map((item) => item.toJson()).toList(),
      };

  factory ListMonthlyFoodDto.fromJson(Map<String, dynamic> json) =>
      ListMonthlyFoodDto(
        rapId: json['case'],
        items: (json['monthly_food_status'] as List)
            .map((e) => MonthlyFoodDto.fromJson(e))
            .toList(),
      );
}

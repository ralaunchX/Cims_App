class MonthlyFoodDto {
  String? month;
  bool? wasHungry;
  String? hungerReason;

  MonthlyFoodDto({this.month, this.wasHungry, this.hungerReason});

  Map<String, dynamic> toJson() => {
        'month': month,
        'wasHungry': wasHungry,
        'hungerReason': hungerReason,
      };

  factory MonthlyFoodDto.fromJson(Map<String, dynamic> json) => MonthlyFoodDto(
        month: json['month'],
        wasHungry: json['wasHungry'],
        hungerReason: json['hungerReason'],
      );
}

class ListMonthlyFoodDto {
  String rapId;

  List<MonthlyFoodDto> items;

  ListMonthlyFoodDto({required this.rapId, required this.items});

  Map<String, dynamic> toJson() => {
        'rapId': rapId,
        'items': items.map((item) => item.toJson()).toList(),
      };

  factory ListMonthlyFoodDto.fromJson(Map<String, dynamic> json) =>
      ListMonthlyFoodDto(
        rapId: json['rapId'],
        items: (json['items'] as List)
            .map((e) => MonthlyFoodDto.fromJson(e))
            .toList(),
      );
}

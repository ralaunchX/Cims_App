class LlwdspLivestockDto {
  String type;
  int owned;
  int sold;
  int slaughtered;
  int stolen;
  int died;
  int price;

  LlwdspLivestockDto({
    required this.type,
    required this.owned,
    required this.sold,
    required this.slaughtered,
    required this.stolen,
    required this.died,
    required this.price,
  });

  // Convert to JSON (if needed)
  Map<String, dynamic> toJson() {
    return {
      'user_question': type,
      'number_owned': owned,
      'number_sold': sold,
      'number_slaughtered': slaughtered,
      'number_stolen': stolen,
      'number_died': died,
      'current_price_per_unit': price,
    };
  }

  // From JSON (if needed)
  factory LlwdspLivestockDto.fromJson(Map<String, dynamic> json) {
    return LlwdspLivestockDto(
      type: json['user_question'],
      owned: json['number_owned'],
      sold: json['number_sold'],
      slaughtered: json['number_slaughtered'],
      stolen: json['number_stolen'],
      died: json['number_died'],
      price: json['current_price_per_unit'],
    );
  }
}

class LlwdspLivestockListDto {
  final String rapId;

  final List<LlwdspLivestockDto> livestock;

  LlwdspLivestockListDto({required this.rapId, required this.livestock});

  factory LlwdspLivestockListDto.fromJson(Map<String, dynamic> json) {
    return LlwdspLivestockListDto(
      rapId: json['case'] ?? '',
      livestock: (json['livestock_details'] as List<dynamic>)
          .map((item) => LlwdspLivestockDto.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'case': rapId,
      'livestock_details': livestock.map((item) => item.toJson()).toList(),
    };
  }
}

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
      'type': type,
      'owned': owned,
      'sold': sold,
      'slaughtered': slaughtered,
      'stolen': stolen,
      'died': died,
      'price': price,
    };
  }

  // From JSON (if needed)
  factory LlwdspLivestockDto.fromJson(Map<String, dynamic> json) {
    return LlwdspLivestockDto(
      type: json['type'],
      owned: json['owned'],
      sold: json['sold'],
      slaughtered: json['slaughtered'],
      stolen: json['stolen'],
      died: json['died'],
      price: json['price'],
    );
  }
}

class LlwdspLivestockListDto {
  final String rapId;

  final List<LlwdspLivestockDto> livestock;

  LlwdspLivestockListDto({required this.rapId, required this.livestock});

  factory LlwdspLivestockListDto.fromJson(Map<String, dynamic> json) {
    return LlwdspLivestockListDto(
      rapId: json['rapId'] ?? '',
      livestock: (json['livestock'] as List<dynamic>)
          .map((item) => LlwdspLivestockDto.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rapId': rapId,
      'livestock': livestock.map((item) => item.toJson()).toList(),
    };
  }
}

class FruitTreeDto {
  String type;
  int numberOwned;
  String use;

  FruitTreeDto({
    required this.type,
    required this.numberOwned,
    required this.use,
  });

  factory FruitTreeDto.fromJson(Map<String, dynamic> json) {
    return FruitTreeDto(
      type: json['tree_type'],
      numberOwned: json['number'],
      use: json['use'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tree_type': type,
      'number': numberOwned,
      'use': use,
    };
  }
}

class LlwdspFruitTreeList {
  String rapId;
  List<FruitTreeDto> trees;

  LlwdspFruitTreeList({
    required this.rapId,
    required this.trees,
  });

  factory LlwdspFruitTreeList.fromJson(Map<String, dynamic> json) {
    return LlwdspFruitTreeList(
      rapId: json['case'],
      trees:
          (json['trees'] as List).map((e) => FruitTreeDto.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'case': rapId,
      'trees': trees.map((e) => e.toJson()).toList(),
    };
  }
}

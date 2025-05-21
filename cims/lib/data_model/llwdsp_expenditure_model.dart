class ExpenditureDto {
  String item;
  String frequency;
  bool occurredLastMonth;

  ExpenditureDto({
    this.item = '',
    this.frequency = '',
    this.occurredLastMonth = false,
  });

  Map<String, dynamic> toJson() => {
        'item': item,
        'frequency': frequency,
        'occurredLastMonth': occurredLastMonth,
      };

  factory ExpenditureDto.fromJson(Map<String, dynamic> json) => ExpenditureDto(
        item: json['item'] ?? '',
        frequency: json['frequency'] ?? '',
        occurredLastMonth: json['occurredLastMonth'] ?? false,
      );
}

class LlwdspExpenditureList {
  String rapId;
  List<ExpenditureDto> expenditureList;

  LlwdspExpenditureList({
    required this.rapId,
    required this.expenditureList,
  });

  factory LlwdspExpenditureList.fromJson(Map<String, dynamic> json) {
    return LlwdspExpenditureList(
      rapId: json['rapId'],
      expenditureList: (json['expenditureList'] as List)
          .map((e) => ExpenditureDto.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rapId': rapId,
      'expenditureList': expenditureList.map((e) => e.toJson()).toList(),
    };
  }
}

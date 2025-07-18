class ExpenditureDto {
  String item;
  String frequency;
  String? others;
  bool occurredLastMonth;

  ExpenditureDto({
    this.item = '',
    this.frequency = '',
    this.others,
    this.occurredLastMonth = false,
  });

  Map<String, dynamic> toJson() => {
        'expenditure_item': item,
        'others': others,
        'frequency': frequency,
        'last_month': occurredLastMonth,
      };

  factory ExpenditureDto.fromJson(Map<String, dynamic> json) => ExpenditureDto(
        item: json['expenditure_item'] ?? '',
        others: json['others'],
        frequency: json['frequency'] ?? '',
        occurredLastMonth: json['last_month'] ?? false,
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
      rapId: json['case'],
      expenditureList: (json['expenditureList'] as List)
          .map((e) => ExpenditureDto.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'case': rapId,
      'expenditureList': expenditureList.map((e) => e.toJson()).toList(),
    };
  }
}

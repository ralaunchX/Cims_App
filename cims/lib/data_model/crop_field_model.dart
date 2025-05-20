class CropFieldEntry {
  String? fieldNumber;
  String? ownership;
  String? cultivationMethod;
  String? mainCrop;
  String? secondCrop;
  String? seedType;
  String? fertilization;
  String? cropUse;

  CropFieldEntry({
    this.fieldNumber,
    this.ownership,
    this.cultivationMethod,
    this.mainCrop,
    this.secondCrop,
    this.seedType,
    this.fertilization,
    this.cropUse,
  });

  factory CropFieldEntry.fromJson(Map<String, dynamic> json) {
    return CropFieldEntry(
      fieldNumber: json['fieldNumber'],
      ownership: json['ownership'],
      cultivationMethod: json['cultivationMethod'],
      mainCrop: json['mainCrop'],
      secondCrop: json['secondCrop'],
      seedType: json['seedType'],
      fertilization: json['fertilization'],
      cropUse: json['cropUse'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fieldNumber': fieldNumber,
      'ownership': ownership,
      'cultivationMethod': cultivationMethod,
      'mainCrop': mainCrop,
      'secondCrop': secondCrop,
      'seedType': seedType,
      'fertilization': fertilization,
      'cropUse': cropUse,
    };
  }
}

class LlwdspCropFieldModel {
  int fieldsOwned;
  int fieldsCultivated;
  String selectedNonCultivationReason;
  List<CropFieldEntry> cropFields;

  LlwdspCropFieldModel({
    required this.fieldsOwned,
    required this.fieldsCultivated,
    required this.selectedNonCultivationReason,
    required this.cropFields,
  });

  factory LlwdspCropFieldModel.fromJson(Map<String, dynamic> json) {
    return LlwdspCropFieldModel(
      fieldsOwned: json['fieldsOwned'],
      fieldsCultivated: json['fieldsCultivated'],
      selectedNonCultivationReason: json['selectedNonCultivationReason'],
      cropFields: (json['cropFields'] as List<dynamic>?)
              ?.map((e) => CropFieldEntry.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fieldsOwned': fieldsOwned,
      'fieldsCultivated': fieldsCultivated,
      'selectedNonCultivationReason': selectedNonCultivationReason,
      'cropFields': cropFields.map((e) => e.toJson()).toList(),
    };
  }
}

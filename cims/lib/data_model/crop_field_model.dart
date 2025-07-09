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
      fieldNumber: json['field_number'],
      ownership: json['ownership'],
      cultivationMethod: json['cultivation_method'],
      mainCrop: json['main_crop'],
      secondCrop: json['second_crop'],
      seedType: json['seed_type'],
      fertilization: json['fertilization'],
      cropUse: json['crop_use'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'field_number': fieldNumber,
      'ownership': ownership,
      'cultivation_method': cultivationMethod,
      'main_crop': mainCrop,
      'second_crop': secondCrop,
      'seed_type': seedType,
      'fertilization': fertilization,
      'crop_use': cropUse,
    };
  }
}

class LlwdspCropFieldModel {
  final String rapId;

  int fieldsOwned;
  int fieldsCultivated;
  String selectedNonCultivationReason;
  List<CropFieldEntry> cropFields;

  LlwdspCropFieldModel({
    required this.rapId,
    required this.fieldsOwned,
    required this.fieldsCultivated,
    required this.selectedNonCultivationReason,
    required this.cropFields,
  });

  factory LlwdspCropFieldModel.fromJson(Map<String, dynamic> json) {
    return LlwdspCropFieldModel(
      rapId: json['case'] ?? '',
      fieldsOwned: json['fields_owned'],
      fieldsCultivated: json['fields_cultivated'],
      selectedNonCultivationReason: json['non_cultivation_reason'],
      cropFields: (json['crop_field_details'] as List<dynamic>?)
              ?.map((e) => CropFieldEntry.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'case': rapId,
      'fields_owned': fieldsOwned,
      'fields_cultivated': fieldsCultivated,
      'non_cultivation_reason': selectedNonCultivationReason,
      'crop_field_details': cropFields.map((e) => e.toJson()).toList(),
    };
  }
}

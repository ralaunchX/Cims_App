class LLdwspAssetsModel {
  final String rapId;
  final String dwellingOwnership;
  final String wallMaterial;
  final String roofMaterial;
  final String floorMaterial;
  final List<String> selectedStructuresServices;
  final List<String> selectedOtherStructures;
  final List<String> selectedHouseholdItems;
  final List<String> selectedAppliances;
  final List<String> selectedAgriculturalEquipment;

  LLdwspAssetsModel({
    required this.rapId,
    required this.dwellingOwnership,
    required this.wallMaterial,
    required this.roofMaterial,
    required this.floorMaterial,
    required this.selectedStructuresServices,
    required this.selectedOtherStructures,
    required this.selectedHouseholdItems,
    required this.selectedAppliances,
    required this.selectedAgriculturalEquipment,
  });

  Map<String, dynamic> toJson() {
    return {
      'rapId': rapId,
      'dwellingOwnership': dwellingOwnership,
      'wallMaterial': wallMaterial,
      'roofMaterial': roofMaterial,
      'floorMaterial': floorMaterial,
      'selectedStructuresServices': selectedStructuresServices,
      'selectedOtherStructures': selectedOtherStructures,
      'selectedHouseholdItems': selectedHouseholdItems,
      'selectedAppliances': selectedAppliances,
      'selectedAgriculturalEquipment': selectedAgriculturalEquipment,
    };
  }

  factory LLdwspAssetsModel.fromJson(Map<String, dynamic> json) {
    return LLdwspAssetsModel(
      rapId: json['rapId'] ?? '',
      dwellingOwnership: json['dwellingOwnership'] ?? '',
      wallMaterial: json['wallMaterial'] ?? '',
      roofMaterial: json['roofMaterial'] ?? '',
      floorMaterial: json['floorMaterial'] ?? '',
      selectedStructuresServices:
          List<String>.from(json['selectedStructuresServices'] ?? []),
      selectedOtherStructures:
          List<String>.from(json['selectedOtherStructures'] ?? []),
      selectedHouseholdItems:
          List<String>.from(json['selectedHouseholdItems'] ?? []),
      selectedAppliances: List<String>.from(json['selectedAppliances'] ?? []),
      selectedAgriculturalEquipment:
          List<String>.from(json['selectedAgriculturalEquipment'] ?? []),
    );
  }
}

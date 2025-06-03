class LLdwspAssetsModel {
  final String caseId;
  final int dwellingOwnership;
  final int wallMaterial;
  final int roofMaterial;
  final int floorMaterial;
  final List<int> selectedStructuresServices;
  final List<int> selectedOtherStructures;
  final List<int> selectedHouseholdItems;
  final List<int> selectedAppliances;
  final List<int> selectedAgriculturalEquipment;

  LLdwspAssetsModel({
    required this.caseId,
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
      'case': caseId,
      'own_rent': dwellingOwnership,
      'wall_material': wallMaterial,
      'roof_material': roofMaterial,
      'floor_material': floorMaterial,
      'structures_services': selectedStructuresServices,
      'additional_structures': selectedOtherStructures,
      'household_items': selectedHouseholdItems,
      'appliances': selectedAppliances,
      'agricultural_equipment': selectedAgriculturalEquipment,
    };
  }

  factory LLdwspAssetsModel.fromJson(Map<String, dynamic> json) {
    return LLdwspAssetsModel(
      caseId: json['case'] ?? 0,
      dwellingOwnership: json['own_rent'] ?? 0,
      wallMaterial: json['wall_material'] ?? 0,
      roofMaterial: json['roof_material'] ?? 0,
      floorMaterial: json['floor_material'] ?? 0,
      selectedStructuresServices:
          List<int>.from(json['structures_services'] ?? []),
      selectedOtherStructures:
          List<int>.from(json['additional_structures'] ?? []),
      selectedHouseholdItems: List<int>.from(json['household_items'] ?? []),
      selectedAppliances: List<int>.from(json['appliances'] ?? []),
      selectedAgriculturalEquipment:
          List<int>.from(json['agricultural_equipment'] ?? []),
    );
  }
}

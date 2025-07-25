class AssetDetailsDto {
  final String rapId;

  final String assetType;
  final String assetCategory;
  final String village;
  final String gpsCoordinates;
  final String? contract;
  final String? other;
  final String? affectedPhoto;

  AssetDetailsDto({
    required this.rapId,
    required this.assetType,
    required this.assetCategory,
    required this.village,
    required this.gpsCoordinates,
    required this.contract,
    required this.other,
    required this.affectedPhoto,
  });

  Map<String, dynamic> toJson() => {
        'case': rapId,
        'asset_type': assetType,
        'asset_category': assetCategory,
        'village': village,
        'gps_coordinates': gpsCoordinates,
        'other': other,
        'photographs_of_affected_assets': affectedPhoto,
        'asset_contract': contract,
      };

  factory AssetDetailsDto.fromJson(Map<String, dynamic> json) =>
      AssetDetailsDto(
          rapId: json['case'],
          assetType: json['asset_type'],
          assetCategory: json['asset_category'],
          village: json['village'],
          gpsCoordinates: json['gps_coordinates'],
          affectedPhoto: json['photographs_of_affected_assets'],
          contract: json['asset_contract'],
          other: json['other']);
}

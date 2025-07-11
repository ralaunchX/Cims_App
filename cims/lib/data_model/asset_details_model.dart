class AssetDetailsDto {
  final String rapId;

  final String assetType;
  final String assetCategory;
  final String village;
  final String gpsCoordinates;

  AssetDetailsDto({
    required this.rapId,
    required this.assetType,
    required this.assetCategory,
    required this.village,
    required this.gpsCoordinates,
  });

  Map<String, dynamic> toJson() => {
        'case': rapId,
        'asset_type': assetType,
        'asset_category': assetCategory,
        'village': village,
        'gps_coordinates': gpsCoordinates,
      };

  factory AssetDetailsDto.fromJson(Map<String, dynamic> json) =>
      AssetDetailsDto(
        rapId: json['case'],
        assetType: json['asset_type'],
        assetCategory: json['asset_category'],
        village: json['village'],
        gpsCoordinates: json['gps_coordinates'],
      );
}

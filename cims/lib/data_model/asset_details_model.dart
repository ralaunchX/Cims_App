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
        'rapId': rapId,
        'assetType': assetType,
        'assetCategory': assetCategory,
        'village': village,
        'gpsCoordinates': gpsCoordinates,
      };

  factory AssetDetailsDto.fromJson(Map<String, dynamic> json) =>
      AssetDetailsDto(
        rapId: json['rapId'],
        assetType: json['assetType'],
        assetCategory: json['assetCategory'],
        village: json['village'],
        gpsCoordinates: json['gpsCoordinates'],
      );
}

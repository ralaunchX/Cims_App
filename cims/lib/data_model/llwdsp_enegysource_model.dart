class EnergySourcesDto {
  String? rapId;
  String? electricityLighting;
  String? gasLighting;
  String? paraffinLighting;
  String? woodLighting;
  String? candleLighting;
  String? batteryLighting;
  String? solarLighting;
  String? generatorLighting;
  String? brushwoodLighting;

  String? electricityCooking;
  String? gasCooking;
  String? paraffinCooking;
  String? woodCooking;
  String? batteryCooking;
  String? generatorCooking;

  EnergySourcesDto({
    required this.rapId,
    required this.electricityLighting,
    required this.gasLighting,
    required this.paraffinLighting,
    required this.woodLighting,
    required this.candleLighting,
    required this.batteryLighting,
    required this.solarLighting,
    required this.generatorLighting,
    required this.brushwoodLighting,
    required this.electricityCooking,
    required this.gasCooking,
    required this.paraffinCooking,
    required this.woodCooking,
    required this.batteryCooking,
    required this.generatorCooking,
  });

  Map<String, dynamic> toJson() => {
        'case': rapId,
        'lighting_electricity': electricityLighting,
        'lighting_gas': gasLighting,
        'lighting_paraffin': paraffinLighting,
        'lighting_wood': woodLighting,
        'lighting_candle': candleLighting,
        'lighting_battery': batteryLighting,
        'lighting_solar': solarLighting,
        'lighting_generator': generatorLighting,
        'lighting_brushwood': brushwoodLighting,
        'cooking_electricity': electricityCooking,
        'cooking_gas': gasCooking,
        'cooking_paraffin': paraffinCooking,
        'cooking_wood': woodCooking,
        'cooking_battery': batteryCooking,
        'cooking_generator': generatorCooking,
      };

  factory EnergySourcesDto.fromJson(Map<String, dynamic> json) =>
      EnergySourcesDto(
        rapId: json['case'] ?? '',
        electricityLighting: json['lighting_electricity'],
        gasLighting: json['lighting_gas'],
        paraffinLighting: json['lighting_paraffin'],
        woodLighting: json['lighting_wood'],
        candleLighting: json['lighting_candle'],
        batteryLighting: json['lighting_battery'],
        solarLighting: json['lighting_solar'],
        generatorLighting: json['lighting_generator'],
        brushwoodLighting: json['lighting_brushwood'],
        electricityCooking: json['cooking_electricity'],
        gasCooking: json['cooking_gas'],
        paraffinCooking: json['cooking_paraffin'],
        woodCooking: json['cooking_wood'],
        batteryCooking: json['cooking_battery'],
        generatorCooking: json['cooking_generator'],
      );
}

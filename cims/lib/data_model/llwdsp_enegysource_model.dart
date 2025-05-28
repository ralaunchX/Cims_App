class EnergySourcesDto {
  String? rapId;
  bool? electricityLighting;
  bool? gasLighting;
  bool? paraffinLighting;
  bool? woodLighting;
  bool? candleLighting;
  bool? batteryLighting;
  bool? solarLighting;
  bool? generatorLighting;
  bool? brushwoodLighting;

  bool? electricityCooking;
  bool? gasCooking;
  bool? paraffinCooking;
  bool? woodCooking;
  bool? batteryCooking;
  bool? generatorCooking;

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
        'rapId': rapId,
        'electricityLighting': electricityLighting,
        'gasLighting': gasLighting,
        'paraffinLighting': paraffinLighting,
        'woodLighting': woodLighting,
        'candleLighting': candleLighting,
        'batteryLighting': batteryLighting,
        'solarLighting': solarLighting,
        'generatorLighting': generatorLighting,
        'brushwoodLighting': brushwoodLighting,
        'electricityCooking': electricityCooking,
        'gasCooking': gasCooking,
        'paraffinCooking': paraffinCooking,
        'woodCooking': woodCooking,
        'batteryCooking': batteryCooking,
        'generatorCooking': generatorCooking,
      };

  factory EnergySourcesDto.fromJson(Map<String, dynamic> json) =>
      EnergySourcesDto(
        rapId: json['rapId'] ?? '',
        electricityLighting: json['electricityLighting'],
        gasLighting: json['gasLighting'],
        paraffinLighting: json['paraffinLighting'],
        woodLighting: json['woodLighting'],
        candleLighting: json['candleLighting'],
        batteryLighting: json['batteryLighting'],
        solarLighting: json['solarLighting'],
        generatorLighting: json['generatorLighting'],
        brushwoodLighting: json['brushwoodLighting'],
        electricityCooking: json['electricityCooking'],
        gasCooking: json['gasCooking'],
        paraffinCooking: json['paraffinCooking'],
        woodCooking: json['woodCooking'],
        batteryCooking: json['batteryCooking'],
        generatorCooking: json['generatorCooking'],
      );
}

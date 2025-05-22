class LlwdspTransportModel {
  final String rapId;
  final String distanceToTransport;
  final String transportFrequency;
  final Map<String, String> transportModes;

  LlwdspTransportModel({
    required this.rapId,
    required this.distanceToTransport,
    required this.transportFrequency,
    required this.transportModes,
  });

  factory LlwdspTransportModel.fromJson(Map<String, dynamic> json) {
    return LlwdspTransportModel(
      rapId: json['rapId'] ?? '',
      distanceToTransport: json['distanceToTransport'] ?? '',
      transportFrequency: json['transportFrequency'] ?? '',
      transportModes: Map<String, String>.from(json['transportModes'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rapId': rapId,
      'distanceToTransport': distanceToTransport,
      'transportFrequency': transportFrequency,
      'transportModes': transportModes,
    };
  }
}

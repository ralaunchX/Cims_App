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
      rapId: json['case'].toString(),
      distanceToTransport: json['distance_to_transport'].toString(),
      transportFrequency: json['transport_frequency'] ?? '',
      transportModes: {
        'school_transport': json['school_transport'] ?? '',
        'health_transport': json['health_transport'] ?? '',
        'shops_transport': json['shops_transport'] ?? '',
        'roller_mill_transport': json['roller_mill_transport'] ?? '',
        'community_council_transport':
            json['community_council_transport'] ?? '',
        'police_transport': json['police_transport'] ?? '',
      },
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'case': rapId,
      'distance_to_transport': distanceToTransport,
      'transport_frequency': transportFrequency,
      ...transportModes,
    };
  }
}

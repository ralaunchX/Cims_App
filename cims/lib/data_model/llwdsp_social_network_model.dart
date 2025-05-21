class LlwdspSocialNetworkModel {
  final String rapId;

  String? givingSupportCategory;
  String? givingSupportFrequency;
  String? givingSupportRelation;

  String? receivingSupportCategory;
  String? receivingSupportFrequency;
  String? receivingSupportRelation;

  LlwdspSocialNetworkModel({
    required this.rapId,
    required this.givingSupportCategory,
    required this.givingSupportFrequency,
    required this.givingSupportRelation,
    required this.receivingSupportCategory,
    required this.receivingSupportFrequency,
    required this.receivingSupportRelation,
  });

  factory LlwdspSocialNetworkModel.fromJson(Map<String, dynamic> json) {
    return LlwdspSocialNetworkModel(
      rapId: json['rapId'] ?? '',
      givingSupportCategory: json['givingSupportCategory'],
      givingSupportFrequency: json['givingSupportFrequency'],
      givingSupportRelation: json['givingSupportRelation'],
      receivingSupportCategory: json['receivingSupportCategory'],
      receivingSupportFrequency: json['receivingSupportFrequency'],
      receivingSupportRelation: json['receivingSupportRelation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rapId': rapId,
      'givingSupportCategory': givingSupportCategory,
      'givingSupportFrequency': givingSupportFrequency,
      'givingSupportRelation': givingSupportRelation,
      'receivingSupportCategory': receivingSupportCategory,
      'receivingSupportFrequency': receivingSupportFrequency,
      'receivingSupportRelation': receivingSupportRelation,
    };
  }
}

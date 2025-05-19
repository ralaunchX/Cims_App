class LlwdspSocialNetworkModel {
  String? givingSupportCategory;
  String? givingSupportFrequency;
  String? givingSupportRelation;

  String? receivingSupportCategory;
  String? receivingSupportFrequency;
  String? receivingSupportRelation;

  LlwdspSocialNetworkModel({
    required this.givingSupportCategory,
    required this.givingSupportFrequency,
    required this.givingSupportRelation,
    required this.receivingSupportCategory,
    required this.receivingSupportFrequency,
    required this.receivingSupportRelation,
  });

  factory LlwdspSocialNetworkModel.fromJson(Map<String, dynamic> json) {
    return LlwdspSocialNetworkModel(
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
      'givingSupportCategory': givingSupportCategory,
      'givingSupportFrequency': givingSupportFrequency,
      'givingSupportRelation': givingSupportRelation,
      'receivingSupportCategory': receivingSupportCategory,
      'receivingSupportFrequency': receivingSupportFrequency,
      'receivingSupportRelation': receivingSupportRelation,
    };
  }
}

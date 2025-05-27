class SkillKnowledge {
  String refNo;
  String dominantSkill;
  String skillAcquisition;
  String skillIncomeSource;
  String anotherSkill;
  String literacyLevel;

  SkillKnowledge({
    required this.refNo,
    required this.dominantSkill,
    required this.skillAcquisition,
    required this.skillIncomeSource,
    required this.anotherSkill,
    required this.literacyLevel,
  });

  Map<String, dynamic> toJson() => {
        'refNo': refNo,
        'dominantSkill': dominantSkill,
        'skillAcquisition': skillAcquisition,
        'skillIncomeSource': skillIncomeSource,
        'anotherSkill': anotherSkill,
        'literacyLevel': literacyLevel,
      };

  factory SkillKnowledge.fromJson(Map<String, dynamic> json) => SkillKnowledge(
        refNo: json['refNo'] ?? '',
        dominantSkill: json['dominantSkill'] ?? '',
        skillAcquisition: json['skillAcquisition'] ?? '',
        skillIncomeSource: json['skillIncomeSource'] ?? '',
        anotherSkill: json['anotherSkill'] ?? '',
        literacyLevel: json['literacyLevel'] ?? '',
      );
}

class ListSkillKnowledge {
  String rapId;
  List<SkillKnowledge> skillKnowledgeList;

  ListSkillKnowledge({
    required this.rapId,
    required this.skillKnowledgeList,
  });

  Map<String, dynamic> toJson() => {
        'rapId': rapId,
        'skillKnowledgeList':
            skillKnowledgeList.map((e) => e.toJson()).toList(),
      };

  factory ListSkillKnowledge.fromJson(Map<String, dynamic> json) =>
      ListSkillKnowledge(
        rapId: json['rapId'] ?? '',
        skillKnowledgeList: (json['skillKnowledgeList'] as List)
            .map((e) => SkillKnowledge.fromJson(e))
            .toList(),
      );
}

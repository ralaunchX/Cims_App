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
        'ref_no': refNo,
        'dominant_skill': dominantSkill,
        'skill_acquisition': skillAcquisition,
        'skill_income_source': skillIncomeSource,
        'another_skill': anotherSkill,
        'literacy_level': literacyLevel,
      };

  factory SkillKnowledge.fromJson(Map<String, dynamic> json) => SkillKnowledge(
        refNo: json['ref_no'] ?? '',
        dominantSkill: json['dominant_skill'] ?? '',
        skillAcquisition: json['skill_acquisition'] ?? '',
        skillIncomeSource: json['skill_income_source'] ?? '',
        anotherSkill: json['another_skill'] ?? '',
        literacyLevel: json['literacy_level'] ?? '',
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
        'case': rapId,
        'skillKnowledgeList':
            skillKnowledgeList.map((e) => e.toJson()).toList(),
      };

  factory ListSkillKnowledge.fromJson(Map<String, dynamic> json) =>
      ListSkillKnowledge(
        rapId: json['case'] ?? '',
        skillKnowledgeList: (json['skillKnowledgeList'] as List)
            .map((e) => SkillKnowledge.fromJson(e))
            .toList(),
      );
}

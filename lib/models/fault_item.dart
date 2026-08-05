class FaultItem {
  final String code;
  final String titleAr;
  final String titleEn;
  final String causesAr;
  final String solutionsAr;
  final List<String> aliases;

  FaultItem({
    required this.code,
    required this.titleAr,
    required this.titleEn,
    required this.causesAr,
    required this.solutionsAr,
    required this.aliases,
  });

  factory FaultItem.fromJson(Map<String, dynamic> json) {
    return FaultItem(
      code: json['code'] ?? '',
      titleAr: json['title_ar'] ?? '',
      titleEn: json['title_en'] ?? '',
      causesAr: json['causes_ar'] ?? '',
      solutionsAr: json['solutions_ar'] ?? '',
      aliases: List<String>.from(json['aliases'] ?? []),
    );
  }
}

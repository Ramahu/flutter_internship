class SubjectModel {
  SubjectModel({
    required this.id,
    required this.curriculumId,
    required this.name,
    required this.level,
    required this.file,
    required this.numberSession,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      id: json['id'],
      curriculumId: json['curriculum_id'],
      name: json['name'],
      level: json['level'],
      file: json['file'],
      numberSession: json['number_session'],
    );
  }
  final int id;
  final int curriculumId;
  final String name;
  final String level;
  final String? file;
  final int numberSession;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'curriculum_id': curriculumId,
      'name': name,
      'level': level,
      'file': file,
      'number_session': numberSession,
    };
  }
}

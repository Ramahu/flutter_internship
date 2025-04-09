class LessonModel {
  LessonModel({
    required this.id,
    required this.subjectId,
    required this.meetingId,
    required this.creatingBy,
    required this.creatingByName,
    required this.topic,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.password,
    required this.startUrl,
    required this.joinUrl,
    required this.sectionId,
    required this.subject,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'],
      subjectId: json['subject_id'],
      meetingId: json['meeting_id'],
      creatingBy: json['creating_by'],
      creatingByName: json['creating_by_name'],
      topic: json['topic'],
      day: DateTime.parse(json['day']),
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      duration: json['duration'],
      password: json['password'],
      startUrl: json['start_url'],
      joinUrl: json['join_url'],
      sectionId: json['section_id'],
      subject: SubjecttModel.fromJson(json['subject']),
    );
  }
  final int id;
  final int subjectId;
  final String meetingId;
  final String creatingBy;
  final String creatingByName;
  final String topic;
  final DateTime day;
  final DateTime startTime;
  final DateTime endTime;
  final int duration;
  final String password;
  final String startUrl;
  final String joinUrl;
  final int sectionId;
  final SubjecttModel subject;
}

class SubjecttModel {
  SubjecttModel({required this.id, required this.name});

  factory SubjecttModel.fromJson(Map<String, dynamic> json) {
    return SubjecttModel(
      id: json['id'],
      name: json['name'],
    );
  }
  final int id;
  final String name;
}

class MetaModel {
  MetaModel({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    required this.hasMore,
    required this.hasPrev,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      perPage: json['per_page'],
      total: json['total'],
      hasMore: json['has_more'],
      hasPrev: json['has_prev'],
    );
  }
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final bool hasMore;
  final bool hasPrev;
}

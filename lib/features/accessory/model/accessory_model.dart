class AccessoryModel {
  AccessoryModel({
    required this.id,
    required this.classId,
    required this.sectionId,
    required this.topic,
    required this.file,
    required this.images,
    required this.videos,
    required this.url,
    required this.ar,
    required this.audio,
  });

  factory AccessoryModel.fromJson(Map<String, dynamic> json) {
    return AccessoryModel(
      id: json['id'],
      classId: json['class_id'],
      sectionId: json['section_id'],
      topic: json['topic'],
      file: json['file'],
      images: json['images'],
      videos: json['videos'],
      url: json['url'],
      ar: json['ar'],
      audio: json['audio'],
    );
  }

  final int id;
  final int classId;
  final int sectionId;
  final String topic;
  final String file;
  final String images;
  final String videos;
  final String url;
  final String ar;
  final String audio;
}

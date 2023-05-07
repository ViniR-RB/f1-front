// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NoticeModel {
  final int id;
  final int creatorId;
  final String creator;
  final String title;
  final String body;
  final String image;
  final String creationDate;
  NoticeModel({
    required this.id,
    required this.creatorId,
    required this.creator,
    required this.title,
    required this.body,
    required this.image,
    required this.creationDate,
  });

  NoticeModel copyWith({
    int? id,
    int? creatorId,
    String? creator,
    String? title,
    String? body,
    String? image,
    String? creationDate,
  }) {
    return NoticeModel(
      id: id ?? this.id,
      creatorId: creatorId ?? this.creatorId,
      creator: creator ?? this.creator,
      title: title ?? this.title,
      body: body ?? this.body,
      image: image ?? this.image,
      creationDate: creationDate ?? this.creationDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'creator_id': creatorId,
      'creator': creator,
      'title': title,
      'body': body,
      'image': image,
      'creation_date': creationDate,
    };
  }

  factory NoticeModel.fromMap(Map<String, dynamic> map) {
    return NoticeModel(
      id: map['id'] as int,
      creatorId: map['creator_id'] as int,
      creator: map['creator'] as String,
      title: map['title'] as String,
      body: map['body'] as String,
      image: map['image'] as String,
      creationDate: map['creation_date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NoticeModel.fromJson(String source) =>
      NoticeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Notice(id: $id, creator_id: $creatorId, creator: $creator, title: $title, body: $body, image: $image, creation_date: $creationDate)';
  }

  @override
  bool operator ==(covariant NoticeModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.creatorId == creatorId &&
        other.creator == creator &&
        other.title == title &&
        other.body == body &&
        other.image == image &&
        other.creationDate == creationDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        creatorId.hashCode ^
        creator.hashCode ^
        title.hashCode ^
        body.hashCode ^
        image.hashCode ^
        creationDate.hashCode;
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class quizEventsModel {
  final String id;
  final String title;
  final String description;
  final String metaverseLink;
  final String finishedAt;
  final String sponsorId;
  final bool isActive;
  final String createdAt;
  final String updatedAt;
  final String bannerUrl;
  quizEventsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.metaverseLink,
    required this.finishedAt,
    required this.sponsorId,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.bannerUrl,
  });

  quizEventsModel copyWith({
    String? id,
    String? title,
    String? description,
    String? metaverseLink,
    String? finishedAt,
    String? sponsorId,
    bool? isActive,
    String? createdAt,
    String? updatedAt,
    String? bannerUrl,
  }) {
    return quizEventsModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      metaverseLink: metaverseLink ?? this.metaverseLink,
      finishedAt: finishedAt ?? this.finishedAt,
      sponsorId: sponsorId ?? this.sponsorId,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      bannerUrl: bannerUrl ?? this.bannerUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'metaverseLink': metaverseLink,
      'finishedAt': finishedAt,
      'sponsorId': sponsorId,
      'isActive': isActive,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'bannerUrl': bannerUrl,
    };
  }

  factory quizEventsModel.fromMap(Map<String, dynamic> map) {
    return quizEventsModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      metaverseLink: map['metaverseLink'] as String,
      finishedAt: map['finishedAt'] as String,
      sponsorId: map['sponsorId'] as String,
      isActive: map['isActive'] as bool,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      bannerUrl: map['bannerUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory quizEventsModel.fromJson(String source) => quizEventsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'quizEventsModel(id: $id, title: $title, description: $description, metaverseLink: $metaverseLink, finishedAt: $finishedAt, sponsorId: $sponsorId, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, bannerUrl: $bannerUrl)';
  }

  @override
  bool operator ==(covariant quizEventsModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.description == description &&
      other.metaverseLink == metaverseLink &&
      other.finishedAt == finishedAt &&
      other.sponsorId == sponsorId &&
      other.isActive == isActive &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt &&
      other.bannerUrl == bannerUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      metaverseLink.hashCode ^
      finishedAt.hashCode ^
      sponsorId.hashCode ^
      isActive.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      bannerUrl.hashCode;
  }
}

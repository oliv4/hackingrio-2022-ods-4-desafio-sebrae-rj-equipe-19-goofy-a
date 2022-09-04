// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChallengeModel {
  final String id;
  final String title;
  final String description;
  final List<dynamic> questions;
  final bool isActive;
  final String finishedAt;
  final String createdAt;
  final String updatedAt;
  ChallengeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
    required this.isActive,
    required this.finishedAt,
    required this.createdAt,
    required this.updatedAt,
  });


  ChallengeModel copyWith({
  String? id,
  String? title,
  String? description,
  List<dynamic>? questions,
  bool? isActive,
  String? finishedAt,
  String? createdAt,
  String? updatedAt,
  }) {
    return ChallengeModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      questions: questions ?? this.questions,
      isActive: isActive ?? this.isActive,
      finishedAt: finishedAt ?? this.finishedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'questions': questions,
      'isActive': isActive,
      'finishedAt': finishedAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory ChallengeModel.fromMap(Map<String, dynamic> map) {
    return ChallengeModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      questions: map['questions'] as List<dynamic>,
      isActive: map['isActive'] as bool,
      finishedAt: map['finishedAt'] as String,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChallengeModel.fromJson(String source) => ChallengeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChallengeModel(id: $id, title: $title, description: $description, questions: $questions, isActive: $isActive, finishedAt: $finishedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant ChallengeModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.description == description &&
      other.questions == questions &&
      other.isActive == isActive &&
      other.finishedAt == finishedAt &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      questions.hashCode ^
      isActive.hashCode ^
      finishedAt.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}

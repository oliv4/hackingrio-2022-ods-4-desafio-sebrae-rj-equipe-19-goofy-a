// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Events {
  final String id;
  final String challengeId;
  final String challengeType;
  final String eventId;
  final bool isActive;
  final String createdAt;
  final String updatedAt;
  Events({
    required this.id,
    required this.challengeId,
    required this.challengeType,
    required this.eventId,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });


  Events copyWith({
    String? id,
    String? challengeId,
    String? challengeType,
    String? eventId,
    bool? isActive,
    String? createdAt,
    String? updatedAt,
  }) {
    return Events(
      id: id ?? this.id,
      challengeId: challengeId ?? this.challengeId,
      challengeType: challengeType ?? this.challengeType,
      eventId: eventId ?? this.eventId,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'challengeId': challengeId,
      'challengeType': challengeType,
      'eventId': eventId,
      'isActive': isActive,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Events.fromMap(Map<String, dynamic> map) {
    return Events(
      id: map['id'] as String,
      challengeId: map['challengeId'] as String,
      challengeType: map['challengeType'] as String,
      eventId: map['eventId'] as String,
      isActive: map['isActive'] as bool,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Events.fromJson(String source) => Events.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Events(id: $id, challengeId: $challengeId, challengeType: $challengeType, eventId: $eventId, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Events other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.challengeId == challengeId &&
      other.challengeType == challengeType &&
      other.eventId == eventId &&
      other.isActive == isActive &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      challengeId.hashCode ^
      challengeType.hashCode ^
      eventId.hashCode ^
      isActive.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}

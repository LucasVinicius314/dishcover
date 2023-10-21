// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'typesense_hit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypesenseHit _$TypesenseHitFromJson(Map<String, dynamic> json) => TypesenseHit(
      document: json['document'] == null
          ? null
          : Recipe.fromJson(json['document'] as Map<String, dynamic>),
    )..highlight = (json['highlight'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
            k, TypesenseHitHighlight.fromJson(e as Map<String, dynamic>)),
      );

Map<String, dynamic> _$TypesenseHitToJson(TypesenseHit instance) =>
    <String, dynamic>{
      'document': instance.document?.toJson(),
      'highlight': instance.highlight?.map((k, e) => MapEntry(k, e.toJson())),
    };

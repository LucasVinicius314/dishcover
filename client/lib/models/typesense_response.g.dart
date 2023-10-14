// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'typesense_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypesenseResponse _$TypesenseResponseFromJson(Map<String, dynamic> json) =>
    TypesenseResponse(
      found: json['found'] as int?,
      outOf: json['outOf'] as int?,
      page: json['page'] as int?,
      hits: (json['hits'] as List<dynamic>?)
          ?.map((e) => TypesenseHit.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TypesenseResponseToJson(TypesenseResponse instance) =>
    <String, dynamic>{
      'found': instance.found,
      'outOf': instance.outOf,
      'page': instance.page,
      'hits': instance.hits?.map((e) => e.toJson()).toList(),
    };

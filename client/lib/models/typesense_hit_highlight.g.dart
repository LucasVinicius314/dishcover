// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'typesense_hit_highlight.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypesenseHitHighlight _$TypesenseHitHighlightFromJson(
        Map<String, dynamic> json) =>
    TypesenseHitHighlight(
      matchedTokens: (json['matchedTokens'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$TypesenseHitHighlightToJson(
        TypesenseHitHighlight instance) =>
    <String, dynamic>{
      'matchedTokens': instance.matchedTokens,
    };

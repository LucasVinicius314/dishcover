import 'package:json_annotation/json_annotation.dart';

part 'typesense_hit_highlight.g.dart';

@JsonSerializable(fieldRename: FieldRename.none, explicitToJson: true)
class TypesenseHitHighlight {
  TypesenseHitHighlight({
    required this.matchedTokens,
  });

  List<String>? matchedTokens;

  factory TypesenseHitHighlight.fromJson(Map<String, dynamic> json) =>
      _$TypesenseHitHighlightFromJson(json);

  Map<String, dynamic> toJson() => _$TypesenseHitHighlightToJson(this);
}

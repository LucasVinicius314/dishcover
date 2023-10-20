import 'package:dishcover_client/models/recipe.dart';
import 'package:dishcover_client/models/typesense_hit_highlight.dart';
import 'package:json_annotation/json_annotation.dart';

part 'typesense_hit.g.dart';

@JsonSerializable(fieldRename: FieldRename.none, explicitToJson: true)
class TypesenseHit {
  TypesenseHit({
    required this.document,
  });

  Recipe? document;
  Map<String, TypesenseHitHighlight>? highlight;

  factory TypesenseHit.fromJson(Map<String, dynamic> json) =>
      _$TypesenseHitFromJson(json);

  Map<String, dynamic> toJson() => _$TypesenseHitToJson(this);
}

import 'package:dishcover_client/models/typesense_hit.dart';
import 'package:json_annotation/json_annotation.dart';

part 'typesense_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.none, explicitToJson: true)
class TypesenseResponse {
  TypesenseResponse({
    required this.found,
    required this.outOf,
    required this.page,
    required this.hits,
  });

  int? found;
  int? outOf;
  int? page;
  List<TypesenseHit>? hits;

  factory TypesenseResponse.fromJson(Map<String, dynamic> json) =>
      _$TypesenseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TypesenseResponseToJson(this);
}

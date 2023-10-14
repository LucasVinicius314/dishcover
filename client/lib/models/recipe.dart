import 'package:json_annotation/json_annotation.dart';

part 'recipe.g.dart';

@JsonSerializable(fieldRename: FieldRename.none, explicitToJson: true)
class Recipe {
  Recipe({
    required this.cleanedIngredients,
    required this.id,
    required this.imageName,
    required this.ingredients,
    required this.instructions,
    required this.title,
  });

  String? cleanedIngredients;
  String? id;
  String? imageName;
  String? ingredients;
  String? instructions;
  String? title;

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeToJson(this);
}

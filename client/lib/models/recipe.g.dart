// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recipe _$RecipeFromJson(Map<String, dynamic> json) => Recipe(
      cleanedIngredients: json['cleanedIngredients'] as String?,
      id: json['id'] as String?,
      imageName: json['imageName'] as String?,
      ingredients: json['ingredients'] as String?,
      instructions: json['instructions'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'cleanedIngredients': instance.cleanedIngredients,
      'id': instance.id,
      'imageName': instance.imageName,
      'ingredients': instance.ingredients,
      'instructions': instance.instructions,
      'title': instance.title,
    };

import 'package:dishcover_client/models/typesense_response.dart';

abstract class RecipeState {}

// Base.

class InitialRecipeState extends RecipeState {}

class RecipeLoadingState extends RecipeState {}

// GetRecipes.

class GetRecipesDoneState extends RecipeState {
  GetRecipesDoneState({
    required this.typesenseResponse,
  });

  final TypesenseResponse typesenseResponse;
}

class GetRecipesErrorState extends RecipeState {}

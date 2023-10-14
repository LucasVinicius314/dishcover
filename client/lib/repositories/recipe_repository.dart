import 'package:dishcover_client/models/typesense_response.dart';
import 'package:dishcover_client/services/api.dart';
import 'package:flutter/services.dart';

class RecipeRepository {
  const RecipeRepository({
    required this.api,
  });

  final Api api;

  Future<TypesenseResponse> getRecipes({
    required Uint8List? fileBytes,
  }) async {
    final res = await api.postForm(
      path: 'recipe',
      fileBytes: fileBytes,
    );

    return TypesenseResponse.fromJson(res);
  }
}

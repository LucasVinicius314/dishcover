import 'package:flutter/services.dart';

abstract class RecipeEvent {}

class GetRecipesEvent extends RecipeEvent {
  GetRecipesEvent({
    required this.fileBytes,
  });

  final Uint8List? fileBytes;
}

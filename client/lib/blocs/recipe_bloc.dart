import 'package:dishcover_client/blocs/recipe_event.dart';
import 'package:dishcover_client/blocs/recipe_state.dart';
import 'package:dishcover_client/repositories/recipe_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeBloc({
    required this.recipeRepository,
  }) : super(InitialRecipeState()) {
    on<GetRecipesEvent>((event, emit) async {
      try {
        emit(RecipeLoadingState());

        final res =
            await recipeRepository.getRecipes(fileBytes: event.fileBytes);

        emit(GetRecipesDoneState(typesenseResponse: res));
      } catch (e) {
        emit(GetRecipesErrorState());
      }
    });
  }

  final RecipeRepository recipeRepository;
}

import 'package:dishcover_client/blocs/recipe_bloc.dart';
import 'package:dishcover_client/repositories/recipe_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProviders extends StatelessWidget {
  const BlocProviders({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RecipeBloc>(
          create: (context) => RecipeBloc(
            recipeRepository: RepositoryProvider.of<RecipeRepository>(context),
          ),
        ),
      ],
      child: child,
    );
  }
}

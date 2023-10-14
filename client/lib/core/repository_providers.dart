import 'package:dishcover_client/repositories/recipe_repository.dart';
import 'package:dishcover_client/services/api.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RepositoryProviders extends StatelessWidget {
  const RepositoryProviders({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final api = Api();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => RecipeRepository(api: api)),
      ],
      child: child,
    );
  }
}

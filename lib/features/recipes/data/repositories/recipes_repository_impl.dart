import 'package:dartz/dartz.dart';
import 'package:my_recipes_app/core/errors/failure.dart';
import 'package:my_recipes_app/features/recipes/data/data_sources/recipes_local_data_source.dart';
import 'package:my_recipes_app/features/recipes/domain/entities/ingredient_entity.dart';
import 'package:my_recipes_app/features/recipes/domain/entities/recipe_entity.dart';
import 'package:my_recipes_app/features/recipes/domain/entities/step_entity.dart';
import 'package:my_recipes_app/features/recipes/domain/repositories/recipes_repository.dart';

class RecipesRepositoryImpl implements RecipesRepository {
  final RecipesLocalDataSource recipesLocalDataSource;

  RecipesRepositoryImpl({required this.recipesLocalDataSource});

  @override
  Future<Either<Failure, void>> createRecipe(
      RecipeEntity recipe,
      List<IngredientEntity> ingredientsList,
      List<StepEntity> stepsList) async {
    try {
      await recipesLocalDataSource.createRecipe(
          recipe, ingredientsList, stepsList);
      return const Right(null);
    } on LocalFailure catch (e) {
      return Left(LocalFailure(e.message ?? 'An unknown error occurred'));
    }
  }
}

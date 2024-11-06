import 'package:dartz/dartz.dart';
import 'package:my_recipes_app/core/errors/failure.dart';
import 'package:my_recipes_app/features/recipes/domain/entities/ingredient_entity.dart';
import 'package:my_recipes_app/features/recipes/domain/entities/recipe_entity.dart';
import 'package:my_recipes_app/features/recipes/domain/entities/step_entity.dart';

abstract class RecipesRepository {
  Future<Either<Failure, void>> createRecipe(RecipeEntity recipe,
      List<IngredientEntity> ingredientsList, List<StepEntity> stepsList);
}

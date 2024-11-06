import 'package:dartz/dartz.dart';
import 'package:my_recipes_app/core/errors/failure.dart';
import 'package:my_recipes_app/features/recipes/domain/entities/ingredient_entity.dart';
import 'package:my_recipes_app/features/recipes/domain/entities/recipe_entity.dart';
import 'package:my_recipes_app/features/recipes/domain/entities/step_entity.dart';
import 'package:my_recipes_app/features/recipes/domain/repositories/recipes_repository.dart';

class CreateRecipeUseCase {
  final RecipesRepository repository;

  CreateRecipeUseCase({required this.repository});

  Future<Either<Failure, void>> call(RecipeEntity recipe,
      List<IngredientEntity> ingredientsList, List<StepEntity> stepsList) {
    return repository.createRecipe(recipe, ingredientsList, stepsList);
  }
}

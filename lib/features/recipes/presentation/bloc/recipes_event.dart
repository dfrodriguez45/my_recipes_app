part of 'recipes_bloc.dart';

abstract class RecipesEvent {}

class AddRecipe extends RecipesEvent {
  final RecipeEntity recipe;
  final List<IngredientEntity> ingredientsList;
  final List<StepEntity> stepsList;

  AddRecipe(
      {required this.recipe,
      required this.ingredientsList,
      required this.stepsList});
}

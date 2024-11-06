import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_recipes_app/features/recipes/domain/entities/ingredient_entity.dart';
import 'package:my_recipes_app/features/recipes/domain/entities/recipe_entity.dart';
import 'package:my_recipes_app/features/recipes/domain/entities/step_entity.dart';
import 'package:my_recipes_app/features/recipes/domain/use_cases/create_recipe_use_case.dart';

part 'recipes_event.dart';
part 'recipes_state.dart';

class RecipesBloc extends Bloc<RecipesEvent, RecipesState> {
  final CreateRecipeUseCase _createRecipeUseCase;

  RecipesBloc(this._createRecipeUseCase) : super(RecipesInitial()) {
    on<AddRecipe>((event, emit) async {
      final result = await _createRecipeUseCase(
          event.recipe, event.ingredientsList, event.stepsList);
      result.fold(
          (failure) => debugPrint('failure: ${failure.message}'), (r) => r);
    });
  }
}

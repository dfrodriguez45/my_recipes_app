import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_recipes_app/features/recipes/domain/entities/recipe_entity.dart';
import 'package:my_recipes_app/features/recipes/presentation/bloc/recipes_bloc.dart';
import 'package:my_recipes_app/features/recipes/presentation/widgets/recipe_form.dart';

class CreateRecipeScreen extends StatelessWidget {
  CreateRecipeScreen({super.key});

  final GlobalKey<RecipeFormState> _recipeFormKey =
      GlobalKey<RecipeFormState>();

  @override
  Widget build(BuildContext context) {
    void submitForm() {
      if (_recipeFormKey.currentState?.validateForm() == true) {
        context.read<RecipesBloc>().add(AddRecipe(
              recipe: RecipeEntity(
                id: _recipeFormKey.currentState?.recipeId ?? '',
                name: _recipeFormKey.currentState?.nameRecipeController.text ??
                    '',
                imagePath:
                    _recipeFormKey.currentState?.imagePathController.text ?? '',
                totalTime: _recipeFormKey.currentState?.getTotalTime() ?? 0,
              ),
              ingredientsList:
                  _recipeFormKey.currentState?.getIngredients() ?? [],
              stepsList: _recipeFormKey.currentState?.getSteps() ?? [],
            ));
        return;
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Nueva receta'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: const Icon(Icons.save),
                onPressed: submitForm,
              ),
            ),
          ],
        ),
        body: RecipeForm(
          key: _recipeFormKey,
        ));
  }
}

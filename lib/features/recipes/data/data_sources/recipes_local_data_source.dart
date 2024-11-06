import 'package:flutter/material.dart';
import 'package:my_recipes_app/core/database/app_database.dart';
import 'package:my_recipes_app/core/errors/failure.dart';
import 'package:my_recipes_app/features/recipes/data/models/ingredient_model.dart';
import 'package:my_recipes_app/features/recipes/data/models/recipe_model.dart';
import 'package:my_recipes_app/features/recipes/data/models/step_model.dart';
import 'package:my_recipes_app/features/recipes/domain/entities/ingredient_entity.dart';
import 'package:my_recipes_app/features/recipes/domain/entities/recipe_entity.dart';
import 'package:my_recipes_app/features/recipes/domain/entities/step_entity.dart';

abstract class RecipesLocalDataSource {
  Future<void> createRecipe(RecipeEntity recipe,
      List<IngredientEntity> ingredientsList, List<StepEntity> stepsList);
}

class SQLiteRecipesLocalDataSource implements RecipesLocalDataSource {
  final AppDatabase _database;

  SQLiteRecipesLocalDataSource(this._database);

  @override
  Future<void> createRecipe(
      RecipeEntity recipe,
      List<IngredientEntity> ingredientsList,
      List<StepEntity> stepsList) async {
    try {
      final db = await _database.database;
      await db.insert('Recipe', RecipeModel.fromEntity(recipe).toMap());
      for (IngredientEntity ingredient in ingredientsList) {
        await db.insert(
            'Ingredient', IngredientModel.fromEntity(ingredient).toMap());
      }
      for (StepEntity step in stepsList) {
        await db.insert('Step', StepModel.fromEntity(step).toMap());
      }
    } catch (e) {
      debugPrint(e.toString());
      throw LocalFailure("Error to create recipe: ${e.toString()}");
    }
  }
}

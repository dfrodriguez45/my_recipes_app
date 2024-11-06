import 'package:my_recipes_app/features/recipes/domain/entities/recipe_entity.dart';

class RecipeModel extends RecipeEntity {
  RecipeModel({
    required super.id,
    required super.name,
    required super.imagePath,
    required super.totalTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imagePath': imagePath,
      'totalTime': totalTime,
    };
  }

  factory RecipeModel.fromMap(map) {
    return RecipeModel(
      id: map['id'],
      name: map['name'],
      imagePath: map['imagePath'],
      totalTime: map['totalTime'],
    );
  }

  factory RecipeModel.fromEntity(RecipeEntity recipe) {
    return RecipeModel(
      id: recipe.id,
      name: recipe.name,
      imagePath: recipe.imagePath,
      totalTime: recipe.totalTime,
    );
  }
}

import 'package:my_recipes_app/features/recipes/domain/entities/ingredient_entity.dart';

class IngredientModel extends IngredientEntity {
  IngredientModel({
    required super.id,
    required super.recipeId,
    required super.name,
    required super.quantity,
    required super.unit,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'recipeId': recipeId,
      'name': name,
      'quantity': quantity,
      'unit': unit,
    };
  }

  factory IngredientModel.fromMap(map) {
    return IngredientModel(
      id: map['id'],
      recipeId: map['recipeId'],
      name: map['name'],
      quantity: map['quantity'],
      unit: map['unit'],
    );
  }

  factory IngredientModel.fromEntity(IngredientEntity ingredient) {
    return IngredientModel(
      id: ingredient.id,
      recipeId: ingredient.recipeId,
      name: ingredient.name,
      quantity: ingredient.quantity,
      unit: ingredient.unit,
    );
  }
}

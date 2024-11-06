import 'package:my_recipes_app/features/recipes/domain/entities/step_entity.dart';

class StepModel extends StepEntity {
  StepModel({
    required super.id,
    required super.recipeId,
    required super.order,
    required super.description,
    required super.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'recipeId': recipeId,
      'order': order,
      'description': description,
      'time': time,
    };
  }

  factory StepModel.fromMap(map) {
    return StepModel(
      id: map['id'],
      recipeId: map['recipeId'],
      order: map['order'],
      description: map['description'],
      time: map['time'],
    );
  }

  factory StepModel.fromEntity(StepEntity step) {
    return StepModel(
      id: step.id,
      recipeId: step.recipeId,
      order: step.order,
      description: step.description,
      time: step.time,
    );
  }
}

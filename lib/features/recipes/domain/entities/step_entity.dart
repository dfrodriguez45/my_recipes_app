class StepEntity {
  final String id;
  final String recipeId;
  final int order;
  final String description;
  final int time;

  StepEntity(
      {required this.id,
      required this.recipeId,
      required this.order,
      required this.description,
      required this.time});
}

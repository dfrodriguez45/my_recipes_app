class IngredientEntity {
  final String id;
  final String recipeId;
  final String name;
  final double quantity;
  final String unit;

  IngredientEntity(
      {required this.id,
      required this.recipeId,
      required this.name,
      required this.quantity,
      required this.unit});
}

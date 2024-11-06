class RecipeEntity {
  final String id;
  final String name;
  final String? imagePath;
  final int totalTime;

  RecipeEntity(
      {required this.id,
      required this.name,
      required this.imagePath,
      required this.totalTime});
}

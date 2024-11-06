import 'package:flutter/material.dart';
import 'package:my_recipes_app/core/database/app_database.dart';
import 'package:my_recipes_app/features/recipes/data/data_sources/recipes_local_data_source.dart';
import 'package:my_recipes_app/features/recipes/data/repositories/recipes_repository_impl.dart';
import 'package:my_recipes_app/features/recipes/domain/repositories/recipes_repository.dart';
import 'package:my_recipes_app/features/recipes/domain/use_cases/create_recipe_use_case.dart';
import 'package:my_recipes_app/features/recipes/presentation/bloc/recipes_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initDI() async {
  debugPrint("Initializing dependencies...");
  // Bloc
  sl.registerFactory(
    () => RecipesBloc(sl()),
  );
  debugPrint("Bloc registered");

  // Use cases
  sl.registerLazySingleton(() => CreateRecipeUseCase(repository: sl()));
  debugPrint("Use cases registered");

  // Repositories
  sl.registerLazySingleton<RecipesRepository>(
      () => RecipesRepositoryImpl(recipesLocalDataSource: sl()));
  debugPrint("Repositories registered");

  // Data sources
  sl.registerLazySingleton<RecipesLocalDataSource>(
      () => SQLiteRecipesLocalDataSource(sl()));
  debugPrint("Data sources registered");

  // Database
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());
  debugPrint("Database registered");
}

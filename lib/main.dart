import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:my_recipes_app/core/di/di.dart';
import 'package:my_recipes_app/features/recipes/presentation/bloc/recipes_bloc.dart';
import 'package:my_recipes_app/features/recipes/presentation/screens/create_recipe_screen.dart';

void main() async {
  await initDI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GetIt.instance.get<RecipesBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'My Recipes App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: CreateRecipeScreen(),
      ),
    );
  }
}

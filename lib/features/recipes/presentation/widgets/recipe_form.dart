import 'package:flutter/material.dart';
import 'package:my_recipes_app/features/recipes/domain/entities/ingredient_entity.dart';
import 'package:my_recipes_app/features/recipes/domain/entities/recipe_entity.dart';
import 'package:my_recipes_app/features/recipes/domain/entities/step_entity.dart';
import 'package:my_recipes_app/features/recipes/presentation/widgets/image_picker_field.dart';
import 'package:my_recipes_app/features/recipes/presentation/widgets/ingredient_field.dart';
import 'package:my_recipes_app/features/recipes/presentation/widgets/step_card_field.dart';
import 'package:uuid/uuid.dart';

class RecipeForm extends StatefulWidget {
  final RecipeEntity? recipe;
  final List<IngredientEntity>? ingredientsList;
  final List<StepEntity>? stepsList;
  const RecipeForm(
      {super.key, this.recipe, this.ingredientsList, this.stepsList});

  @override
  State<RecipeForm> createState() => RecipeFormState();
}

class RecipeFormState extends State<RecipeForm> {
  final _formKey = GlobalKey<FormState>();

  // Id
  final String recipeId = const Uuid().v4();

  // Fields
  late TextEditingController nameRecipeController;
  late TextEditingController imagePathController;

  // Ingredients
  final List<TextEditingController> _ingredientControllers = [];
  final List<TextEditingController> _quantityControllers = [];
  final List<TextEditingController> _unitControllers = [];

  // Steps
  final List<TextEditingController> _descriptionControllers = [];
  final List<TextEditingController> _timeControllers = [];

  void _onImageSelected(String path) {
    imagePathController.text = path;
  }

  void _addIngredientInput(IngredientEntity? ingredient) {
    setState(() {
      _ingredientControllers
          .add(TextEditingController(text: ingredient?.name ?? ''));
      _quantityControllers.add(
          TextEditingController(text: ingredient?.quantity.toString() ?? ''));
      _unitControllers.add(TextEditingController(text: ingredient?.unit ?? ''));
    });
  }

  void _removeIngredientInput(int index) {
    setState(() {
      _ingredientControllers.removeAt(index);
      _quantityControllers.removeAt(index);
      _unitControllers.removeAt(index);
    });
  }

  void _addStepInput(StepEntity? step) {
    setState(() {
      _descriptionControllers
          .add(TextEditingController(text: step?.description ?? ''));
      _timeControllers
          .add(TextEditingController(text: step?.time.toString() ?? ''));
    });
  }

  void _removeStepInput(int index) {
    setState(() {
      _descriptionControllers.removeAt(index);
      _timeControllers.removeAt(index);
    });
  }

  List<IngredientEntity> getIngredients() {
    List<IngredientEntity> ingredients = [];

    for (int i = 0; i < _ingredientControllers.length; i++) {
      String ingredientName = _ingredientControllers[i].text;
      String quantity = _quantityControllers[i].text;
      String unit = _unitControllers[i].text;
      String id = const Uuid().v4();

      ingredients.add(
        IngredientEntity(
          id: id,
          recipeId: recipeId,
          name: ingredientName,
          quantity: double.parse(quantity),
          unit: unit,
        ),
      );
    }

    return ingredients;
  }

  List<StepEntity> getSteps() {
    List<StepEntity> steps = [];

    for (int i = 0; i < _descriptionControllers.length; i++) {
      String description = _descriptionControllers[i].text;
      String time = _timeControllers[i].text;
      String id = const Uuid().v4();

      steps.add(
        StepEntity(
          id: id,
          recipeId: recipeId,
          order: i,
          description: description,
          time: int.parse(time),
        ),
      );
    }

    return steps;
  }

  int getTotalTime() {
    int totalTime = 0;

    for (var controller in _timeControllers) {
      int time = int.tryParse(controller.text) ?? 0;
      totalTime += time;
    }

    return totalTime;
  }

  bool validateForm() {
    if (_formKey.currentState?.validate() != true) {
      return false;
    }

    if (_ingredientControllers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Debe agregar al menos un ingrediente.")),
      );
      return false;
    }

    if (_descriptionControllers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Debe agregar al menos un paso.")),
      );
      return false;
    }

    return true;
  }

  @override
  void initState() {
    super.initState();
    nameRecipeController =
        TextEditingController(text: widget.recipe?.name ?? '');
    imagePathController =
        TextEditingController(text: widget.recipe?.imagePath ?? '');

    for (IngredientEntity ingredient in widget.ingredientsList ?? []) {
      _addIngredientInput(ingredient);
    }

    for (StepEntity step in widget.stepsList ?? []) {
      _addStepInput(step);
    }
  }

  @override
  void dispose() {
    for (var controller in _ingredientControllers) {
      controller.dispose();
    }
    for (var controller in _quantityControllers) {
      controller.dispose();
    }
    for (var controller in _unitControllers) {
      controller.dispose();
    }
    nameRecipeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameRecipeController,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Arroz con pollo, Pan, etc...',
                  labelText: 'Nombre de la receta'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El nombre no puede estar vacío.';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 8,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Lista de ingredientes',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    _ingredientControllers.isEmpty
                        ? const Center(
                            child: Text('No hay ingredientes añadidos.'),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _ingredientControllers.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: IngredientInput(
                                  ingredientController:
                                      _ingredientControllers[index],
                                  quantityController:
                                      _quantityControllers[index],
                                  unitController: _unitControllers[index],
                                  labelIngredient: 'Ingrediente #${index + 1}',
                                  onRemove: () => _removeIngredientInput(index),
                                ),
                              );
                            },
                          ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _addIngredientInput(null),
                            style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    Theme.of(context)
                                        .buttonTheme
                                        .colorScheme
                                        ?.primary)),
                            child: Text(
                              'Agregar ingrediente',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Lista de pasos',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 8,
            ),
            _descriptionControllers.isEmpty
                ? const Center(
                    child: Text('No hay pasos añadidos.'),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _descriptionControllers.length,
                    itemBuilder: (BuildContext context, int index) {
                      return StepCardField(
                          descriptionController: _descriptionControllers[index],
                          timeController: _timeControllers[index],
                          labelStep: 'Paso #${index + 1}',
                          onRemove: () => _removeStepInput(index));
                    }),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _addStepInput(null),
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context)
                                .buttonTheme
                                .colorScheme
                                ?.primary)),
                    child: Text(
                      'Agregar paso',
                      style: Theme.of(context).primaryTextTheme.titleMedium,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            ImagePickerField(
              onImageSelected: _onImageSelected,
              initialImagePath: imagePathController.text,
            )
          ],
        ),
      )),
    );
  }
}

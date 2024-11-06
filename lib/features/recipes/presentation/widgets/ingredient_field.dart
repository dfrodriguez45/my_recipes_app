import 'package:flutter/material.dart';

class IngredientInput extends StatelessWidget {
  final TextEditingController ingredientController;
  final TextEditingController quantityController;
  final TextEditingController unitController;
  final String labelIngredient;
  final VoidCallback onRemove;

  IngredientInput({
    super.key,
    required this.ingredientController,
    required this.quantityController,
    required this.unitController,
    required this.labelIngredient,
    required this.onRemove,
  }) {
    quantityController.text =
        quantityController.text.isEmpty ? "0" : quantityController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: TextFormField(
            controller: ingredientController,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: 'Arroz...',
              labelText: labelIngredient,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'El ingrediente no puede estar vacío.';
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 1,
          child: TextFormField(
            controller: quantityController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: '1/2...',
              labelText: 'Cantidad',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'La cantidad no puede estar vacía.';
              }
              if (double.tryParse(value) == null || double.parse(value) <= 0) {
                return 'Ingrese una cantidad válida.';
              }
              return null;
            },
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 1,
          child: TextFormField(
            controller: unitController,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'kg...',
              labelText: 'Unidad',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'La unidad no puede estar vacía.';
              } else if (value.length > 10) {
                return 'Unidad demasiado larga';
              }
              return null;
            },
            keyboardType: TextInputType.text,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.remove_circle, color: Colors.red),
          onPressed: onRemove,
        ),
      ],
    );
  }
}

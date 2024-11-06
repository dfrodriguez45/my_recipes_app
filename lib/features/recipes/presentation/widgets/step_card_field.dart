import 'package:flutter/material.dart';

class StepCardField extends StatelessWidget {
  final TextEditingController descriptionController;
  final TextEditingController timeController;
  final String labelStep;
  final VoidCallback onRemove;

  StepCardField({
    super.key,
    required this.descriptionController,
    required this.timeController,
    required this.labelStep,
    required this.onRemove,
  }) {
    timeController.text =
        timeController.text.isEmpty ? "0" : timeController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  labelStep,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onRemove,
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: descriptionController,
              textCapitalization: TextCapitalization.sentences,
              minLines: 1,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Se agregan dos...',
                labelText: 'Descripción',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'La descripción no puede estar vacía.';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: timeController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '20...',
                labelText: 'Tiempo en minutos',
                suffix: Text('Minutos'),
                suffixIcon: Icon(Icons.access_time),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El tiempo no puede estar vacío.';
                }
                if (double.tryParse(value) == null ||
                    double.parse(value) <= 0) {
                  return 'Ingrese un tiempo válida.';
                }
                return null;
              },
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
          ],
        ),
      ),
    );
  }
}

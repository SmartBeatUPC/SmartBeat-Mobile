import 'package:flutter/material.dart';

class StackedBarChart extends StatelessWidget {
  final int numberOfBars;
  final List<int> progressValues;
  final List<String> clasificationValues;
  final List<String> dates;

  StackedBarChart({
    this.numberOfBars = 8,
    required this.progressValues,
    required this.clasificationValues,
    required this.dates,
  });

  Color detectColorByClassification(String clasification) {
    if (clasification == 'Óptimo' || clasification == 'Normal') {
      return Colors.lightGreen;
    }
    if (clasification == 'Pre-Hipertension' ||
        clasification == 'Hipertension I') {
      return Colors.yellow;
    }
    if (clasification == 'Hipertension II' ||
        clasification == 'Hipertension III' ||
        clasification == 'Hipertension Sistolica Aislada') {
      return Colors.red;
    }
    return Colors.redAccent;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(numberOfBars, (index) {
          //TODO No se deben enviar valores negativos
          int progress = progressValues[index];
          String classification = clasificationValues[index];
          if (progress < 0) {
            progress = 0;
          }
          final date = dates[index];

          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Container(
                    width: 17.5,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    width: 17.5,
                    height: (progress / 100) * 100,
                    decoration: BoxDecoration(
                      color: detectColorByClassification(classification),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              Transform.rotate(
                angle: -0.55,
                child: Text(
                  date,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

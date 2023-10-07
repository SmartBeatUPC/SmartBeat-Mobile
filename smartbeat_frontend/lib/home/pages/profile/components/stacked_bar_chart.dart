import 'package:flutter/material.dart';

class StackedBarChart extends StatelessWidget {
  final int numberOfBars;
  final List<int> progressValues;
  final List<String> dates;

  StackedBarChart({
    this.numberOfBars = 8,
    required this.progressValues,
    required this.dates,
  });

  Color detectColorByProgressValue(int progressValue) {
    if (progressValue < 50) {
      return Colors.lightGreen;
    } else if (progressValue < 80) {
      return Colors.orange;
    } else if (progressValue < 100) {
      return Colors.red;
    }
    return Colors.lightGreen;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(numberOfBars, (index) {
        final progress = progressValues[index];
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
                    color: detectColorByProgressValue(progress),
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
    );
  }
}

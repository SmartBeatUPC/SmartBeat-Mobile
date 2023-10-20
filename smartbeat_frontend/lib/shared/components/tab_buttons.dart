import 'package:flutter/material.dart';
import 'package:smartbeat_frontend/shared/components/custom_shadow_container.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';

class TabButtons extends StatefulWidget {
  final List<String> options;
  final void Function(int selectedIndex) onOptionSelected;
  final int selectedIndex;

  const TabButtons({
    Key? key,
    required this.options,
    required this.onOptionSelected,
    this.selectedIndex = 0,
  }) : super(key: key);

  @override
  State<TabButtons> createState() => _TabButtonsState();
}

class _TabButtonsState extends State<TabButtons> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: widget.options.asMap().entries.map((entry) {
        final index = entry.key;
        final option = entry.value;

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
            widget.onOptionSelected(index);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 2.5),
            child: CustomShadowContainer(
              borderRadius: BorderRadius.circular(10.0),
              color:
                  index == selectedIndex ? AppColors.secondary : Colors.white,
              border: Border.all(
                  color: index == selectedIndex
                      ? Colors.transparent
                      : AppColors.secondary,
                  width: 1.5),
              padding:
                  const EdgeInsets.symmetric(horizontal: 7.5, vertical: 2.5),
              child: Text(
                option,
                style: textTheme.titleMedium?.copyWith(
                  color: index == selectedIndex
                      ? Colors.white
                      : AppColors.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

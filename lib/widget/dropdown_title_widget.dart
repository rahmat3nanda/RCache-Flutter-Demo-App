import 'package:flutter/material.dart';

class DropdownTitleWidget<T> extends StatelessWidget {
  final T? selected;
  final String title;
  final String hint;
  final List<T> sources;
  final String Function(T) label;
  final Function(T?) onChanged;
  final Widget? suffix;

  const DropdownTitleWidget({
    super.key,
    required this.selected,
    required this.title,
    required this.hint,
    required this.sources,
    required this.label,
    required this.onChanged,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title),
        Expanded(child: Container()),
        DropdownButton<T>(
          value: selected,
          hint: Text(hint),
          onChanged: onChanged,
          items: sources.map<DropdownMenuItem<T>>((T value) {
            return DropdownMenuItem(
              value: value,
              child: Text(label(value)),
            );
          }).toList(),
        ),
        if (suffix != null) suffix!,
      ],
    );
  }
}

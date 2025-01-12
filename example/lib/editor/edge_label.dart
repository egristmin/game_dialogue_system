import 'package:flutter/material.dart';

class EditorEdgeLabel extends StatelessWidget {
  const EditorEdgeLabel({required this.condition, super.key});

  final String condition;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Text(
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(backgroundColor: Theme.of(context).colorScheme.surface),
          condition),
    );
  }
}

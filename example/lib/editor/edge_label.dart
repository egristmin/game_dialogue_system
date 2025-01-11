import 'package:flutter/material.dart';
import 'package:graphite/graphite.dart';

import 'dialogue_editor_node.dart';

class EditorEdgeLabel extends StatelessWidget {
  const EditorEdgeLabel(
      {required this.edge, required this.isVertical, super.key});

  final Edge edge;
  final bool isVertical;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: isVertical
          ? RotatedBox(
          quarterTurns: -1,
          child: Text(
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .surface),
              "${(edge.to as DialogueEditorNode)}"))
          : Text(
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(
              backgroundColor: Theme.of(context)
                  .colorScheme
                  .surface),
          "${edge.from.id}=>${edge.to.id}"),
    );
  }
}

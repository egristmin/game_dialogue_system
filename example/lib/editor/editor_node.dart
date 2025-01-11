import 'package:example/editor/dialogue_editor_node.dart';
import 'package:flutter/material.dart';
import 'package:graphite/core/typings.dart';

class EditorNode extends StatelessWidget {
  const EditorNode({required this.node, super.key});

  final NodeInput node;

  @override
  Widget build(BuildContext context) {
    if (node is DialogueEditorNode) {}

    return Container(
      width: 100,
      height: 100,
      color: Theme.of(context).secondaryHeaderColor,
    );
  }
}

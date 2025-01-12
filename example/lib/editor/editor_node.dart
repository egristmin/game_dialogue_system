import 'package:example/editor/dialogue_editor_node.dart';
import 'package:flutter/material.dart';

class EditorNode extends StatelessWidget {
  const EditorNode({required this.node, super.key});

  final DialogueEditorNode node;

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: node.type == DialogueNodeType.question
            ? Colors.lightBlue
            : Colors.deepPurple,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(

          color: Colors.grey,
        ),
      ),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Text(node.id)),
      ),
    );
  }
}

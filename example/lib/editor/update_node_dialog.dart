import 'package:example/editor/dialogue_editor_node.dart';
import 'package:flutter/material.dart';
import 'package:graphite/core/typings.dart';

class UpdateNodeDialog extends StatefulWidget {
  const UpdateNodeDialog(
      {this.initialNode, required this.currentNodes, super.key});

  final DialogueEditorNode? initialNode;
  final Map<String, DialogueEditorNode> currentNodes;

  @override
  State<UpdateNodeDialog> createState() => _UpdateNodeDialogState();
}

class _UpdateNodeDialogState extends State<UpdateNodeDialog> {
  bool isQuestion = false;
  final Map<String, TextEditingController> controllers = {
    'content': TextEditingController(),
    'stateCondition': TextEditingController(),
    'eventOrPriority': TextEditingController(),
  };
  final List<DialogueEditorNode> children = [];
  DialogueEditorNode? parentNode;

  void save() {
    Navigator.pop(
        context,
        DialogueEditorNode(
          parentNode: parentNode,
          type:
              isQuestion ? DialogueNodeType.question : DialogueNodeType.answer,
          id: controllers['content']!.value.text,
          next: children.map((node) => EdgeInput(outcome: node.id)).toList(),
          stateCondition: controllers['stateCondition']!.value.text,
          event: controllers['eventOrPriority']!.value.text,
          priority:
              int.tryParse(controllers['eventOrPriority']!.value.text) ?? 0,
        ));
  }

  void addChildNode(DialogueEditorNode? node) {
    if (node == null) return;
    setState(() {
      if (!isQuestion) children.clear();
      children.add(node);
    });
  }

  void setParentNode(DialogueEditorNode? node) {
    setState(() {
      parentNode = node;
    });
  }

  void removeChild(DialogueEditorNode child) {
    setState(() {
      children.removeWhere((e) => e.id == child.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(12),
        child: Scaffold(
          backgroundColor: Theme.of(context).cardColor,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                Row(
                  spacing: 12,
                  children: [
                    Text('Question'),
                    Switch(
                        value: isQuestion,
                        onChanged: (value) => setState(() {
                              isQuestion = value;
                            })),
                    Text('Answer'),
                  ],
                ),
                TextFormField(
                  controller: controllers['content'],
                  decoration: InputDecoration(
                    labelText: 'Content',
                    border: OutlineInputBorder(),
                  ),
                ),
                TextFormField(
                  controller: controllers['stateCondition'],
                  decoration: InputDecoration(
                    labelText: 'State condition',
                    border: OutlineInputBorder(),
                  ),
                ),
                DropdownButton<DialogueEditorNode>(
                    hint: Text('Parent'),
                    items: widget.currentNodes.values
                        .map((node) => DropdownMenuItem<DialogueEditorNode>(
                            value: node, child: (Text(node.id))))
                        .toList(),
                    onChanged: setParentNode),
                DropdownButton<DialogueEditorNode>(
                    hint: Text('Children'),
                    items: widget.currentNodes.values
                        .map(
                          (node) => DropdownMenuItem<DialogueEditorNode>(
                            value: node,
                            child: (Text(node.id)),
                          ),
                        )
                        .toList(),
                    onChanged: addChildNode),
                Wrap(
                  children: children
                      .map((child) => Chip(
                            label: Text(child.id),
                            deleteIcon: Icon(Icons.delete),
                            onDeleted: () {
                              removeChild(child);
                            },
                          ))
                      .toList(),
                ),
                TextFormField(
                  controller: controllers['eventOrPriority'],
                  decoration: InputDecoration(
                    labelText: isQuestion ? 'Priority' : 'Event',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: save,
                child: Text('Save'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, null);
                },
                child: Text('Cancel'),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (final controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
}

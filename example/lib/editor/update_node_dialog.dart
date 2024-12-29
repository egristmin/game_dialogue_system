import 'package:example/editor/dialogue_editor_node.dart';
import 'package:flutter/material.dart';

class UpdateNodeDialog extends StatefulWidget {
  const UpdateNodeDialog({this.initialNode, super.key});

  final DialogueEditorNode? initialNode;

  @override
  State<UpdateNodeDialog> createState() => _UpdateNodeDialogState();
}

class _UpdateNodeDialogState extends State<UpdateNodeDialog> {
  bool isQuestion = false;
  final Map<String, TextEditingController> controllers = {
    'content': TextEditingController(),
    'stateCondition': TextEditingController(),
    'children': TextEditingController(),
    'eventOrPriority': TextEditingController(),
  };

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blueGrey, borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(12),
        child: Scaffold(
          backgroundColor: Colors.blueGrey,
          body: SingleChildScrollView(
            child: Column(
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
                  decoration: InputDecoration(labelText: 'Content'),
                ),
                TextFormField(
                  controller: controllers['stateCondition'],
                  decoration: InputDecoration(labelText: 'State condition'),
                ),
                TextFormField(
                  controller: controllers['children'],
                  decoration: InputDecoration(labelText: 'Children'),
                ),
                TextFormField(
                  controller: controllers['eventOrPriority'],
                  decoration: InputDecoration(
                      labelText: isQuestion ? 'Priority' : 'Event'),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, null);
                },
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
//Answer
// finishDialogue

// Question

// isIntro

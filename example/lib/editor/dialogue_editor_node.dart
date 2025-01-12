import 'package:graphite/graphite.dart';

class DialogueEditorNode extends NodeInput {
  DialogueEditorNode(
      {this.parentNode,
      required this.type,
      required this.stateCondition,
      required this.event,
      required this.priority,
      required super.id,
      required super.next});

  final DialogueEditorNode? parentNode;
  final DialogueNodeType type;
  final int priority;
  final String? stateCondition;
  final String? event;
}

enum DialogueNodeType { answer, question }

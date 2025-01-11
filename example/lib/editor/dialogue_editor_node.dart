import 'package:game_dialogue_system/game_dialogue_system.dart';
import 'package:graphite/graphite.dart';

class DialogueEditorNode extends NodeInput {
  DialogueEditorNode(
      {this.parentNode,
      required this.type,
      this.answer,
      this.question,
      required super.id,
      required super.next});

  final DialogueEditorNode? parentNode;
  final Answer? answer;
  final Question? question;
  final DialogueNodeType type;
}

enum DialogueNodeType { answer, question }

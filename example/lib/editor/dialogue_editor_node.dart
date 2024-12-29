import 'package:game_dialogue_system/game_dialogue_system.dart';
import 'package:graphite/graphite.dart';

class DialogueEditorNode extends NodeInput {
  DialogueEditorNode(
      {this.answer, this.question, required super.id, required super.next});

  Answer? answer;
  Question? question;
}


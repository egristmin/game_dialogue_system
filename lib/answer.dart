import 'package:game_dialogue_system/dialogue.dart';

import 'typedef.dart';

class Answer {
  const Answer({
    required this.dialogue,
    required this.id,
    required this.content,
    this.stateCondition,
    this.event,
    this.finishDialogue = false,
  });

  final AnswerId id;
  final String? stateCondition;
  final String content;
  final Dialogue dialogue;
  final String? event;
  final bool finishDialogue;
  bool get hasStateCondition => stateCondition != null;


  void choice() => dialogue.onAnswerChoice(this);
}

import 'package:game_dialogue_system/dialogue.dart';

import 'typedef.dart';

class Answer {
  const Answer({
    required this.dialogue,
    required this.id,
    required this.content,
    this.stateCondition,
    this.event,
  });

  final AnswerId id;
  final String? stateCondition;
  final String content;
  final Dialogue dialogue;
  final String? event;

  void choice() {}
}

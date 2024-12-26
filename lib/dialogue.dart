import 'package:game_dialogue_system/game_dialogue_system.dart';

class Dialogue {
  Dialogue({this.triggerEvent});

  late Question currentQuestion;

  final void Function(String)? triggerEvent;

  void onAnswerChoice(Answer answer) {
    if (triggerEvent != null && answer.event != null) {
      triggerEvent!(answer.event!);
    }
    if (!answer.finishDialogue) {
      currentQuestion.getNextQuestionId(answer.id);
    }
  }
}

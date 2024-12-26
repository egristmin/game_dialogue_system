import 'package:game_dialogue_system/game_dialogue_system.dart';

class DialogueConfig {
  final List<Answer> answers;
  final List<Question> questions;

  const DialogueConfig({this.questions = const [], this.answers = const []});
}

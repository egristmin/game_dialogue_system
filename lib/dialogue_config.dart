import 'package:game_dialogue_system/game_dialogue_system.dart';

class DialogueConfig {
  final List<Answer> answers;
  final List<Question> questions;

  const DialogueConfig({this.questions = const [], this.answers = const []});

  DialogueConfig.fromJson(Map<String, dynamic> json)
      : answers = ((json['answers'] ?? []) as List<Map<String, dynamic>>)
            .map((Answer.fromJson))
            .toList(),
        questions = ((json['questions'] ?? []) as List<Map<String, dynamic>>)
            .map((Question.fromJson))
            .toList();

  Map<String, dynamic> toJson() => {
        'answers': answers.map((answer) => answer.toJson()).toList(),
        'questions': questions.map((question) => question.toJson()).toList(),
      };
}

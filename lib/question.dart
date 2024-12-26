import 'typedef.dart';

class Question {
  const Question({
    required this.id,
    required this.content,
    this.priority = 0,
    this.stateCondition,
    required this.children,
  });

  final QuestionId id;
  final String content;
  final int priority;
  final String? stateCondition;
  final Map<AnswerId, QuestionId> children;

  bool get hasStateCondition => stateCondition != null;

  QuestionId getNextQuestionId(AnswerId answerId) {
    if (!children.containsKey(answerId)) throw 'Next question not found';
    return children[answerId]!;
  }
}

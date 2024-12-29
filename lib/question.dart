import 'typedef.dart';

class Question {
  const Question({
    required this.id,
    this.isIntro = false,
    required this.content,
    this.priority = 0,
    this.stateCondition,
    required this.children,
  });

  Question.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        isIntro = (json['isIntro'] as bool?) ?? false,
        content = json['content'] as String,
        priority = json['priority'] as int,
        stateCondition = json['stateCondition'] as String?,
        children = json['children'] as Map<int, int>;

  final QuestionId id;
  final bool isIntro;
  final String content;
  final int priority;
  final String? stateCondition;
  final Map<AnswerId, QuestionId> children;

  bool get hasStateCondition => stateCondition != null;

  QuestionId getNextQuestionId(AnswerId answerId) {
    if (!children.containsKey(answerId)) {
      throw 'Next question not found. Answer id: $answerId';
    }
    return children[answerId]!;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'isIntro': isIntro,
        'content': content,
        'priority': priority,
        if (stateCondition != null) 'stateCondition': stateCondition,
        'children': children,
      };
}

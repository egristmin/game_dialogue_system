import 'package:json_annotation/json_annotation.dart';

import 'typedef.dart';

part 'question.g.dart';

@JsonSerializable()
class Question {
  const Question({
    required this.id,
    this.isIntro = false,
    required this.content,
    this.priority = 0,
    this.stateCondition,
    required this.children,
  });

  final QuestionId id;
  final bool isIntro;
  final String content;
  final int priority;
  final String? stateCondition;
  final Map<QuestionId, QuestionId> children;

  bool get hasStateCondition => stateCondition != null && stateCondition!.isNotEmpty;

  QuestionId getNextQuestionId(QuestionId QuestionId) {
    if (!children.containsKey(QuestionId)) {
      throw 'Next question not found. Question id: $QuestionId';
    }
    return children[QuestionId]!;
  }

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);

  Question copyWith({
    QuestionId? id,
    bool? isIntro,
    String? content,
    int? priority,
    String? stateCondition,
    Map<QuestionId, QuestionId>? children,
  }) {
    return Question(
      id: id ?? this.id,
      isIntro: isIntro ?? this.isIntro,
      content: content ?? this.content,
      priority: priority ?? this.priority,
      stateCondition: stateCondition ?? this.stateCondition,
      children: children ?? this.children,
    );
  }
}

import 'package:json_annotation/json_annotation.dart';

import 'typedef.dart';

part 'answer.g.dart';

@JsonSerializable()
class Answer {
  const Answer({
    required this.id,
    required this.content,
    this.stateCondition,
    this.event,
    this.finishDialogue = false,
  });

  final AnswerId id;
  final String? stateCondition;
  final String content;
  final String? event;
  final bool finishDialogue;

  bool get hasStateCondition => stateCondition != null && stateCondition!.isNotEmpty;

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerToJson(this);
}

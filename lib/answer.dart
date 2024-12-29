import 'typedef.dart';

class Answer {
  const Answer({
    required this.id,
    required this.content,
    this.stateCondition,
    this.event,
    this.finishDialogue = false,
  });

  Answer.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        stateCondition = json['stateCondition'] as String?,
        content = json['content'] as String,
        event = json['event'] as String?,
        finishDialogue = (json['finishDialogue'] as bool?) ?? false;

  final AnswerId id;
  final String? stateCondition;
  final String content;
  final String? event;
  final bool finishDialogue;

  bool get hasStateCondition => stateCondition != null;

  Map<String, dynamic> toJson() => {
        'id': id,
        if (stateCondition != null) 'stateCondition': stateCondition,
        'content': content,
        if (event != null) 'event': event,
        'finishDialogue': finishDialogue,
      };
}

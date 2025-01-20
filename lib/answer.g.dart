// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Answer _$AnswerFromJson(Map<String, dynamic> json) => Answer(
      id: (json['id'] as num).toInt(),
      content: json['content'] as String,
      stateCondition: json['stateCondition'] as String?,
      event: json['event'] as String?,
      finishDialogue: json['finishDialogue'] as bool? ?? false,
    );

Map<String, dynamic> _$AnswerToJson(Answer instance) => <String, dynamic>{
      'id': instance.id,
      'stateCondition': instance.stateCondition,
      'content': instance.content,
      'event': instance.event,
      'finishDialogue': instance.finishDialogue,
    };

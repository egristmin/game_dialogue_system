// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dialogue_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DialogueConfig _$DialogueConfigFromJson(Map<String, dynamic> json) =>
    DialogueConfig(
      questions: (json['questions'] as List<dynamic>?)
              ?.map((e) => Question.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      answers: (json['answers'] as List<dynamic>?)
              ?.map((e) => Answer.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$DialogueConfigToJson(DialogueConfig instance) =>
    <String, dynamic>{
      'answers': instance.answers,
      'questions': instance.questions,
    };

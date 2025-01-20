// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      id: (json['id'] as num).toInt(),
      isIntro: json['isIntro'] as bool? ?? false,
      content: json['content'] as String,
      priority: (json['priority'] as num?)?.toInt() ?? 0,
      stateCondition: json['stateCondition'] as String?,
      children: (json['children'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(int.parse(k), (e as num).toInt()),
      ),
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'isIntro': instance.isIntro,
      'content': instance.content,
      'priority': instance.priority,
      'stateCondition': instance.stateCondition,
      'children': instance.children.map((k, e) => MapEntry(k.toString(), e)),
    };

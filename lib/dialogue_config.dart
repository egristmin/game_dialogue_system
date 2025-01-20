import 'package:game_dialogue_system/game_dialogue_system.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dialogue_config.g.dart';

@JsonSerializable()
class DialogueConfig {
  final List<Answer> answers;
  final List<Question> questions;

  const DialogueConfig({this.questions = const [], this.answers = const []});

  factory DialogueConfig.fromJson(Map<String, dynamic> json) =>
      _$DialogueConfigFromJson(json);

  Map<String, dynamic> toJson() => _$DialogueConfigToJson(this);
}

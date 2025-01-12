// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:example/editor/dialogue_editor_node.dart';
import 'package:game_dialogue_system/game_dialogue_system.dart';

class Converter {
  final Map<String, DialogueEditorNode> nodes;

  Converter({required this.nodes});

  int _maxId = 0;
  final List<Answer> _answers = [];
  final List<Question> _childlessQuestions = [];

  DialogueConfig configFromNodes() {
    _answers.addAll(nodes.values
        .where((value) => value.type == DialogueNodeType.answer)
        .map(_answerFromNode)
        .toList());
    _childlessQuestions.addAll(nodes.values
        .where((value) => value.type == DialogueNodeType.question)
        .map(_childlessQuestionFromNode)
        .toList());
    return DialogueConfig(answers: _answers, questions: _questions());
  }

  Answer _answerFromNode(DialogueEditorNode node) {
    _maxId++;
    return Answer(
        id: _maxId,
        content: node.id,
        stateCondition: node.stateCondition,
        event: node.event,
        finishDialogue: node.next.isEmpty);
  }

  Question _childlessQuestionFromNode(DialogueEditorNode node) {
    _maxId++;
    return Question(
        id: _maxId,
        content: node.id,
        children: {},
        priority: node.priority,
        stateCondition: node.stateCondition,
        isIntro: node.parentNode == null);
  }

  List<Question> _questions() => _childlessQuestions
      .map((question) =>
          question.copyWith(children: _defineChildren(question.content)))
      .toList();

  Map<AnswerId, QuestionId> _defineChildren(String questionContent) {
    if (!nodes.containsKey(questionContent)) {
      throw 'Node with id: $questionContent has not been found';
    }
    final Map<AnswerId, QuestionId> children = {};
    final questionNode = nodes[questionContent]!;
    questionNode.next.map((edge) => edge.outcome).forEach((answerId) {
      final answer =
          _answers.firstWhere((answer) => answer.content == answerId);
      final question = _childlessQuestions.firstWhere((question) =>
          question.content == nodes[answer.content]!.parentNode?.id);
      children[answer.id] = question.id;
    });
    return children;
  }
}

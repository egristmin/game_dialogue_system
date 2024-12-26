import 'package:game_dialogue_system/game_dialogue_system.dart';

class Dialogue {
  Dialogue({required this.config, this.onTriggerEvent, this.state}) {
    _init();
  }

  final DialogueConfig config;
  final void Function(String)? onTriggerEvent;
  Map<String, bool>? state;
  final Map<AnswerId, Answer> _answers = {};
  final Map<QuestionId, Question> _questions = {};
  late Question _currentQuestion;
  late List<Answer> _currentPossibleAnswers;

  List<Answer> get currentPossibleAnswers => _currentPossibleAnswers;

  void _init() {
    _fillDialogueMaps();
    _defineIntro();
  }

  void _fillDialogueMaps() {
    _answers.addEntries(
        config.answers.map((answer) => MapEntry(answer.id, answer)));
    _questions.addEntries(
        config.questions.map((question) => MapEntry(question.id, question)));
  }

  void _defineIntro() {
    final introQuestions =
        _questions.values.where((question) => question.isIntro).toList();
    introQuestions.sort((a, b) => a.priority.compareTo(b.priority));
    _currentQuestion = introQuestions.last;
    _updateCurrentAnswers();
  }

  void onAnswerChoice(Answer answer) {
    if (onTriggerEvent != null && answer.event != null) {
      onTriggerEvent!(answer.event!);
    }
    if (!answer.finishDialogue) {
      _updateCurrentQuestion(_currentQuestion.getNextQuestionId(answer.id));
    }
  }

  void updateState(Map<String, bool> newState) => state = newState;

  void _updateCurrentQuestion(QuestionId nextQuestionId) {
    if (!_questions.containsKey(nextQuestionId)) {
      throw 'Next question not found. Question id: $nextQuestionId';
    }
    _currentQuestion = _questions[nextQuestionId]!;
    _updateCurrentAnswers();
  }

  void _updateCurrentAnswers() {
    if (_currentQuestion.children.isEmpty) {
      throw 'Empty question children. Question id: ${_currentQuestion.id}';
    }
    _currentPossibleAnswers = _currentQuestion.children.values.map((answerId) {
      if (!_answers.containsKey(answerId)) {
        throw 'Possible answer not found. Answer id: $answerId';
      }
      return _answers[answerId]!;
    }).toList();
  }
}

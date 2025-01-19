import 'package:game_dialogue_system/game_dialogue_system.dart';

class Dialogue {
  Dialogue(
      {required this.config,
      required this.onUpdateAnswers,
      this.onTriggerEvent,
      this.state}) {
    _init();
  }

  final DialogueConfig config;
  final void Function(String)? onTriggerEvent;
  final void Function(List<Answer>) onUpdateAnswers;
  Map<String, bool>? state;
  final Map<AnswerId, Answer> _answers = {};
  final Map<QuestionId, Question> _questions = {};
  late Question _currentQuestion;
  late List<Answer> _currentAnswers;

  Question get currentQuestion => _currentQuestion;

  List<Answer> get currentAnswers => _currentAnswers;

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
    final introQuestions = _questions.values
        .where((question) => question.isIntro)
        .where((question) =>
            !question.hasStateCondition ||
            state?[question.stateCondition] == true)
        .toList();
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
    _currentAnswers = _currentQuestion.children.values
        .map((answerId) {
          if (!_answers.containsKey(answerId)) {
            throw 'Possible answer not found. Answer id: $answerId';
          }
          return _answers[answerId]!;
        })
        .where((answer) =>
            !answer.hasStateCondition || state?[answer.stateCondition] == true)
        .toList();
    onUpdateAnswers(_currentAnswers);
  }
}

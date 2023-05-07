import 'dart:ffi';

class Quizzes {
  static Quizzes? _instance;

  Quizzes._();

  factory Quizzes() => _instance ??= Quizzes._();

  final List<Quiz> _quizzes = List.empty(growable: true);

  Quiz getQuiz(String identifier) {
    return _quizzes
        .firstWhere((element) => element.getIdentifier() == identifier);
  }

  Quiz getQuizAt(int index) {
    return _quizzes[index];
  }

  void addQuiz(Quiz quiz) {
    _quizzes.add(quiz);
  }

  void removeQuiz(String identifier) {
    _quizzes.removeWhere((element) => element.getIdentifier() == identifier);
  }

  int getQuizCount() {
    return _quizzes.length;
  }
}

class Quiz {
  String _identifier;
  final List<QuizQuestion> _questions = List.empty(growable: true);

  Quiz(this._identifier);

  String getIdentifier() {
    return _identifier;
  }

  void setIdentifier(String identifier) {
    _identifier = identifier;
  }

  void addQuestion(QuizQuestion question) {
    _questions.add(question);
  }

  void removeQuestionAt(int index) {
    _questions.removeAt(index);
  }

  int getQuizCount() {
    return _questions.length;
  }

  void swapQuestions(int index1, int index2) {
    var temp = _questions[index1];
    _questions[index1] = _questions[index2];
    _questions[index2] = temp;
  }
}

class QuizQuestion {
  String _question;

  QuizQuestion(this._question);

  String getQuestion() {
    return _question;
  }

  void setQuestion(String question) {
    _question = question;
  }
}

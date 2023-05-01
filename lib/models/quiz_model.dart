class Quizzes {
  static Quizzes? _instance;

  Quizzes._();

  factory Quizzes() => _instance ??= Quizzes._();

  final List<Quiz> _quizzes = List.empty(growable: true);

  Quiz getQuiz(String identifier) {
    return _quizzes
        .firstWhere((element) => element.getIdentifier() == identifier);
  }

  void addQuiz(Quiz quiz) {
    _quizzes.add(quiz);
  }

  void removeQuiz(String identifier) {
    _quizzes.removeWhere((element) => element.getIdentifier() == identifier);
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
}

class QuizQuestion {
  String question;

  QuizQuestion(this.question);
}

/*class SingleAnswerQuizQuestion implements QuizQuestion {
  @override
  String question;
}

class MultiAnswerQuizQuestion implements QuizQuestion {
  @override
  String question;
}*/
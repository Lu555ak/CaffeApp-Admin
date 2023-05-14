class Quizzes {
  static Quizzes? _instance;

  Quizzes._();

  factory Quizzes() => _instance ??= Quizzes._();

  final List<Quiz> _quizzes = List.empty(growable: true);

  Quiz getQuiz(String name) {
    return _quizzes.firstWhere((element) => element.getName() == name);
  }

  Quiz getQuizAt(int index) {
    return _quizzes[index];
  }

  void addQuiz(Quiz quiz) {
    _quizzes.add(quiz);
  }

  void removeQuiz(String name) {
    _quizzes.removeWhere((element) => element.getName() == name);
  }

  int getQuizCount() {
    return _quizzes.length;
  }
}

class Quiz {
  String _name;
  String _topic;
  final List<QuizQuestion> _questions = List.empty(growable: true);

  Quiz(this._name, this._topic);

  void setName(String name) => _name = name;
  String getName() => _name;
  void setTopic(String topic) => _topic = topic;
  String getTopic() => _topic;

  void addQuestion(QuizQuestion question) {
    _questions.add(question);
  }

  QuizQuestion getQuestionAt(int index) {
    return _questions[index];
  }

  void setQuestionAt(int index, QuizQuestion question) {
    _questions[index] = question;
  }

  void removeQuestionAt(int index) {
    _questions.removeAt(index);
  }

  int getQuestionCount() {
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

  String getQuestion() => _question;
  void setQuestion(String question) => _question = question;

  String getType() {
    return "QuizQuestion";
  }
}

// True/False
class QuizQuestionTrueFalse implements QuizQuestion {
  @override
  String _question;
  bool _answer;

  QuizQuestionTrueFalse(this._question, this._answer);

  @override
  String getQuestion() => _question;
  @override
  void setQuestion(String question) => _question = question;
  bool getAnswer() => _answer;
  void setAnswer(bool answer) => _answer = answer;
  @override
  String getType() {
    return "QuizQuestionTrueFalse";
  }
}

// Multiple Answers
class QuizQuestionMultiple implements QuizQuestion {
  @override
  String _question;
  final List<QuizQuestionMultipleAnswer> _answers = List.empty(growable: true);

  QuizQuestionMultiple(this._question);

  @override
  String getQuestion() => _question;
  @override
  void setQuestion(String question) => _question = question;

  void addAnswer(String statement, bool isCorrect) {
    _answers.add(QuizQuestionMultipleAnswer(statement, isCorrect));
  }

  void removeAnswerAt(int index) {
    _answers.removeAt(index);
  }

  QuizQuestionMultipleAnswer getAnswerAt(int index) {
    return _answers[index];
  }

  List<QuizQuestionMultipleAnswer> getAnswers() {
    return _answers;
  }

  int answerCount() {
    return _answers.length;
  }

  @override
  String getType() {
    return "QuizQuestionMultipleAnswer";
  }
}

// Fill-in
class QuizQuestionFillIn implements QuizQuestion {
  @override
  String _question;
  final List<String> _answers = List.empty(growable: true);

  QuizQuestionFillIn(this._question);

  @override
  String getQuestion() => _question;
  @override
  void setQuestion(String question) => _question = question;

  void addAnswer(String answer) {
    _answers.add(answer);
  }

  String getAnswerAt(int index) {
    return _answers[index];
  }

  void setAnswerAt(int index, String answer) {
    _answers[index] = answer;
  }

  void removeAnswerAt(int index) {
    _answers.removeAt(index);
  }

  int answerCount() {
    return _answers.length;
  }

  @override
  String getType() {
    return "QuizQuestionFillIn";
  }
}

class QuizQuestionMultipleAnswer {
  String statement;
  bool isCorrect;
  QuizQuestionMultipleAnswer(this.statement, this.isCorrect);
}

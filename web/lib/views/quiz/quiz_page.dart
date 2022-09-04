import 'package:flutter/material.dart';
import 'package:hrio_quiz/core/utils/colors/quiz_colors.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

enum QuizRadioSelected { first, second, third, fourth, fifth, none }

class _QuizPageState extends State<QuizPage> {
  QuizManager quizManager = QuizManager([
    Question(1, "Quantas versões de \"Quarto em Arles\", Van Gogh pintou?",
        [QuestionAlternative(1, '1984'), QuestionAlternative(2, '1994')]),
    Question(2, "Quando foi pintado \"Os comedores de batata\"?",
        [QuestionAlternative(1, '1985'), QuestionAlternative(2, '1995')]),
    Question(3, "Em qual movimento artistico se encaixa Van Gogh?",
        [QuestionAlternative(1, '1986'), QuestionAlternative(2, '1996')])
  ]);
  QuizRadioSelected _option = QuizRadioSelected.none;
  late bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(142),
        child: quizAppBar(context),
      ),
      body: quizStep(context),
    );
  }

  AppBar quizAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 130,
      backgroundColor: qPurpleMapColor[100],
      title: Text(
        'Questão ${quizManager.getCurrentQuestion()}/20',
        style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 42),
      ),
      centerTitle: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
    );
  }

  Widget quizStep(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 25,
        ),
        Expanded(
          flex: 0,
          child: Container(
            height: 120,
            alignment: Alignment.centerLeft,
            child: Card(
              borderOnForeground: false,
              margin: EdgeInsets.zero,
              elevation: 4,
              child: Container(
                  height: 140,
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(quizManager.getQuestionTitle()),
                  )),
              // decoration: BoxDecoration(borderRadius: )
            ),
          ),
        ),
        const SizedBox(
          height: 70,
        ),
        Expanded(
          flex: 0,
          child: Container(
            child: Column(
              children: <Widget>[
                for (var altIndex = 0;
                    altIndex < quizManager.getTotalAlternatives();
                    altIndex++)
                  InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      onTap: () {
                        setState(() {
                          _option = QuizRadioSelected.values[altIndex];
                        });
                      },
                      child: Container(
                          height: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: (_option.name ==
                                          QuizRadioSelected
                                              .values[altIndex].name)
                                      ? Colors.purple
                                      : Colors.white,
                                  width: 1.5),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: Row(
                            children: [
                              const SizedBox(width: 20),
                              Container(
                                height: 60 * 0.68,
                                decoration: const BoxDecoration(
                                  color: Colors.orange,
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Text(altIndex.toString(),
                                    style:
                                        const TextStyle(color: Colors.white)),
                              ),
                              const SizedBox(width: 35),
                              Text(quizManager.getAlternativeTitle(altIndex),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ],
                          ))),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        (quizManager.isLastStep()) ? finishButton() : nextButton(),
        previousButton(),
      ],
    );
  }

  Widget nextButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          saveSelectedAnswer(quizManager.getQuestionId(), quizManager.getAlternativeId(_option.index));
          quizManager.nextQuestion();
        });
      },
      child: const Text('Próximo'),
    );
  }

  Widget finishButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          saveSelectedAnswer(quizManager.getQuestionId(), quizManager.getAlternativeId(_option.index));
          saveAnswer();
        });
      },
      child: const Text('Finalizar'),
    );
  }

  Widget previousButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          quizManager.previousQuestion();
        });
      },
      child: const Text('Anterior'),
    );
  }

  void saveSelectedAnswer(int questionId, int alternativeId) {
    quizManager
        .addAnswer({'questionId': questionId, 'alternativeId': alternativeId});
  }

  void saveAnswer() {
    print(quizManager.getAnswers());
    //do request

    // Reset selected answers after request
    _option = QuizRadioSelected.none;
    quizManager.reset();
  }
}

class QuizManager {
  int _questionIndex = 0;
  List<Question> questions;

  QuizManager(this.questions);

  late List<Object> answers = [];

  List<Object> getAnswers() {
    return answers;
  }

  int getTotalQuestions() {
    return questions.length;
  }

  int getTotalAlternatives() {
    return questions[_questionIndex].alternatives.length;
  }

  int getCurrentQuestion() {
    return _questionIndex + 1;
  }

  int getQuestionId() {
    return questions[_questionIndex].id;
  }
  
  int getAlternativeId(int alternativeIndex) {
    return questions[_questionIndex].alternatives[alternativeIndex].id;
  }

  void nextQuestion() {
    if (_questionIndex < getTotalQuestions()) {
      _questionIndex++;
    }
  }

  void previousQuestion() {
    if (_questionIndex > 0) {
      _questionIndex--;
    }
  }

  void addAnswer(Object answer) {
    answers.add(answer);
  }

  void reset() {
    answers = [];
  }

  String getQuestionTitle() {
    return questions[_questionIndex].title;
  }

  String getAlternativeTitle(int alternativeIndex) {
    return questions[_questionIndex].alternatives[alternativeIndex].title;
  }

  bool isLastStep() {
    if(_questionIndex == (getTotalQuestions()-1)) {
      return true;
    }

    return false;
  }

  bool isFinished(List<Object> answers) {
    if (isLastStep() &&
        _questionIndex == answers.length - 1) {
      return true;
    }

    return false;
  }
}

class Question {
  late int id;
  late String title;
  late List<QuestionAlternative> alternatives;

  Question(this.id, this.title, this.alternatives);
}

class QuestionAlternative {
  late int id;
  late String title;

  QuestionAlternative(this.id, this.title);
}

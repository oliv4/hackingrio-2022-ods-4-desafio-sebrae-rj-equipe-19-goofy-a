import 'package:flutter/material.dart';
import 'package:hrio_quiz/core/utils/colors/quiz_colors.dart';
import 'package:hrio_quiz/model/challenges/challenge_model.dart';
import '../../controller/quiz/quiz_quiz_controller.dart' as quiz;

class ChallengePage extends StatefulWidget {
  const ChallengePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChallengePageState createState() => _ChallengePageState();
}

enum ChallengeRadioSelected { first, second, third, fourth, fifth, none }

class _ChallengePageState extends State<ChallengePage> {
  late Future<ChallengeModel> futureChallenge;
  late bool isSelected;
  late ChallengeModel? nChallenge;

  ChallengeManager challengeManager = ChallengeManager([
    Question(1, "Quantas versões de \"Quarto em Arles\", Van Gogh pintou?", [
      QuestionAlternative(1, '2'),
      QuestionAlternative(2, '3'),
      QuestionAlternative(3, '1'),
      QuestionAlternative(4, '4')
    ]),
    Question(2, "Quando foi pintado \"Os comedores de batata\"?", [
      QuestionAlternative(1, '1880'),
      QuestionAlternative(2, '1885'),
      QuestionAlternative(3, '1887'),
      QuestionAlternative(4, '1882')
    ]),
    Question(3, "Em qual movimento artistico se encaixa Van Gogh?", [
      QuestionAlternative(1, 'Expressionismo'),
      QuestionAlternative(2, 'Pós-expressionismo'),
      QuestionAlternative(3, 'Vanguarda'),
      QuestionAlternative(4, 'Pós-Clássico')
    ])
  ]);

  // late ChallengeManager challengeManager;

  ChallengeRadioSelected _option = ChallengeRadioSelected.none;

  @override
  void initState() {
    super.initState();
    futureChallenge = quiz.fetchData('4ec09e94-85d1-4fae-be9d-e0934261b441')
        as Future<ChallengeModel>;
  }

  @override
  Widget build(BuildContext context) {
    return challenges(context);
  }

  Widget challenges(BuildContext context) {
    return FutureBuilder<ChallengeModel>(
        future: futureChallenge,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            nChallenge = snapshot.data;
            // challengeManager = ChallengeManager(nChallenge!.questions);
            // print(challengeManager);

            return quizComponent(context);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
         return const Center(
          child: CircularProgressIndicator(),
        );
        });
  }

  Scaffold quizComponent(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: challengeAppBar(context),
        ),
        body: challengeStep(context));
  }

  AppBar challengeAppBar(BuildContext context) {
    return AppBar(
        toolbarHeight: 120,
        backgroundColor: qPurpleMapColor[100],
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        title: Row(
          children: [
            Text(nChallenge!.title.toString()),
            const Spacer(),
            Text(
              '${challengeManager.getCurrentQuestion()}/${challengeManager.getTotalQuestions()}',
              style:
                  const TextStyle(fontWeight: FontWeight.normal, fontSize: 42),
            ),
            const SizedBox(width: 40),
          ],
        ));
  }

  Widget challengeStep(BuildContext context) {
    return Column(children: [
      const SizedBox(
        height: 25,
      ),
      Container(
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
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 40, right: 40),
                child: Text(
                  challengeManager.getQuestionTitle(),
                  style: const TextStyle(fontSize: 28),
                ),
              )),
        ),
      ),
      const SizedBox(
        height: 70,
      ),
      Wrap(
        runSpacing: 20,
        children: <Widget>[
          for (var altIndex = 0;
              altIndex < challengeManager.getTotalAlternatives();
              altIndex++)
            InkWell(
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                onTap: () {
                  setState(() {
                    _option = ChallengeRadioSelected.values[altIndex];
                  });
                },
                child: Card(
                    borderOnForeground: false,
                    margin: const EdgeInsets.only(left: 50, right: 50),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0),
  ),
                    child: Container(
                        height: 70,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: (_option.name ==
                                        ChallengeRadioSelected
                                            .values[altIndex].name)
                                    ? Colors.purple
                                    : Colors.white,
                                width: 1.5),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8))),
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
                              child: Text((altIndex + 1).toString(),
                                  style: const TextStyle(color: Colors.white)),
                            ),
                            const SizedBox(width: 35),
                            Text(challengeManager.getAlternativeTitle(altIndex),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                          ],
                        )))),
        ],
      ),
      Row(
        children: [
          const SizedBox(
            width: 50,
            height: 120,
          ),
          previousButton(),
          const Spacer(),
          (challengeManager.isLastStep()) ? finishButton() : nextButton(),
          const SizedBox(width: 50)
        ],
      )
    ]);
  }

  Widget nextButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: qPurpleMapColor[100],
        onPrimary: Colors.white,
        minimumSize: Size(120, 50),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6)),
      ),
      onPressed: () {
        setState(() {
          saveSelectedAnswer(challengeManager.getQuestionId(),
              challengeManager.getAlternativeId(_option.index));
          challengeManager.nextQuestion();
          _option = ChallengeRadioSelected.none;
        });
      },
      child: const Text('Próximo'),
    );
  }

  Widget finishButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: qPurpleMapColor[100],
        onPrimary: Colors.white,
        minimumSize: Size(120, 50),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6)),
      ),
      onPressed: () {
        setState(() {
          saveSelectedAnswer(challengeManager.getQuestionId(),
              challengeManager.getAlternativeId(_option.index));
          saveAnswer();
        });
      },
      child: const Text('Finalizar'),
    );
  }

  Widget previousButton() {
    return OutlinedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        onPrimary: qPurpleMapColor[100],
        shape: RoundedRectangleBorder(
            side: const BorderSide(
                color: Colors.purple, width: 1, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(6)),
        minimumSize: Size(120, 50)
      ),
      onPressed: () {
        setState(() {
          challengeManager.previousQuestion();
        });
      },
      child: const Text('Anterior'),
    );
  }

  void saveSelectedAnswer(int questionId, int alternativeId) {
    challengeManager
        .addAnswer({'questionId': questionId, 'alternativeId': alternativeId});
  }

  void saveAnswer() {
    print(challengeManager.getAnswers());
    //do request
    Navigator.of(context).pushNamed('/home');
    // Reset selected answers after request
    _option = ChallengeRadioSelected.none;
    challengeManager.reset();
  }
}

class ChallengeManager {
  int _questionIndex = 0;
  List<Question> questions;

  ChallengeManager(this.questions);

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
    if (_questionIndex == (getTotalQuestions() - 1)) {
      return true;
    }

    return false;
  }

  bool isFinished(List<Object> answers) {
    if (isLastStep() && _questionIndex == answers.length - 1) {
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

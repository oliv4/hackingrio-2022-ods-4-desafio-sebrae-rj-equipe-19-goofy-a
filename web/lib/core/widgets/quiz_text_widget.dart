import 'package:flutter/material.dart';

class QuizButton extends StatelessWidget {
  QuizButton({Key? key}) : super(key: key);

  //inicializo as variaveis padroes dos botoes
  String text = '';
  double height = 50;
  IconData? quizSufixIcon;
  IconData? quizPrefixIcon;
  double width = 120;
  ButtonStyle style = MainButtonStyle();
  Color backgroundColor = const Color(0xff000000);
  Color color = const Color(0xffFFFFFF);
  var callback;

  QuizButton.defaultButton(
      {Key? key,
      msg,
      cb,
      sizeHeight = 30.0,
      styleButton = MainButtonStyle,
      sizeWidth = 120.0,
      IconData? prefixIcon = null,
      IconData? sufixIcon = null})
      : super(key: key) {
    style = styleButton();
    text = msg;
    height = sizeHeight;
    callback = cb;
    width = sizeWidth;
    quizPrefixIcon = prefixIcon;
    quizSufixIcon = sufixIcon;
  }

  QuizButton.next(cb, {Key? key}) : super(key: key) {
    style = MainButtonStyle();
    text = 'Proximo';
    height = 50;
    callback = cb;
  }

  QuizButton.jump(cb, {Key? key}) : super(key: key) {
    style = MainButtonStyle();
    text = 'Pular';
    height = 39;
    callback = cb;
  }

  QuizButton.signUp(cb, {Key? key}) : super(key: key) {
    style = MainButtonStyle();
    text = 'Cadastrar';
    height = 50;
    callback = cb;
  }

  QuizButton.save(cb, {Key? key}) : super(key: key) {
    style = MainButtonStyle();
    text = 'Salvar';
    height = 50;
    callback = cb;
  }

  QuizButton.enter(cb, {Key? key}) : super(key: key) {
    style = MainButtonStyle();
    text = 'Entrar';
    height = 50;
    callback = cb;
  }

  QuizButton.proceed(cb, {Key? key}) : super(key: key) {
    style = MainButtonStyle();
    text = 'Continuar';
    height = 50;
    callback = cb;
  }


  QuizButton.customized(
      this.text, this.callback, this.height, this.backgroundColor, this.color,
      {Key? key})
      : style = ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(backgroundColor),
            foregroundColor: MaterialStateProperty.all(color),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
            textStyle: MaterialStateProperty.all(const TextStyle(
              fontFamily: 'Rubik',
              fontStyle: FontStyle.normal,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ))),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    //print('tamanho do botao:' + width.toString());
    return SizedBox(
        width: width == 0 ? 100 : width,
        child: Container(
          height: this.height.toDouble(),
          child: ElevatedButton(
            onPressed: callback,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                (quizPrefixIcon != null)
                    ? Icon(
                        quizPrefixIcon,
                        size: this.height * 0.6,
                      )
                    : SizedBox.shrink(),
                (quizPrefixIcon != null)
                    ? SizedBox(
                        width: 12,
                      )
                    : SizedBox.shrink(),
                Text(text),
                (quizSufixIcon != null)
                    ? SizedBox(
                        width: 12,
                      )
                    : SizedBox.shrink(),
                (quizSufixIcon != null)
                    ? Icon(
                        quizSufixIcon,
                        size: this.height * 0.6,
                      )
                    : SizedBox.shrink(),
              ],
            ),
            style: style,
          ),
        ));
  }
}

ButtonStyle MainButtonStyle() {
  return ButtonStyle(
      elevation: MaterialStateProperty.all(0),
      backgroundColor: MaterialStateProperty.all(Colors.red),
      foregroundColor: MaterialStateProperty.all(Colors.black),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20))),
      textStyle: MaterialStateProperty.all(TextStyle(
        fontFamily: 'Rubik',
        fontStyle: FontStyle.normal,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      )));
}
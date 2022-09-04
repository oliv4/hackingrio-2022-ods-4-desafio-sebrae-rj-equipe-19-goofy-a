import 'package:flutter/material.dart';

class QuizButton extends StatelessWidget {
  QuizButton({Key? key}) : super(key: key);

  String qText = '';
  double qHeight = 50;
  double qWidth = 120;
  IconData? qSuffixIcon;
  IconData? qPrefixIcon;
  ButtonStyle qStyle = qButtonStyle();
  // ignore: prefer_typing_uninitialized_variables
  var qCallback;

  QuizButton.defaultButton({
    Key? key,
    text,
    callback,
    height = 30.0,
    width = 120.0,
    IconData? suffixIcon,
    IconData? prefixIcon,
    styleButton = qButtonStyle,
  }) : super(key: key) {
    qText = text;
    qCallback = callback;
    qHeight = height;
    qWidth = width;
    qSuffixIcon = suffixIcon;
    qPrefixIcon = prefixIcon;
    qStyle = styleButton();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: qWidth == 0 ? 100 : qWidth,
        child: Container(
          height: qHeight.toDouble(),
          child: ElevatedButton(
            onPressed: qCallback,
            style: qStyle,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [qButtonIcon()],
            ),
          ),
        ));
  }

  Widget qButtonIcon() {
    if (qPrefixIcon == null) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        Icon(
          qPrefixIcon,
          size: qHeight * 0.6,
        ),
        Text(qText),
      ],
    );
  }
}

ButtonStyle qButtonStyle() {
  return ButtonStyle(
    elevation: MaterialStateProperty.all(0),
    backgroundColor: MaterialStateProperty.all(Colors.purple),
    foregroundColor: MaterialStateProperty.all(Colors.black),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
    textStyle: MaterialStateProperty.all(
      const TextStyle(
        color: Colors.white,
        fontFamily: 'Nunito',
        fontSize: 18,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

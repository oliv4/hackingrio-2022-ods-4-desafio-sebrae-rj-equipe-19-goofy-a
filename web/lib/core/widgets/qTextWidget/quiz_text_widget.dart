

import 'package:flutter/material.dart';

import '../../utils/style/quiz_text_style.dart';

class QuizText extends StatelessWidget {
  const QuizText(
      {Key? key,
      required this.text,
      required this.style,
      this.color,
      this.alignment, 
      this.overflow, 
      this.maxLines})
      : super(key: key);

  final String text;
  final TextStyle style;
  final Color? color;
  final TextAlign? alignment;
  final TextOverflow? overflow;
  final int? maxLines;

  const QuizText.h1Regular(this.text, {this.color, this.alignment, this.overflow, this.maxLines})
      : style = h1RegularStyle;
  const QuizText.h2Regular(this.text, {this.color, this.alignment, this.overflow, this.maxLines})
      : style = h2RegularStyle;
  const QuizText.h3Regular(this.text, {this.color, this.alignment, this.overflow, this.maxLines})
      : style = h3RegularStyle;
  const QuizText.h4Regular(this.text, {this.color, this.alignment, this.overflow, this.maxLines})
      : style = h4RegularStyle;
  const QuizText.h5Regular(this.text, {this.color, this.alignment, this.overflow, this.maxLines})
      : style = h5RegularStyle;
  const QuizText.h6Regular(this.text, {this.color, this.alignment, this.overflow, this.maxLines})
      : style = h6RegularStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text,
        textAlign: this.alignment != null ? this.alignment : TextAlign.start,
        maxLines:this.maxLines,
        style: TextStyle(
          fontFamily: this.style.fontFamily,
          fontSize: this.style.fontSize,
          fontWeight: this.style.fontWeight,
          fontStyle: this.style.fontStyle,
          color: this.color != null ? this.color : Colors.white,
          overflow: this.overflow,
        ),
      ),
    );
  }
}

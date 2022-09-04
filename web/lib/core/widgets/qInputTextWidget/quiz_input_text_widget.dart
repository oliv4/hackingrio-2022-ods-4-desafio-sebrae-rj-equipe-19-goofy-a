import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../utils/validators/quiz_validators.dart';
import 'quiz_input_styles.dart';

class QuizInputText extends StatelessWidget {
  final String? hintText;
  final TextInputType textInputType;
  final TextEditingController? controller;
  final TextInputFormatter? formatter;
  final bool? enabled;
  final Widget? prefixIcon;
  final Widget? sulfixIcon;
  final String? errorText;
  final bool Function(String) validate;
  final int minLines;
  final int? maxLines;
  final double? maxHeight;
  final double? minWidth;
  final double? maxWidth;

  final Color? color;
  final Function? onTap;
  final Function? onChanged;
  final Function? onFieldSubmitted;
  final bool? onFocus;
  final TextStyle? textStyle;
  final bool? obscuredText;
  final bool? readonly;

  QuizInputText({
    Key? key,
    this.controller,
    this.hintText,
    this.formatter,
    this.enabled = true,
    this.textInputType = TextInputType.text,
    this.prefixIcon,
    this.sulfixIcon,
    this.errorText = "",
    this.color = Colors.yellow,
    required this.validate,
    required this.minLines,
    this.maxLines = 1,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.onFocus,
    this.textStyle,
    this.maxHeight,
    this.minWidth,
    this.maxWidth,
    this.readonly,
    required this.obscuredText,
  }) : super(key: key);

  static get quizTextInputType => null;
  static get quizFormatter => null;
  static get quizPrefixIcon => null;
  static get quizSulfixIcon => null;
  static get quizValidate => null;
  static get quizMinLines => null;
  static get quizObscuredText => false;

  QuizInputText.simple({
    required this.hintText,
    required this.controller,
    required this.enabled,
    this.errorText = 'Este campo não pode ser vazio.',
    this.color,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.onFocus,
    this.textStyle,
    this.maxLines,
    this.obscuredText = false,
    this.maxHeight,
    this.minWidth,
    this.maxWidth,
    this.readonly,
  })  : textInputType = TextInputType.text,
        formatter = MaskTextInputFormatter(mask: ""),
        prefixIcon = null,
        sulfixIcon = null,
        validate = isNotEmpty,
        minLines = 1;

  QuizInputText.body({
    required this.hintText,
    required this.controller,
    required this.enabled,
    this.errorText,
    this.color,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.onFocus,
    this.textStyle,
    this.maxLines,
    this.obscuredText,
    this.maxHeight,
    this.minWidth,
    this.maxWidth,
    this.readonly,
  })  : textInputType = quizTextInputType,
        formatter = quizFormatter,
        prefixIcon = quizPrefixIcon,
        sulfixIcon = quizSulfixIcon,
        validate = quizValidate,
        minLines = quizMinLines;

  QuizInputText.passwordInput({
    this.color,
    this.hintText,
    this.enabled,
    required this.controller,
    this.errorText = '********',
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.onFocus,
    this.textStyle,
    this.maxLines,
    this.obscuredText,
    this.sulfixIcon,
    this.maxHeight,
    this.minWidth,
    this.maxWidth,
    this.readonly,
  })  : textInputType = TextInputType.text,
        formatter = MaskTextInputFormatter(
          mask: "",
        ),
        prefixIcon = null,
        validate = isPassword,
        minLines = 1;

  QuizInputText.textInput(
    this.hintText,
    this.controller, [
    this.enabled,
    this.errorText = 'Este campo não pode ser vazio.',
    this.color,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.onFocus,
    this.textStyle,
    this.maxLines,
    this.maxHeight,
    this.minWidth,
    this.maxWidth,
    this.readonly,
  ])  : textInputType = TextInputType.text,
        formatter = MaskTextInputFormatter(mask: ""),
        prefixIcon = null,
        sulfixIcon = null,
        validate = isNotEmpty,
        minLines = 1,
        obscuredText = quizObscuredText;

  QuizInputText.textInputNoEmptyValidation(
    this.hintText,
    this.controller, [
    this.enabled,
    this.errorText,
    this.color,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.onFocus,
    this.textStyle,
    this.maxLines,
    this.maxHeight,
    this.minWidth,
    this.maxWidth,
    this.readonly,
  ])  : textInputType = TextInputType.text,
        formatter = MaskTextInputFormatter(mask: ""),
        prefixIcon = null,
        sulfixIcon = null,
        validate = noValidate,
        minLines = 1,
        obscuredText = quizObscuredText;


  QuizInputText.nameInput(
    this.hintText,
    this.controller, {
    this.enabled,
    this.errorText = 'Preencha o nome corretamente',
    this.color,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.onFocus,
    this.textStyle,
    this.maxLines,
    this.maxHeight,
    this.minWidth,
    this.maxWidth,
    this.readonly,
    this.sulfixIcon,
  })  : textInputType = TextInputType.name,
        formatter = MaskTextInputFormatter(mask: ""),
        prefixIcon = null,
        validate = isNotEmpty,
        minLines = 1,
        obscuredText = quizObscuredText;

  QuizInputText.userInfo(
    this.hintText,
    this.controller, [
    this.enabled,
    this.errorText = '',
    this.color,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.onFocus,
    this.textStyle,
    this.maxLines,
    this.maxHeight,
    this.minWidth,
    this.maxWidth,
    this.readonly,
  ])  : textInputType = TextInputType.text,
        formatter = MaskTextInputFormatter(
          mask: "",
        ),
        prefixIcon = null,
        sulfixIcon = null,
        validate = noValidate,
        minLines = 5,
        obscuredText = quizObscuredText;

  QuizInputText.numberInput({
    required this.hintText,
    required this.controller,
    required this.enabled,
    this.errorText = 'Este campo não pode ser vazio.',
    this.color,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.onFocus,
    this.textStyle,
    this.maxLines,
    this.maxHeight,
    this.minWidth,
    this.maxWidth,
    this.readonly,
  })  : textInputType = TextInputType.number,
        formatter = FilteringTextInputFormatter.digitsOnly,
        prefixIcon = null,
        sulfixIcon = null,
        validate = isNotEmpty,
        minLines = 1,
        obscuredText = quizObscuredText;

  QuizInputText.emailInput({
    required this.hintText,
    required this.controller,
    this.enabled,
    this.errorText = 'Preencha o e-mail corretamente',
    this.color,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.onFocus,
    this.textStyle,
    this.maxLines,
    this.maxHeight,
    this.minWidth,
    this.maxWidth,
    this.readonly,
  })  : textInputType = TextInputType.emailAddress,
        formatter = MaskTextInputFormatter(
          mask: "",
        ),
        prefixIcon = null,
        sulfixIcon = null,
        validate = isEmail,
        minLines = 1,
        obscuredText = quizObscuredText;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: maxHeight ?? 37,
        minHeight: 25,
        minWidth: minWidth ?? double.infinity,
        maxWidth: maxWidth ?? double.infinity,
      ),
      child: TextFormField(
        validator: (value) {
          if (!this.validate(value!)) {
            return this.errorText;
          } else {
            return null;
          }
        },
        enabled: this.enabled,
        controller: this.controller,
        minLines: this.minLines,
        maxLines: this.maxLines ?? 5,
        inputFormatters: [this.formatter!],
        textAlignVertical: TextAlignVertical.center,
        keyboardType: textInputType,
        style: textStyle ?? defaultTextSytle,
        autofocus: onFocus ?? false,
        readOnly: readonly ?? false,
        decoration: InputDecoration(
          filled: true,
          fillColor:
              this.enabled == false ? Colors.grey : Colors.white,
          focusedErrorBorder: null,
          errorBorder: null,
          enabledBorder: null,
          disabledBorder: null,
          focusedBorder: null,
          isDense: true,
          hintText: this.hintText,
          hintStyle: textStyle ?? defaultTextSytle,
          prefixIcon: this.prefixIcon,
          suffixIcon: this.sulfixIcon,
          border: OutlineInputBorder(),
        ),
        onTap: onTap as void Function()?,
        onChanged: onChanged as void Function(String)?,
        onFieldSubmitted: onFieldSubmitted as void Function(String)?,
        obscureText: this.obscuredText!,
      ),
    );
  }
}
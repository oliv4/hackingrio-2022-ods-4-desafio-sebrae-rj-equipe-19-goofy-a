import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hrio_quiz/core/utils/colors/quiz_colors.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import '../../controller/login/quiz_login_controller.dart';
import '../../core/widgets/qInputTextWidget/quiz_input_text_widget.dart';
import '../../core/widgets/qTextWidget/quiz_text_widget.dart';
import '../../core/widgets/quiz_text_widget.dart';
import '../../model/login/login_model.dart';

class LoginUI extends StatefulWidget {
  late TextEditingController emailController = TextEditingController(text: 'hackingrio');
  late TextEditingController passwordController = TextEditingController(text: 'blockchain');
  late GlobalKey<FormState> _formData;

  LoginUI({Key? key}) : super(key: key);

  @override
  State<LoginUI> createState() => _LoginUIState();
}


class _LoginUIState extends State<LoginUI> {
  final _formData = GlobalKey<FormState>();
  
  bool _obscureText = true;
    // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isApiCallProcess = false;
    return Scaffold(
      body: ProgressHUD(
        inAsyncCall: isApiCallProcess,
        key: UniqueKey(),
        child: Form(
          key: _formData,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                      0.01,
                      0.2,
                      1.0,
                      1.1,
                    ],
                    colors: [
                      qOrangeMapColor[100]!,
                      qOrangeMapColor[90]!,
                      qPurpleMapColor[90]!,
                      qPurpleMapColor[100]!,
                    ],
                  )
                ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  const SizedBox(
                                    height: 16,
                                  ),
                                Container(
                                  child: QuizText.h1Regular(
                                    'Entrar',
                                    color: qWhiteColor,
                                    alignment: TextAlign.left,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 32,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 180),
                                      child: QuizText.h3Regular('Usuário:',
                                          color: qWhiteColor),
                                    ),
                                    const SizedBox(
                                    height: 16,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 250,
                                  child: QuizInputText.textInput('Usuário', widget.emailController)
                                ),
                                const SizedBox(
                                    height: 16,
                                    ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                      padding: EdgeInsets.only(right: 190),
                                      child: QuizText.h3Regular('Senha:',
                                          color: qWhiteColor),
                                    ),
                                const SizedBox(
                                  height: 16,
                                  ),
                                SizedBox(
                                  width: 250,
                                  child: QuizInputText.passwordInput(
                                    color: qGreyMapColor[100],
                                    errorText:
                                        'Preencha sua senha corretamente',
                                    hintText: 'Senha',
                                    controller: widget.passwordController,
                                    maxLines: 1,
                                    obscuredText: _obscureText,
                                    sulfixIcon: IconButton(
                                      onPressed: () {
                                       _toggle();
                                      },
                                      icon: Icon(
                                        _obscureText
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                      splashRadius: 20,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 32,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(1),
                                  ),
                                  height: 40,
                                  width: 250,
                                  child: Row(
                                    children: [
                                      SizedBox(width: 65),
                                      QuizButton.customized('Entrar', () {
                                        var form = _formData.currentState;
                                        if (form!.validate()) {
                                          setState(() {
                                            isApiCallProcess = true;
                                          });
              
                                          QLoginRequestModel model = QLoginRequestModel(
                                            username: widget.emailController.text,
                                            password: widget.passwordController.text,
                                          );
              
                                          APIService.login(model).then(
                                            (response) {
                                              setState(() {
                                                isApiCallProcess = false;
                                              });
              
                                              if (response) {
                                                Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  '/home',
                                                  (route) => false,
                                                );
                                              } else {
                                                SnackBar(
                                                content: const Text('Yay! A SnackBar!'),
                                                action: SnackBarAction(
                                                  label: 'Undo',
                                                  onPressed: () {
                                                    // Some code to undo the change.
                                                  },
                                                ),
                                              );
                                                FormHelper.showSimpleAlertDialog(
                                                  context,
                                                  dotenv.env['API_NAME']!,
                                                  "Invalid Username/Password !!",
                                                  "OK",
                                                  () {
                                                    Navigator.of(context).pop();
                                                  },
                                                );
                                              }
                                            },
                                          );
                                        }
                                      }, 347, qPurpleMapColor[100]!, qWhiteColor),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 30),
                                SizedBox(
                                  width: 270,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        child: Row(
                                          children: [
                                            Text(
                                            "Não tem conta?",
                                                  style: TextStyle(
                                                    color: qWhiteColor,
                                                    fontWeight: FontWeight.w300),    
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                            "Cadastrar",
                                            style: TextStyle(
                                              color: qGreyMapColor[100],
                                              fontWeight: FontWeight.w300,
                                              decoration:
                                              TextDecoration.underline,
                                              decorationColor: qPurpleMapColor[100],
                                              decorationThickness: 4,
                                            ),
                                      ),
                                          ],
                                        ),
                                        onPressed: () {
                                          // Get.offAndToNamed('/recovery');
                                        }
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                   Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: qWhiteColor,
                          ),
                      // width: 685,
                      child: Column(
                        children: [
                        Stack(
                          children: <Widget>[
                            Container(
                              width: 600,
                                padding: EdgeInsets.only(top: 20),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/login/logoprincipal.png",
                                      fit: BoxFit.fitWidth,
                                    ),
                                    Image.asset(
                                      "assets/images/login/logo.png",
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ],
                                ),
                            )
                          ],
                        ),
                        ],
                      ),
                    ),
                  ),
                    ],
                  )),
                ],
              ),
            ),
          ],),
        ),
      ),
    );
  }

   bool validateAndSave() {
    final form = widget._formData.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
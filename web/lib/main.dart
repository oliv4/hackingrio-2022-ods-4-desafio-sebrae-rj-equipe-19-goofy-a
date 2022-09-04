import 'package:cache_manager/core/cache_manager_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hrio_quiz/views/challenges/challenges_page.dart';
import 'package:hrio_quiz/views/home/home_page.dart';
import 'package:hrio_quiz/views/login/login_page.dart';
import 'package:hrio_quiz/views/metaverse/metaverse_page.dart';

Widget _defaultHome = LoginUI();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "dotenv");

  // Get result of the login function.
    CacheManagerUtils.conditionalCache(
        key: "cache",
        valueType: ValueType.StringValue,
        actionIfNull: () {
          _defaultHome = LoginUI();
        },
        actionIfNotNull: () {
          _defaultHome = const HomePage();
        });

  _defaultHome = LoginUI();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const LoginPage(),
      routes: {
        '/': (context) => _defaultHome,
        '/home': (context) => const HomePage(),
        '/login': (context) => LoginUI(),
        '/challenges': (context) => const ChallengePage(),
        '/metaverse': (context) => const MetaversePage(),
      },
    );
  }
}
import 'package:cache_manager/core/delete_cache_service.dart';
import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
import 'package:hrio_quiz/core/utils/colors/quiz_colors.dart';
import 'package:hrio_quiz/views/events/events_page.dart';
import '../../controller/login/quiz_login_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: Container(
          padding: EdgeInsets.only(bottom: 40),
          child: AppBar(
                centerTitle: true,
                toolbarHeight: 100,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: <Color>[
                        qOrangeMapColor[100]!,
                        qPurpleMapColor[100]!,
                        qPurpleMapColor[100]!
                      ]),
                  ),
                ),
              title: Row(
                children: [
                  Image.asset('assets/images/login/logosecundaria.png', fit: BoxFit.fill), 
                  Card(
                    borderOnForeground: false,
                    margin: const EdgeInsets.only(left: 60, right: 60),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                        height: 30,
                        alignment: Alignment.centerLeft,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(8))),
                        child: Row(
                          
                          children: const [
                            SizedBox(width: 20,),
                            Text.rich(
                                textAlign: TextAlign.left,
                              TextSpan(
                                children: [
                                  TextSpan(text: 'Buscar eventos', style: TextStyle(
                                    fontWeight: FontWeight.normal, fontSize: 11, fontFamily: 'Nunito')),
                                ],
                              ),
                            ),
                            SizedBox(width: 200,),
                          ],
                        ))),
                  const Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(child: Icon(Icons.location_pin, size: 17,)),
                        TextSpan(text: 'Rio de Janeiro', style: TextStyle(fontSize: 15)),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 60,),
                  GestureDetector(
                    onTap: () {
                    },
                    child: const Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(child: Icon(Icons.person, size: 17,)),
                          TextSpan(text: 'Meu Perfil', style: TextStyle(fontSize: 15)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 60),
                  GestureDetector(
                    onTap: () {
                      DeleteCache.deleteKey(
                        "cache", Navigator.of(context).pushNamed('/login'));
                    },
                    child: const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: 'Sair', style: TextStyle(fontSize: 15)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                    // IconButton(
                    //   padding: const EdgeInsets.only(right: 40, top: 35),
                    //   icon: const Icon(
                    //     Icons.logout,
                    //     color: Colors.white,
                    //   ),
                    //   onPressed: () {
                    //     DeleteCache.deleteKey(
                    //     "cache", Navigator.of(context).pushNamed('/login'));
                    //   },
                    // ),
                ],
              )),
              ),
        ),
      body:
       FooterView(
        footer: Footer(
          child: const Text(''),
          padding: EdgeInsets.all(10.0),
        ),
        flex: 1,
        children:<Widget>[
          Padding(
            padding: new EdgeInsets.only(top:0.0),
            child: Center(
              child: userProfile(),
            ),
          ),
        ], //default flex is 2
      ),
      );
  }

  Widget userProfile() {
    return FutureBuilder(
      future: APIService.getUserProfile(),
      builder: (
        BuildContext context,
        AsyncSnapshot<String> model,
      ) {
        if (model.hasData) {
          return const Center(
            child: EventPage(),
            );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
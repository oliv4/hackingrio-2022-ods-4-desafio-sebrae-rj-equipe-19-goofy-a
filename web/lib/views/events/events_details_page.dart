import 'package:cache_manager/core/delete_cache_service.dart';
import 'package:cache_manager/core/write_cache_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
import 'package:hrio_quiz/core/widgets/qButtonWidget/quiz_button.dart';
import 'package:hrio_quiz/model/events/quiz_events_model.dart';
import 'package:hrio_quiz/views/metaverse/metaverse_page.dart';

import '../../core/utils/colors/quiz_colors.dart';

class EventDetailPage extends StatelessWidget {
  const EventDetailPage({Key? key, required this.quiz}) : super(key: key);


  final quizEventsModel quiz;
  
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
                  Spacer(),
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
      body: FooterView(
        footer: Footer(
          child: Container(
            width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    qOrangeMapColor[100]!,
                    qPurpleMapColor[100]!,
                    qPurpleMapColor[100]!
                  ]),
              ),
              child: Row(children: [
                  Card()
                ],
              )
            ),
        ),
        flex: 1,
        children:<Widget>[
          Padding(
            padding: new EdgeInsets.only(top:0.0),
            child: Center(
              child:  Container(
        child: Column(
          children: [
          Container(
            padding: EdgeInsets.only(top: 30, left: 20),
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 1, bottom: 20, right: 300),
                      child: Text(quiz.title, style: TextStyle(fontSize: 20),),
                    ),
                    Container(
                      width: 500.00,
                      height: 250.00,
                      decoration: BoxDecoration(
                         borderRadius: BorderRadius.all(Radius.circular(20)),
                        image: new DecorationImage(
                            image: NetworkImage(quiz.bannerUrl),
                            fit: BoxFit.cover,
                            ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.topLeft,
                        width: 400,
                        height: 100,
                        child: Text(quiz.description, style: TextStyle(fontSize: 13)),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 200, bottom: 50),
                      child: ElevatedButton(
                        onPressed: () => {
                          print(quiz.id),
                          WriteCache.setString(key: "event_cache", value: quiz.id),
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context)=> MetaversePage()
                            ))
                      },
                        child: Text('Verificar no Metaverso'),
                        style: TextButton.styleFrom(primary: qWhiteColor, backgroundColor: qPurpleMapColor[100]),
                      )
                    
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
              padding: EdgeInsets.only( top: 5, left: 25),
              child: Text('Desafios', style: TextStyle(fontSize: 30),
              ),
            ),
          Container(
            alignment: Alignment.topLeft,
              padding: EdgeInsets.only(top: 5, left: 25),
              child: Text('Texte seu conhecimento, escolha um desafio, conclua e receba uma NFT exclusiva do evento', 
              style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: () => {
                print(quiz.id),
                WriteCache.setString(key: "event_cache", value: quiz.id),
                Navigator.of(context).pushNamed('/challenges')
              },
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    height: 200,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: qGreenMapColor[100]!),
                        borderRadius: BorderRadius.circular(15)
                        ),
                      color: qOrangeMapColor[100],
                      child: Stack(
                        children: [
                          ListTile(
                          title: Container(
                            padding: EdgeInsets.only(left: 90,top: 70),
                            child: Text('Desafio 1 - ' + quiz.title, style: TextStyle(color: Colors.white, fontSize: 25),)
                            ),
                          ),
                        ]
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    height: 200,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: qGreenMapColor[100]!),
                        borderRadius: BorderRadius.circular(15)
                        ),
                      color: qRedMapColor[100],
                      child: Stack(
                        children: [
                          ListTile(
                          title: Container(
                            padding: EdgeInsets.only(left: 90,top: 70),
                            child: Text('Desafio 2 - ' + quiz.title, style: TextStyle(color: Colors.white, fontSize: 25),)
                            ),
                          ),
                        ]
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    height: 200,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: qGreenMapColor[100]!),
                        borderRadius: BorderRadius.circular(15)
                        ),
                      color: qPurpleMapColor[100],
                      child: Stack(
                        children: [
                          ListTile(
                          title: Container(
                            padding: EdgeInsets.only(left: 90,top: 70),
                            child: Text('Desafio 3 - ' + quiz.title, style: TextStyle(color: Colors.white, fontSize: 25),)
                            ),
                          ),
                        ]
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
            ),
          ),
        ], //default flex is 2
      ),
    );
  }
}
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hrio_quiz/core/utils/colors/quiz_colors.dart';
import 'package:hrio_quiz/views/events/events_details_page.dart';

import '../../controller/challenges/quiz_challenges_controller.dart';
import '../../model/events/quiz_events_model.dart';
import 'dart:html' as html;


class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {

  late Future <List<quizEventsModel>> futureData;
  late bool showIframe = false;
  //  final Completer<WebViewController> _controller =
  //     Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    futureData = fetchData() as Future<List<quizEventsModel>>;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 400, maxWidth: 1550),
          child: Container(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 20),
                  child: Text('Eventos mais procurados',
                  style: TextStyle(fontSize: 20),)
                  ),
                Container(
                  height: 250,
                  child: events()
                  ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 20),
                  child: Text('Exposições',
                  style: TextStyle(fontSize: 20),)
                  ),
                Container(
                  height: 300,
                  child: events()
                  ),
                         Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 20),
                  child: Text('Apresentações',
                  style: TextStyle(fontSize: 20),)
                  ),
                Container(
                  height: 300,
                  child: events()
                  ),
              ],
            ),
          ),
        ),
      );
      }
    );
  }

  Widget events() {
    return Stack(
      children: [FutureBuilder <List<quizEventsModel>>(
        future:futureData,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            List<quizEventsModel>? data = snapshot.data;
            return ScrollConfiguration(
              behavior: MyCustomScrollBehavior(),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data?.length, 
                itemBuilder: (BuildContext context, int index ) {
                  return Row(
                    children: [
                      SizedBox(width: 20),
                      GestureDetector(
                        onTap: () => {
                          // print(data![index].id),
                          // WriteCache.setString(key: "event_cache", value: data[index].id),
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context)=> EventDetailPage(quiz: data![index])
                            ))
                        },
                        child:Container(
                          height: 250.0,
                          width: 200.0,
                            decoration: const BoxDecoration(
                            color: Color(0xFFffffff),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 15.0, // soften the shadow
                                spreadRadius: 5.0, //extend the shadow
                                offset: Offset(
                                  5.0, // Move to right 5  horizontally
                                  5.0, // Move to bottom 5 Vertically
                                ),
                              )
                            ],
                          ),
                          child: Column (
                            children: [
                            Card(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Container(
                                      decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(data![index].bannerUrl),
                                        ),
                                        ),
                                        height: 200.0,
                                        width: 250.0,
                                        ),
                                      Text(data[index].title)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            ]
                          ),
                        ),
                      ),
                    ],
                  );  
                },
              ),
            );
          } else if(snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        }
      ),
      ],
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
      // Override behavior methods and getters like dragDevices
      @override
      Set<PointerDeviceKind> get dragDevices => { 
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
    }
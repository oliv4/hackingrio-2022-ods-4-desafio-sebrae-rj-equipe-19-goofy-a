import 'package:cache_manager/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_webview/fwfh_webview.dart';
import 'package:hrio_quiz/core/utils/colors/quiz_colors.dart';
import '../../controller/events/quiz_events_controller.dart';
import '../../model/events/events_model.dart';

class MetaversePage extends StatefulWidget {
  const MetaversePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MetaversePageState createState() => _MetaversePageState();
}

class MetaverseIframeWidgetFactory extends WidgetFactory with WebViewFactory {
  @override
  bool get webViewMediaPlaybackAlwaysAllow => true;
  @override
  String? get webViewUserAgent => 'Spatial';
}

class _MetaversePageState extends State<MetaversePage> {
  late Future<List<Events>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

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
                ],
              )),
              ),
        ),
      body: Center(
        child: HtmlWidget(
          '<iframe src="https://spatial.io/s/SEBRAE-Exposicao-Van-Gogh-6313669debd6c80001d71a50?share=532472515839314492"</iframe>',
          factoryBuilder: () => MetaverseIframeWidgetFactory(),
        ),
      ),
    );
  }
}

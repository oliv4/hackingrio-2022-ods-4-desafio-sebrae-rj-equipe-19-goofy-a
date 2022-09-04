
import 'dart:convert';

import 'package:cache_manager/core/read_cache_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hrio_quiz/model/events/quiz_events_model.dart';
import 'package:http/http.dart' as http;

Future<List<quizEventsModel>> fetchData() async {

  var url = Uri.https(
    dotenv.env['API_URL']!,
    dotenv.env['EVENTS']!,
  );
  
  var token = await ReadCache.getString(key: "cache");

  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${token!}'
  };
  var response = await http.get(
    url,
    headers: requestHeaders,
  );

  if(response.statusCode == 200) {
    List jsonResponse =jsonDecode(response.body);

    List<quizEventsModel> events = [];
    var json = jsonResponse;

    for(var element in json) {
      events.add(quizEventsModel(
        id: element['id'], 
        title: element['title'], 
        description: element['description'], 
        metaverseLink: element['metaverseLink'], 
        finishedAt: element['finishedAt'], 
        sponsorId: element['sponsorId'], 
        isActive: element['isActive'], 
        createdAt: element['createdAt'], 
        updatedAt: element['updatedAt'],
        bannerUrl: element['bannerUrl']
      ));
    }
    return events;
  } else {
    throw Exception('Erro!!!!');
  }
}

import 'dart:convert';

import 'package:cache_manager/core/read_cache_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hrio_quiz/model/events/events_model.dart';
import 'package:http/http.dart' as http;

Future<List<Events>> fetchData() async {


  var token = await ReadCache.getString(key: "cache");
  var event_token = await ReadCache.getString(key: "event_cache");

  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${token!}'
  };

  var test = dotenv.env['CHALLENGES']! + '/$event_token';

  var url = Uri.https(
    dotenv.env['API_URL']!,
     test,
  );
  
  print(url);
  var response = await http.get(
    url,
    headers: requestHeaders,
  );

  if(response.statusCode == 200) {
    List jsonResponse =jsonDecode(response.body);

    List<Events> events = [];
    var json = jsonResponse;

    for(var element in json) {
      events.add(Events(
        id: element['id'], 
        challengeId: element['challengeId'], 
        challengeType: element['challengeType'], 
        eventId: element['eventId'], 
        isActive:element['isActive'], 
        createdAt: element['createdAt'], 
        updatedAt: element['updatedAt']));
    }
    return events;
  } else {
    throw Exception('Erro!!!!');
  }
}
import 'dart:convert';
import 'package:cache_manager/core/read_cache_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hrio_quiz/model/challenges/challenge_model.dart';
import 'package:http/http.dart' as http;

Future<ChallengeModel> fetchData(String challengeId) async {
  var token = await ReadCache.getString(key: "cache");
  // var challengeId = await ReadCache.getString(key: "challengeId");
  var quizUrl = dotenv.env['QUIZ']! + '/$challengeId';

  var url = Uri.https(
    dotenv.env['API_URL']!,
    quizUrl,
  );

  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${token!}'
  };
  var response = await http.get(
    url,
    headers: requestHeaders,
  );

  if (response.statusCode != 200) {
    throw Exception('Challenge not found');
  }

  var challenge = ChallengeModel.fromJson(response.body);

  return challenge;
}

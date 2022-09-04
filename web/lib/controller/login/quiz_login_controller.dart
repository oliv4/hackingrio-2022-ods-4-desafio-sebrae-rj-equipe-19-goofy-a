import 'dart:convert';
import 'package:cache_manager/core/read_cache_service.dart';
import 'package:cache_manager/core/write_cache_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class APIService {

  static Future<bool> login(
     model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(
      dotenv.env['API_URL']!,
      dotenv.env['LOGIN_API']!,
    );

    print(url);

    var response = await http.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    print(response);

    if (response.statusCode == 201) {
       await WriteCache.setString(key: "cache", value: response.body);
      return true;
    } else {
      return false;
    }
  }

  static Future<String> getUserProfile() async {
    var token = await ReadCache.getString(key: "cache");

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token!}'
    };

    var url = Uri.http(dotenv.env['API_URL']!, dotenv.env['USER_PROFILE']!);

    var response = await http.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 201) {
      return response.body;
    } else {
      return "";
    }
  }
}
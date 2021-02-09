import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';

class Data {
  static const String urlUser = 'https://reqres.in/api/users';
  static const String urlUserInfo = 'https://reqres.in/api/users/1';

  Future<Map> getData(String url) async {
    Response response = await get(urlUser);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      return map;
    } else {
      throw Exception('Что то пошло не так statusCode: ${response.statusCode}');
    }
  }
}

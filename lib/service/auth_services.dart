import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:inventory_app/model/response_login.dart';

class AuthServices {
  final _host = '172.16.8.163';

  login(String email, String password) async {
    final uri = Uri.http(_host, 'server_inventory/index.php/api/login');

    final response =
        await http.post(uri, body: {'email': email, 'password': password});

    if (response.statusCode == 200) {
      ResponseLogin responseLogin =
          ResponseLogin.fromJson(jsonDecode(response.body));
      return responseLogin;
    } else {
      return null;
    }
  }
}

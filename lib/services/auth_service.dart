import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:app_dolibarr/constants/urls.dart';

class AuthService {
  Client client = Client();

  Future<String> login(String username, String password) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/login?login=$username&password=$password'));
    final body = json.decode(response.body);

    return body["success"]["token"];
  }
}

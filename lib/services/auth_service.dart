import 'dart:convert';

import 'package:http/http.dart' show Client;

class AuthService {
  Client client = Client();

  // Future<String> login(String username, String password) async {
  //   final response = await client
  //       .get(Uri.parse('$BASE_URL/login?login=$username&password=$password'));

  //   final body = json.decode(response.body);

  //   if (response.statusCode == 403) {
  //     return 'null';
  //   }

  //   return body["success"]["token"];
  // }

  Future<String> loginwithUrl(
      String username, String password, String url) async {
    var baseURL = 'https://' + url + '/api/index.php';
    final response = await client
        .get(Uri.parse('$baseURL/login?login=$username&password=$password'));

    final body = json.decode(response.body);

    if (response.statusCode == 403) {
      return 'null';
    }

    return body["success"]["token"];
  }
}

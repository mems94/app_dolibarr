import 'dart:convert';
import 'package:app_dolibarr/constants/urls.dart';
import 'package:app_dolibarr/constants/urls_tiers.dart';
import 'package:app_dolibarr/models/modele_creation_tiers/modele_vente.dart';
import 'package:app_dolibarr/models/tiers.dart';
import 'package:app_dolibarr/utilities/shared_prefs.dart';
import 'package:http/http.dart' as http;

class TiersServiceRms {
  // Client client = Client();

  Future<dynamic> verifierClientExiste({String nomContact, int mode}) async {
    var body;
    // String urlRequest =
    //     "https://www.vahatra-erp.mada-digital.net/api/index.php/thirdparties?sortfield=t.rowid&sortorder=ASC&limit=10&mode=${mode}&sqlfilters=t.nom:=:${nomContact}";

    Map<String, String> queryParams = {
      "sortfield": "t.rowid",
      "sortorder": "ASC",
      "limit": "1",
      "mode": "$mode",
      "sqlfilters": "(t.nom:=:'$nomContact')"
    };

    String queryString = Uri(queryParameters: queryParams).query;

    var requestUrl = BASE_URL_TIERS + '?' + queryString;

    var token = await getValueFromPrefs("dbToken");

    final response = await http.get(
      Uri.parse('$requestUrl'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'DOLAPIKEY': '$token'
      },
    );

    if (response.statusCode == 200) {
      body = jsonDecode(response.body);
      print('Verification client existe (respnose = 200)');
      print("Reponse => $body");
      print(body[0]['id']);
      return body[0]['id'];
    } else {
      body = response.statusCode;
      print('Verification client existe(reponse ?? )');
      print("Reponse => $body");
      print(response.statusCode);
      print('Verification client existe failed');
      return response.statusCode;
    }
  }

  // Future<Tiers> creationClientSiExiste(String socid) {}

  Future<dynamic> creationClientNonExisteVente(String nom) async {
    //Url pour creation tiers client
    var requestUrl = "$BASE_URL/thirdparties";
    // ModeleVente modeleVente =
    //     ModeleVente(name: nom, client: "1", codeClient: "-1");
    var result;

    var token = await getValueFromPrefs("dbToken");

    final response = await http.post(Uri.parse('$requestUrl'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'DOLAPIKEY': '$token'
        },
        body: jsonEncode(
            <String, String>{'name': nom, 'client': '1', 'code_client': '-1'}));
    // body: jsonEncode(modeleVente.toJson()));

    if (response.statusCode == 200) {
      result = jsonDecode(response.body);
    } else {
      result = response.statusCode;
      print('Creation tiers NOK');
    }
    return result;
  }

  Future<dynamic> creationClientNonExisteAchat(String nom) async {
    //Url pour creation tiers client
    var requestUrl = "$BASE_URL/thirdparties";
    // ModeleVente modeleVente =
    //     ModeleVente(name: nom, : "1", codeClient: "-1");
    var result;

    var token = await getValueFromPrefs("dbToken");

    final response = await http.post(Uri.parse('$requestUrl'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'DOLAPIKEY': '$token'
        },
        body: jsonEncode(<String, String>{
          'name': nom,
          'fournisseur': '1',
          'code_fournisseur': '-1'
        }));
    // body: jsonEncode(modeleVente.toJson()));

    if (response.statusCode == 200) {
      result = jsonDecode(response.body);
    } else {
      result = response.statusCode;
      print('Creation tiers NOK');
    }
    return result;
  }
}

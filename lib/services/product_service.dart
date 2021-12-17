import 'dart:convert';

import 'package:app_dolibarr/models/product_model.dart';
import 'package:app_dolibarr/utilities/shared_prefs.dart';
import 'package:http/http.dart' show Client;
import 'package:app_dolibarr/constants/urls.dart';

//Needed to be modified so as to shape the product model with that list of fields already in the db
// and adapt it to the model in product_tiers_api_model model
//May be i need to move this in the model controlled by my model class of provider
//in order to be able controlled all the method in the same place as the goal of the architecture
class ProductService {
  Client client = Client();

  Future<int> saveProduct(String label, String ref, String price) async {
    final product = Product(ref: ref, label: label, price: price);

    var token = await getValueFromPrefs("dbToken");

    final response = await client.post(Uri.parse('$BASE_URL/products'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'DOLAPIKEY': '$token'
        },
        body: jsonEncode(product.toJson()));

    final body = json.decode(response.body);

    return body;
  }
}

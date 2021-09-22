import 'dart:convert';

import 'package:app_dolibarr/models/product_model.dart';
import 'package:http/http.dart' show Client;
import 'package:app_dolibarr/constants/urls.dart';

class ProductService {
  Client client = Client();

  Future<int> saveProduct(String label, String ref) async {
    final product = Product(ref: ref, label: label);

    final response = await client.post(Uri.parse('$BASE_URL/products'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'DOLAPIKEY': 'f9c91cdca20200fbea69173c93ccf2911598f659'
        },
        body: jsonEncode(product.toJson()));

    final body = json.decode(response.body);

    return body;
  }
}

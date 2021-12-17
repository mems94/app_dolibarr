import 'dart:convert';
import 'dart:math';
import 'package:app_dolibarr/models/modele_facture_fournisseur/modele_facture_fournisseur.dart';
import 'package:app_dolibarr/utilities/shared_prefs.dart';
import 'package:http/http.dart' show Client;
import 'package:app_dolibarr/constants/urls.dart';

//Needed to be modified so as to shape the product model with that list of fields already in the db
// and adapt it to the model in product_tiers_api_model model
//May be i need to move this in the model controlled by my model class of provider
//in order to be able controlled all the method in the same place as the goal of the architecture
class ProductServiceRmsSupp {
  Client client = Client();

  int creationRef() {
    Random random = Random();
    int ref = random.nextInt(1000000000);
    return ref;
  }

  Future<dynamic> saveProductToAPISupplier(
      {int socid,
      int datecreation,
      String label,
      String qty,
      int subprice}) async {
    //lines is made from the model
    List<Lines> lines = [
      Lines(
          description: label,
          qty: qty,
          multicurrencySubprice: subprice.toString())
    ];

    int ref = creationRef();

    print("VALEUR DE LA REFERNCE : $ref");

    var product = ModeleFactureFournisseur(
        refSupplier: "$ref",
        socid: socid.toString(),
        date: datecreation,
        lines: lines);

    var token = await getValueFromPrefs("dbToken");

    final response = await client.post(Uri.parse('$BASE_URL/supplierinvoices'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'DOLAPIKEY': '$token'
        },
        body: jsonEncode(product.toJson()));

    final body = json.decode(response.body);

    return body;
  }
}

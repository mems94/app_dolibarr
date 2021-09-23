import 'package:app_dolibarr/models/produit.dart';
import 'package:app_dolibarr/models/produit_tiers.dart';
import 'package:app_dolibarr/screens/contact.dart';
import 'package:app_dolibarr/screens/nouveau_tiers.dart';
import 'package:app_dolibarr/utilities/dbHelper_innerjoin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppDolibarr extends StatefulWidget {
  @override
  _AppDolibarrState createState() => _AppDolibarrState();
}

class _AppDolibarrState extends State<AppDolibarr> {
  List<ProduitTiers> listeProduitTiers = <ProduitTiers>[];
  // int _sortColumnIndex = 0;

  @override
  void initState() {
    super.initState();
    obtenirListeProduit();
  }

  // Future fetchProduit(http.Client client) async {
  //   final data = await client.get(
  //       'http://192.168.43.226/vahatra/api/index.php/login?login=admin&password=vahatra');
  //   print(data);
  // }

  void actualiser() {
    setState(() {});
  }

  var dbProduit = DbHelperProduit();

  void obtenirListeProduit() async {
    List<Map> maps = await dbProduit.getProduitsAndTiers();
    setState(() {
      maps.forEach((element) {
        listeProduitTiers.add(ProduitTiers.fromMap(element));
      });
    });

    for (var i = 0; i < listeProduitTiers.length; i++) {
      debugPrint("LIGNE $i");
      debugPrint(listeProduitTiers[i].contact);
      debugPrint(listeProduitTiers[i].id.toString());
      debugPrint(listeProduitTiers[i].date);
      debugPrint(listeProduitTiers[i].quantite.toString());
      debugPrint(listeProduitTiers[i].prixUnitaire.toString());
    }

    // if (maps.length > 0) {
    //   for (int i = 0; i < maps.length; i++) {
    //     // mesProduitsAndTiers.add(maps[i]);
    //     debugPrint("${maps[i].}");

    //   }
    // }
  }

  DataRow creerUneLigneProduitTiers(ProduitTiers produitT) {
    debugPrint("Creation ligne executée");
    return DataRow(
      key: ValueKey(produitT.id),
      cells: [
        DataCell(
          Text(produitT.date),
        ),
        DataCell(
          Text(produitT.contact), //
          // placeholder: false,
          // showEditIcon: true,
          // onTap: () {
          //   print('onTap');
          // },
        ),
        DataCell(
          Text(
            (produitT.prixUnitaire * produitT.quantite).toString(),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () {
              // Navigator.pushNamed(context, '/contact');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Contact(produitT.id)),
              );
            },
            child: Icon(
              Icons.info_outline,
              color: Colors.green,
              size: 32.0,
            ),
          ),
        ),
      ],
    );
  }

  List<DataColumn> creationColumn() {
    return [
      DataColumn(
        //Column date
        label: Text(
          'Date',
          style: TextStyle(
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      //Column Contact
      DataColumn(
        label: Text(
          'Contact',
          style: TextStyle(
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      //Column Total
      DataColumn(
        label: Text(
          'Total',
          style: TextStyle(
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      //Column Plus
      DataColumn(
        label: Text(
          'Info',
          style: TextStyle(
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    actualiser();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          'Accueil',
          textAlign: TextAlign.center,
        ),
      ),
      body: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: DataTable(
                // sortColumnIndex: _sortColumnIndex,
                sortAscending: true,
                columnSpacing: 0,
                dividerThickness: 1,
                //columns for the headers
                columns: creationColumn(),
                //Row for products
                rows: listeProduitTiers
                    .map((pt) => creerUneLigneProduitTiers(pt))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 30.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: EdgeInsets.all(10.0),
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: NouveauTiers((unNouveauProduit) {
                          setState(() {
                            listeProduitTiers.add(unNouveauProduit);
                          });
                          print('Produit de la classe nouveau tiers ajouté');
                          Navigator.pop(context);
                        }),
                        // child: AddTaskList(
                        //   (newTaskTitle) {
                        //     setState(
                        //       () {
                        //         tasks.add(
                        //           Task(name: newTaskTitle),
                        //         );
                        //       },
                        //     );
                        //     Navigator.pop(context);
                        //   },
                        // ),
                      ),
                    ),
                  );
                },
                // onPressed: () => Navigator.pushNamed(context, '/nouveautiers'),
                child: Text(
                  'Nouveau',
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.0),
          ),
          Visibility(
            visible: false,
            child: Expanded(
              child: Container(
                padding: EdgeInsets.only(right: 30.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    padding: EdgeInsets.all(10.0),
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () =>
                      Navigator.pushNamed(context, '/mettreEnLigne'),
                  child: Text('Mettre en ligne'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

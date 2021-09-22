import 'package:app_dolibarr/models/produit.dart';
import 'package:app_dolibarr/utilities/dbHelper_innerjoin.dart';
import 'package:flutter/material.dart';

class Contact extends StatefulWidget {
  final int id;

  const Contact(this.id);
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  Produit pd;
  @override
  void initState() {
    super.initState();
    debugPrint('${widget.id}');
    obtenirUnProduit(widget.id);
    creerUneLigneProduit();
  }

  var dbProduit = DbHelperProduit();
  List<Produit> listeProduit = <Produit>[];
  void obtenirUnProduit(int id) async {
    // List<Produit> maps = await dbProduit.getProduit(id);
    // setState(() {
    //   maps.forEach((element) {
    //     listeProduit.add(element);
    //     debugPrint(element.toString());
    //   });
    // });
    pd = await dbProduit.getProduit1(id);
    listeProduit.add(pd);
    for (var i = 0; i < listeProduit.length; i++) {
      debugPrint(listeProduit[i].designation);
    }
  }

  DataRow creerUneLigneProduit() {
    debugPrint("Contact - Creation ligne executée ");
    return DataRow(
      key: ValueKey(listeProduit),
      cells: [
        DataCell(
          Text(pd.designation),
        ),
        DataCell(
          Text(
            pd.prixUnitaire.toString(), //
            // placeholder: false,
            // showEditIcon: true,
            // onTap: () {
            //   print('onTap');
            // },
          ),
        ),
        DataCell(
          Text(
            pd.quantite.toString(),
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
          'Designation',
          style: TextStyle(
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      //Column Contact
      DataColumn(
        label: Text(
          'PU',
          style: TextStyle(
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      //Column Total
      DataColumn(
        label: Text(
          'Quantité',
          style: TextStyle(
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact'),
        centerTitle: true,
      ),
      body: Container(
        child: ListView.builder(
          itemCount: listeProduit.length,
          itemBuilder: (BuildContext context, int index) {
            return DataTable(columns: creationColumn(), rows: [
              DataRow(cells: [
                DataCell(Text(listeProduit[index].designation)),
                DataCell(
                  Text(listeProduit[index].prixUnitaire.toString()),
                ),
                DataCell(Text(listeProduit[index].quantite.toString())),
              ]),
            ]);
          },
          // DataTable(
          // sortColumnIndex: 0,
          // //columns for the headers
          // columns: creationColumn(),
          // //Row for products
          // rows: <DataRow>[
          //   creerUneLigneProduit(),
          // ]
          //<DataRow>[
          // DataRow(
          //   onSelectChanged: (bool etat) {
          //     etat = true;
          //     Navigator.pushNamed(context, '/modifierContact');
          //   },
          //   cells: <DataCell>[
          //     DataCell(
          //       Text('XXX-XXX-XXX'),
          //     ),
          //     DataCell(
          //       Text('100000'),
          //     ),
          //     DataCell(
          //       Text('12'),
          //     ),
          //   ],
          // ),
          // DataRow(
          //   cells: <DataCell>[
          //     DataCell(
          //       Text('YYY-YYYY-YYYY'),
          //     ),
          //     DataCell(
          //       Text('200444'),
          //     ),
          //     DataCell(
          //       Text('3'),
          //     ),
          //   ],
          // ),
          // ],
        ),
      ),
    );
  }
}

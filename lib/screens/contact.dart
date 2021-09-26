import 'package:app_dolibarr/models/produit.dart';
import 'package:app_dolibarr/models/produit_tiers_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Contact extends StatelessWidget {
  int id;
  String designation;
  int quantite;
  double prixUnitaire;
  Produit pdt;

  Contact(this.id);
  // var dbProduit = DbHelperProduit();
  // List<Produit> listeProduit = <Produit>[];
  // void obtenirUnProduit(int id) async {
  //   // List<Produit> maps = await dbProduit.getProduit(id);
  //   // setState(() {
  //   //   maps.forEach((element) {
  //   //     listeProduit.add(element);
  //   //     debugPrint(element.toString());
  //   //   });
  //   // });
  //   pd = await dbProduit.getProduit1(id);
  //   // listeProduit.add(pd);
  //   for (var i = 0; i < listeProduit.length; i++) {
  //     debugPrint(listeProduit[i].designation);
  //   }
  // }

  // DataRow creerUneLigneProduit() {
  //   debugPrint("Contact - Creation ligne executée ");
  //   return DataRow(
  //     key: ValueKey(listeProduit),
  //     cells: [
  //       DataCell(
  //         Text(pd.designation),
  //       ),
  //       DataCell(
  //         Text(
  //           pd.prixUnitaire.toString(), //
  //           // placeholder: false,
  //           // showEditIcon: true,
  //           // onTap: () {
  //           //   print('onTap');
  //           // },
  //         ),
  //       ),
  //       DataCell(
  //         Text(
  //           pd.quantite.toString(),
  //         ),
  //       ),
  //     ],
  //   );
  // }

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

  // void obtenirPdt() async {
  //   pdt = await Provider.of<ProduitTiersModel>(context, listen: false)
  //       .getOneProduit(id);
  // }

  @override
  Widget build(Object context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Contact'),
          centerTitle: true,
        ),
        body: DataTable(columns: creationColumn(), rows: [
          DataRow(cells: [
            DataCell(Text(
                '${Provider.of<ProduitTiersModel>(context, listen: true).getOneProductFromList(id).designation}' ??
                    'Salle')),
            DataCell(Text(
                '${Provider.of<ProduitTiersModel>(context, listen: true).getOneProductFromList(id).prixUnitaire.toString()}' ??
                    '50000')),
            DataCell(Text(
                '${Provider.of<ProduitTiersModel>(context, listen: true).getOneProductFromList(id).quantite.toString()}' ??
                    '2'))
          ])
        ]));
  }
}

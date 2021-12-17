import 'package:app_dolibarr/models/modele_facture_client/product_tiers_model_api.dart';
import 'package:app_dolibarr/models/produit_tiers_model.dart';
import 'package:app_dolibarr/screens/accueil.dart';
import 'package:app_dolibarr/screens/circularprogressIndicator.dart';
import 'package:app_dolibarr/services/auth_service.dart';
import 'package:app_dolibarr/services/product_service_rms_client.dart';
import 'package:app_dolibarr/services/product_service_rms_fournisseur.dart';
import 'package:app_dolibarr/services/tiers_service_rms.dart';
import 'package:app_dolibarr/utilities/shared_prefs.dart';
import 'package:app_dolibarr/utilities/showSnackBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void mettreEnLigne(String identifiant, String motDePasse, String url,
    BuildContext context) async {
  AuthService _authService = AuthService();
  ProductServiceRms _productService = ProductServiceRms();
  TiersServiceRms _tiersServiceRms = TiersServiceRms();
  ProductServiceRmsSupp _productServiceRmsSupp = ProductServiceRmsSupp();

  int socidAchat = 0;
  int socidVente = 0;

  //Authentication and token check if everything is ok return token
  var token = await _authService.loginwithUrl(identifiant, motDePasse, url);
  if (token == 'null') {
    showMySnackbar(context, 'Identifiant ou mot de passe incorrect');
    return;
  } else {
    print('TOKEN DB => $token');
    setValueInPrefs("dbToken", token).then((value) {
      if (token != null) {
        print("Token saved : $token");
      }
    });

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MyCircularProgress(0.4);
    }));

//Fetch data to Database here using the id in order to put give them to the saveProductToAPI function, use the model of provider
    var provider = Provider.of<ProduitTiersModel>(context, listen: false);
    var id = await provider.getIdListFromPreferences("idListAPI");
    print("$id - in after get mettre_en_ligne Function");
    var ptma = await provider.getProduitsAndTiersWithSpecificId(id);

    ProductTiersModelAPI pt = ProductTiersModelAPI.fromMap(ptma);
    print(pt.datecreation);
    //As discovered the ISO time format is accepted
    // print(dateFormattedAPI(pt.datecreation));
    print(pt.label);
    print(pt.paye);
    print(pt.qty);
    print(pt.socid);
    print(pt.subprice);
    print(pt.contact);
    print(pt.type);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MyCircularProgress(0.6);
    }));

//CREATION TIERS SELON LE TYPE FOURNISSEUR OU CLIENT
    //Verification tiers s'il existe ou non
    //Check type
    //TYPE ACHAT
    if (pt.type == "Achat") {
      var mode = 4;
      print('Requete pour achat');
      //verification si client existe ou non dans dolibarr
      var resultCheck = await _tiersServiceRms.verifierClientExiste(
          nomContact: pt.contact, mode: mode);
      // S'il n'existe pas creer le tiers_client dans la base
      if (resultCheck == 404) {
        print('Le fournisseur n\'existe pas ');
        print('Creation du nouveau tiers fournisseur en cours');
        var result =
            await _tiersServiceRms.creationClientNonExisteVente(pt.contact);
        if (result != null) {
          //recuperation id pour utilisation en bas
          print("Id nouveau tiers fournisseur => $result");
          socidAchat = result;
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return MyCircularProgress(0.9);
          }));
          // print('Nouveau tiers crée');
        } else {
          print('Probleme de creation tiers fournisseur');
        }
        //S'il existe recuperrer id
      } else {
        print('LE CLIENT(ACHAT) EXISTE DEJA');
        print("Voici son ID => $resultCheck");
        //assign the id return by the checkclient existes
        socidAchat = int.parse(resultCheck);
      }
      //TYPE VENTE
    } else if (pt.type == "Vente") {
      var mode = 1;
      print("Requete pour vente");
      //verification si client existe ou non dans dolibarr
      var resultCheck = await _tiersServiceRms.verifierClientExiste(
          nomContact: pt.contact, mode: mode);
      //S'il n'existe pas, creer le tiers_client dans la base
      if (resultCheck == 404) {
        print('Le client n\'existe pas ');
        print('Creation du nouveau tiers client en cours');
        var result =
            await _tiersServiceRms.creationClientNonExisteVente(pt.contact);
        if (result != null) {
          //recuperation id pour utilisation en bas
          print("Id nouveau tiers client => $result");
          socidVente = result;
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return MyCircularProgress(0.9);
          }));
          // print('Nouveau tiers crée');
        } else {
          print('Probleme de creation tiers client');
        }
        //S'il existe recuperrer id
      } else {
        print('LE CLIENT(VENTE) EXISTE DEJA');
        print("Voici son id => $resultCheck");
        //assign id return by the checkclient existes
        socidVente = int.parse(resultCheck);
      }
    }
    // check if tiers exists
    // TiersServiceRms tsrms = TiersServiceRms();
    // tsrms.verifierClientExiste(nomClient: pt.contact);
//CREATION DE FACTURE SELON LE TYPE
    if (pt.type == "Vente") {
      // Add product to dolibarr online
      var body = await _productService.saveProductToAPI(
          socid: socidVente,
          datecreation: int.parse(pt.datecreation),
          type: pt.type,
          paye: pt.paye,
          label: pt.label,
          qty: pt.qty.toString(),
          subprice: pt.subprice.toInt());
      print('Facture client enregistré');
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MyCircularProgress(0.9);
      }));
      //Change user status
      await Provider.of<ProduitTiersModel>(context, listen: false)
          .changeUserStatus();
      //Modification etat du status dans la table Tiers de la BDD
      int etatChangeStatus =
          await Provider.of<ProduitTiersModel>(context, listen: false)
              .updateProduitAndTiersStatusTo1(id);
      if (etatChangeStatus != null) {
        print('Etat du status update to 1');
        Provider.of<ProduitTiersModel>(context, listen: false)
            .showMettreEnLigne();
        print('Etat du bouton de mise en ligne set to false');
      } else {
        print('Modification etat status echec');
      }
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MyCircularProgress(1);
      }));
      print('Requete facture client terminée, BYE');
      //update list tiers local
      Provider.of<ProduitTiersModel>(context, listen: false)
          .getListTiersOnlinenoAuth(url);
      //function to show snackbar
      showSnackbar(context, 'Facture fournisseur enregistré en ligne');
      print(body);
      //Redirection vers Accueil
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => AppDolibarr()));
    } else if (pt.type == "Achat") {
      var body = await _productServiceRmsSupp.saveProductToAPISupplier(
          socid: socidAchat,
          datecreation: int.parse(pt.datecreation),
          label: pt.label,
          qty: pt.qty.toString(),
          subprice: pt.subprice.toInt());
      print('Facture fournisseur enregistré');
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MyCircularProgress(0.9);
      }));
      //Change user status
      await Provider.of<ProduitTiersModel>(context, listen: false)
          .changeUserStatus();
      //Modification etat du status dans la table Tiers de la BDD
      int etatChangeStatus =
          await Provider.of<ProduitTiersModel>(context, listen: false)
              .updateProduitAndTiersStatusTo1(id);
      if (etatChangeStatus != null) {
        print('Etat du status update to 1');
        Provider.of<ProduitTiersModel>(context, listen: false)
            .showMettreEnLigne();
        print('Etat du bouton de mise en ligne set to false');
      } else {
        print('Modification etat status echec');
      }
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MyCircularProgress(1);
      }));
      print('Requete facture fournisseur terminée, BYE');
      //update list tiers local
      Provider.of<ProduitTiersModel>(context, listen: false)
          .getListTiersOnlinenoAuth(url);
      //function to show snackbar
      showSnackbar(context, 'Facture fournisseur enregistré en ligne');
      print(body);
      //Redirection vers Accueil
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => AppDolibarr()));
    }
  }
}

void showSnackbar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text('$message'),
    duration: Duration(seconds: 8),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

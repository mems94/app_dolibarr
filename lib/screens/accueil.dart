import 'package:app_dolibarr/screens/liste_produit_envoyer.dart';
import 'package:app_dolibarr/screens/mettre_en_ligne.dart';
import 'package:app_dolibarr/screens/produit_tiers_list.dart';
import 'package:app_dolibarr/services/check_connectivity.dart';
import 'package:app_dolibarr/utilities/mettre_en_ligne_no_auth.dart';
import 'package:app_dolibarr/utilities/showSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:app_dolibarr/models/produit_tiers_model.dart';
import 'package:provider/provider.dart';

class AppDolibarr extends StatefulWidget {
  @override
  _AppDolibarrState createState() => _AppDolibarrState();
}

class _AppDolibarrState extends State<AppDolibarr> with WidgetsBindingObserver {
  ProduitTiersModel notifier;

  Color color;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final notifier = Provider.of<ProduitTiersModel>(context);
    if (this.notifier != notifier) {
      this.notifier = notifier;
      Future.microtask(() {
        notifier.updateProduitTiersListView();
        // notifier.getListTiersOnline();
      });
    }
  }

//Add observer when the app is starting
  @override
  void initState() {
    super.initState();
    changeColor();
    WidgetsBinding.instance.addObserver(this);
  }

//Useful action when the app is disposed
  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

//Action to do when app closed or inactive
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      var provider = Provider.of<ProduitTiersModel>(context, listen: false);
      //Delete saved token during fisrt connexion to dolibarr
      provider.deleteSavedToken();
      print('Token deleted');
      //Changing the user state to disconnected, put bool connected to false
      provider.logoutUser();
      print('User log out');
    }
  }

  //Change color of the connected or not button
  void changeColor() async {
    color = await Provider.of<ProduitTiersModel>(context, listen: false)
        .statusColor();
    print("status color (Accueil) : $color");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: cust
      // omDrawer(context),
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(
                Icons.brightness_1,
                color: color,
                size: 18.0,
              ),
              onPressed: () {
                print('Status button pressed');
              }),
          IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
                size: 30.0,
              ),
              onPressed: () {
                Provider.of<ProduitTiersModel>(context, listen: false)
                    .actualisation();
                Navigator.popAndPushNamed(context, '/dolibarr');
              })
        ],
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ListeProduitEnvoyer()));
          },
          child: Icon(
            Icons.article_outlined,
            color: Colors.white,
            size: 30.0,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Mes produits',
          textAlign: TextAlign.center,
        ),
      ),

      body: ProduitTiersList(), // ProduitTiersList(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        children: [
          Visibility(
            visible: Provider.of<ProduitTiersModel>(context, listen: true)
                .stateButtonNouveau,
            child: Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 30.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // primary: Colors.green,
                    padding: EdgeInsets.all(10.0),
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () =>
                      Navigator.pushNamed(context, '/nouveautiers'),
                  child: Text(
                    'Nouveau',
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.0),
          ),
          Visibility(
            visible: Provider.of<ProduitTiersModel>(context, listen: true)
                .stateButtonMettreAJour,
            child: Expanded(
              child: Container(
                padding: EdgeInsets.only(right: 30.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // primary: Colors.green,
                    padding: EdgeInsets.all(10.0),
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    //if user status true, no need to authenticate ifelse must authenticate
                    //checking connectivity
                    bool connectivity = await checkConnectivity();
                    //checking user status
                    bool userStatus = await Provider.of<ProduitTiersModel>(
                            context,
                            listen: false)
                        .checkUserStatus();
                    print("Status utilisateur (button) : $userStatus");
                    //check user Status
                    if (userStatus) {
                      //check connectivity
                      if (connectivity) {
                        //send product online
                        mettreEnLigneNoAuth(context);
                        int changed = await Provider.of<ProduitTiersModel>(
                                context,
                                listen: false)
                            .changeUserStatus();
                        print("Etat Status => $changed");
                      } else {
                        //SnackBar for no internet access
                        showMySnackbar(
                            context, 'Vous n\'avez pas d\'accces internet');
                      }
                      //if user status is false (not connected)
                    } else {
                      //go to the authentication page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MettreEnLigne();
                          },
                        ),
                      );
                    }
                  },
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

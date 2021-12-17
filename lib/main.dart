import 'dart:io';
import 'package:app_dolibarr/models/produit_tiers_model.dart';
import 'package:app_dolibarr/screens/accueil.dart';
import 'package:app_dolibarr/screens/nouveau_tiers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

//Annulation de verification du certificat pour emepecher des erreurs de certificat,
// A utiliser on test-purpose only, not in production
//Besoin de verifier le probleme de certificat avec dolibarr ?? ou apache ??
//Puisque le probleme vient de là
class MyHttpoverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future main() async {
  HttpOverrides.global = new MyHttpoverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitUp]);
  runApp(MySplashScreen()
      // ChangeNotifierProvider(
      //   create: (BuildContext context) => ProduitTiersModel(),
      //   child: SplashScreen(),
      // ),
      );
}

// class MainViewModelRoel extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: LoginView(),
//     );
//   }
// }

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ProduitTiersModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bienvenue dans Dolibarr',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Colors.blue,
            buttonColor: Colors.blue,
            secondaryHeaderColor: Colors.blue,
            accentColor: Colors.blue,
            iconTheme: IconThemeData(color: Colors.blue)),
        // primaryIconTheme: IconThemeData(color: Colors.blue)),
        home: AppDolibarr(),
        // initialRoute: '/',
        routes: {
          '/splashscreen': (context) => SplashScreen(),
          '/dolibarr': (context) => AppDolibarr(),
          '/nouveautiers': (context) => NouveauTiers(),
          //   // '/contact': (context) => Contact(),
          //   // '/mettreEnLigne': (context) => MettreEnLigne(),
          //   // '/modifierContact': (context) => ModifierContact(),
        },
      ),
    );
  }
}

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(
        photoSize: 100.0,
        loadingText: Text(
          'Copyright - MADA-Digital ',
          style: TextStyle(fontSize: 11.0),
        ),
        seconds: 6,
        navigateAfterSeconds: App(),
        image: Image(
          fit: BoxFit.cover,
          image: AssetImage('images/logovahatra.jpg'),
        ),
        title: Text(
          'Client Dolibarr - VAHATRA',
          style: TextStyle(fontSize: 20.0, color: Colors.blue),
        ),
        backgroundColor: Colors.white,
        loaderColor: Colors.blue,
      ),
    );
  }
}

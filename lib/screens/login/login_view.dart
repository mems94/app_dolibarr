import 'package:app_dolibarr/screens/login/login_viewmodel.dart';
import 'package:app_dolibarr/utilities/view_helper.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (
        BuildContext context,
        LoginViewModel model,
        Widget child,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Connexion'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Identifiant'),
                    onChanged: (String value) => model.setUsername(value),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Mot de passe'),
                    obscureText: true,
                    onChanged: (String value) => model.setPassword(value),
                  ),
                ),
                spacing(vertical: 16),
                Container(
                  margin: EdgeInsets.only(top: 16, left: 24, right: 24),
                  height: 56,
                  width: width(context),
                  child: ElevatedButton(
                    onPressed: () => model.login(context),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(64))),
                    child: Text(
                      'Se connecter',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

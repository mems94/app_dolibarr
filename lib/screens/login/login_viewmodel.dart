import 'package:app_dolibarr/screens/main/main_view.dart';
import 'package:app_dolibarr/services/auth_service.dart';
import 'package:app_dolibarr/utilities/navigation_helper.dart';
import 'package:app_dolibarr/utilities/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel {
  AuthService _authService = AuthService();
  String _username;
  String _password;

  String get username => _username;
  String get password => _password;

  void setUsername(String value) {
    _username = value;
  }

  void setPassword(String value) {
    _password = value;
  }

  void login(BuildContext context) {
    _authService.login(_username, _password).then((token) {
      print('TOKEN DB => $token');
      setValueInPrefs("dbToken", token).then((value) {
        goto(context, MainView());
      });
    });
  }
}

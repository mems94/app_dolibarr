import 'package:app_dolibarr/screens/login/login_view.dart';
import 'package:app_dolibarr/utilities/navigation_helper.dart';
import 'package:flutter/material.dart';

Drawer customDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('Menu'),
        ),
        ListTile(
          title: const Text('Hors ligne'),
          onTap: () {},
        ),
        ListTile(
          title: const Text('En ligne'),
          onTap: () {
            goto(context, LoginView());
          },
        ),
      ],
    ),
  );
}

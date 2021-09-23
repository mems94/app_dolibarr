import 'package:app_dolibarr/screens/main/main_viewmodel.dart';
import 'package:app_dolibarr/screens/products/product_view.dart';
import 'package:app_dolibarr/utilities/navigation_helper.dart';
import 'package:app_dolibarr/utilities/view_helper.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MainView extends StatefulWidget {
  const MainView({Key key}) : super(key: key);
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => MainViewModel(),
      builder: (
        BuildContext context,
        MainViewModel model,
        Widget child,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Menu'),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 16, left: 24, right: 24),
                  height: 56,
                  width: width(context),
                  child: ElevatedButton(
                    onPressed: () => {goto(context, ProductView())},
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(64))),
                    child: Text(
                      'Ajouter produit',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16, left: 24, right: 24),
                  height: 56,
                  width: width(context),
                  child: ElevatedButton(
                    onPressed: () => {},
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(64))),
                    child: Text(
                      'Ajouter tiers',
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

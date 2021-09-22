import 'package:app_dolibarr/screens/products/product_viewmodel.dart';
import 'package:app_dolibarr/utilities/view_helper.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProductView extends StatelessWidget {
  const ProductView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductViewModel>.reactive(
      viewModelBuilder: () => ProductViewModel(),
      builder: (
        BuildContext context,
        ProductViewModel model,
        Widget child,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Ajouter produit'),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Ref'),
                    onChanged: (String value) => model.setRef(value),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Libelle'),
                    onChanged: (String value) => model.setLabel(value),
                  ),
                ),
                spacing(vertical: 16),
                Container(
                  margin: EdgeInsets.only(top: 16, left: 24, right: 24),
                  height: 56,
                  width: width(context),
                  child: ElevatedButton(
                    onPressed: () => model.saveProduct(),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(64))),
                    child: Text(
                      'Ajouter',
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

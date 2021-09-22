import 'package:app_dolibarr/components/buildTextField.dart';
import 'package:flutter/material.dart';

class ModifierContact extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ModifierContactState();
  }
}

class ModifierContactState extends State<ModifierContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier Contact'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            buildTextField("Designation", Icons.format_quote, null),
            buildTextField("Quantité", Icons.batch_prediction_rounded, null),
            buildTextField("PU", Icons.attach_money, null),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/'),
                child: Text('Enregistrer'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

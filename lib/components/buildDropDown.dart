// import 'package:flutter/material.dart';

// Widget buildDropDownButton(String dropdownValue, ) {
//   // String dropdownValue = 'Achat';
//   return DropdownButton<String>(
//     value: dropdownValue,
//     icon: const Icon(Icons.arrow_downward),
//     iconSize: 24,
//     elevation: 16,
//     style: const TextStyle(color: Colors.deepPurple),
//     underline: Container(
//       height: 2,
//       color: Colors.deepPurpleAccent,
//     ),
//     onChanged: (String? newValue) {
//       setState(() {
//         dropdownValue = newValue!;
//       });
//     },
//     items: <String>['Achat', 'Vente']
//         .map<DropdownMenuItem<String>>((String value) {
//       return DropdownMenuItem<String>(
//         value: value,
//         child: Text(value),
//       );
//     }).toList(),
//   );
// }

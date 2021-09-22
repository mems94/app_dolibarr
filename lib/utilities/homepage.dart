// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'userDetails.dart';

// class HomePage extends StatefulWidget {
//   HomePage({Key key}) : super(key: key);

//   @override
//   _HomePageState createState() => new _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<UserDetails> _searchResult = [];
//   List<UserDetails> _userDetails = [];
//   TextEditingController controller = new TextEditingController();

//   // Get json result and convert it to model. Then add
//   Future<Null> getUserDetails() async {
//     final response = await http.get(url);
//     final responseJson = json.decode(response.body);

//     setState(() {
//       for (Map user in responseJson) {
//         _userDetails.add(UserDetails.fromJson(user));
//       }
//     });
//   }

//   @override
//   void initState() {
//     super.initState();

//     getUserDetails();
//   }

//   Widget _buildUsersList() {
//     return new ListView.builder(
//       itemCount: _userDetails.length,
//       itemBuilder: (context, index) {
//         return new Card(
//           child: new ListTile(
//             leading: new CircleAvatar(
//               backgroundImage: new NetworkImage(
//                 _userDetails[index].profileUrl,
//               ),
//             ),
//             title: new Text(_userDetails[index].firstName +
//                 ' ' +
//                 _userDetails[index].lastName),
//             onTap: () {
//               print('Index User list : $index');
//             },
//           ),
//           margin: const EdgeInsets.all(0.0),
//         );
//       },
//     );
//   }

//   Widget _buildSearchResults() {
//     return new ListView.builder(
//       itemCount: _searchResult.length,
//       itemBuilder: (context, i) {
//         return new Card(
//           child: new ListTile(
//             leading: new CircleAvatar(
//               backgroundImage: new NetworkImage(
//                 _searchResult[i].profileUrl,
//               ),
//             ),
//             title: new Text(
//                 _searchResult[i].firstName + ' ' + _searchResult[i].lastName),
//             onTap: () {
//               print('Index Search result : $i');
//             },
//           ),
//           margin: const EdgeInsets.all(0.0),
//         );
//       },
//     );
//   }

//   Widget _buildSearchBox() {
//     return new Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: new Card(
//         child: new ListTile(
//           leading: new Icon(Icons.search),
//           title: new TextField(
//             controller: controller,
//             decoration: new InputDecoration(
//                 hintText: 'Search', border: InputBorder.none),
//             onChanged: onSearchTextChanged,
//           ),
//           trailing: new IconButton(
//             icon: new Icon(Icons.cancel),
//             onPressed: () {
//               controller.clear();
//               onSearchTextChanged('');
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBody() {
//     return new Column(
//       children: <Widget>[
//         new Container(
//             color: Theme.of(context).primaryColor, child: _buildSearchBox()),
//         new Expanded(
//             child: _searchResult.length != 0 || controller.text.isNotEmpty
//                 ? _buildSearchResults()
//                 : _buildUsersList()),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text('Home'),
//         elevation: 0.0,
//       ),
//       body: _buildBody(),
//       resizeToAvoidBottomPadding: true,
//     );
//   }

//   onSearchTextChanged(String text) async {
//     _searchResult.clear();
//     if (text.isEmpty) {
//       setState(() {});
//       return;
//     }

//     _userDetails.forEach((userDetail) {
//       if (userDetail.firstName.toLowerCase().contains(text.toLowerCase()) ||
//           userDetail.lastName.toLowerCase().contains(text.toLowerCase()))
//         _searchResult.add(userDetail);
//     });

//     setState(() {});
//   }
// }

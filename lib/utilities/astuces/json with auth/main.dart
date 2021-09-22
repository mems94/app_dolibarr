import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response =
  await client.get('https://jsonplaceholder.typicode.com/posts');

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

class Photo {
  final int userId;
  final int id;
  final String title;
  final String body;

  Photo({this.userId, this.id, this.title, this.body});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'JSON Parse';

    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<Photo>>(
        future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? PhotosList(photos: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  final List<Photo> photos;

  PhotosList({Key key, this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: photos.length,
        padding: new EdgeInsets.all(16.0),
        itemBuilder: (context,index){

          if(index.isOdd) return new Divider();
              final indexReduce = index ~/ 2;

          return new ListTile(
              title: new Text("${photos[indexReduce].title}",
                 style: new TextStyle(fontSize: 14.0),),

              subtitle: new Text("${photos[indexReduce].body}",
                  style: new TextStyle(color: Colors.grey,
                        fontStyle: FontStyle.italic
                  ),),

            leading: new CircleAvatar(
              backgroundColor: Colors.greenAccent,
              child: new Text("${photos[indexReduce].title[0].toString().toUpperCase()}",
                  style: new TextStyle(fontSize: 19.0,
                  color: Colors.deepOrange
                  ) ,
              ),
            ),

            onTap: (){_showOnTapMessage(context,"${photos[indexReduce].title}");},
          );
        });
  }
}

void _showOnTapMessage(BuildContext context, String message){
  var alert = new AlertDialog(
    title: new Text('App'),
    content: new Text(message),
    actions: <Widget>[
      new FlatButton(
          onPressed: (){Navigator.pop(context);},
          child: new Text("OK"))
    ],
  );
  
  showDialog(
      context: context,
      builder: (BuildContext context){
                  return Center(child: alert);
      });

}

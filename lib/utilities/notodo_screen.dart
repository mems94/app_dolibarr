// import 'package:flutter/material.dart';
// import 'package:notodo_app/model/nodo_item.dart';
// import 'package:notodo_app/util/date_formatted.dart';
// import 'package:notodo_app/util/dbHelper.dart';
// import 'package:sqflite/sqflite.dart';

// class NotoDoScreen extends StatefulWidget {
//   @override
//   _NotoDoScreenState createState() => _NotoDoScreenState();
// }

// class _NotoDoScreenState extends State<NotoDoScreen> {

//   final TextEditingController _textEditingController = new TextEditingController();

//   var db = new DbHelper();
//   final List<NoDoItem> _itemList = <NoDoItem>[];

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _readNoDoList();
//   }

//   void handleSubmitted(String text) async{

//     _textEditingController.clear();

//     NoDoItem noDoItem = new NoDoItem(text, dateFormatted());

//      int savedItemId = await db.save(noDoItem);

//      NoDoItem addedItem = await db.getItem(savedItemId);

//      setState(() {
//        _itemList.add(addedItem);
//        debugPrint("Item added");
//      });

//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black87,
//       body: Column(
//        children: <Widget>[
//          new Flexible(
//              child: new ListView.builder(
//                padding: const EdgeInsets.all(10.0),
//                  //reverse: false,
//                  itemCount: _itemList.length,
//                  itemBuilder: (context,int index){
//                    return new Card(
//                      color: Colors.white10,
//                       child: new ListTile(
//                         title: _itemList[index],
//                         onLongPress: () => _updateItem(_itemList[index], index) ,
//                         trailing: new Listener(
//                           key: new Key(_itemList[index].itemName),
//                           child: new Icon(Icons.remove_circle,
//                             color: Colors.redAccent,
//                           ),
//                           onPointerDown: (pointerEvent)=> _deleteItem(_itemList[index].id, index),

//                         ),
//                       ),
//                    );
//                  }
//              ),
//          ),
//          new Divider(
//            height: 1.0,
//          )
//        ],
//       ),
//       floatingActionButton: new FloatingActionButton(
//           tooltip: "Addd Item",
//           backgroundColor: Colors.redAccent,
//           onPressed: _showFormDialog,
//           child: new ListTile(
//             title: new Icon(Icons.add),
//           ),

//       ),
//     );
//   }

//   void _showFormDialog() {
//     var alert = new AlertDialog(
//        content: new Row(
//          children: <Widget>[
//            new Expanded(
//                child: new TextField(
//                  controller: _textEditingController,
//                  autofocus: true,
//                  decoration: new InputDecoration(
//                    labelText: "Item",
//                    hintText: "eg. Don't stuff",
//                    icon: new Icon(Icons.note_add)
//                  ),
//                )
//            )
//          ],
//        ),
//       actions: <Widget>[
//         new FlatButton(
//             onPressed: (){
//                handleSubmitted(_textEditingController.text);
//               _textEditingController.clear();
//               Navigator.pop(context);
//               },
//             child: Text("Save")),
//         new FlatButton(
//             onPressed: ()=> Navigator.pop(context),
//             child: new Text("Cancel"))
//       ],
//     );

//     showDialog(context: context,
//           builder: (_){
//               return alert;
//           }
//     );
//   }

//   _readNoDoList() async {
//      List items = await db.getItems();
//      items.forEach((item){
//       // NoDoItem noDoItem = NoDoItem.fromMap(item);
//        setState(() {
//          _itemList.add(NoDoItem.map(item));
//        });
//        //print(item.itemName);
//       // print(noDoItem.itemName);
//      });
//   }

//   _deleteItem(int id, int index) async{
//     debugPrint("Item deleted");
//     await db.delete(id);
//     setState(() {
//       _itemList.removeAt(index);
//     });
//   }

//   _updateItem(NoDoItem item, int index) {

//     var alert = new AlertDialog(
//       title: new Text("Update"),
//       content: new Row(
//         children: <Widget>[
//           new Expanded(
//               child: new TextField(
//                 controller: _textEditingController,
//                 autofocus: true,
//                 decoration: new InputDecoration(
//                   labelText: "Item",
//                   hintText: "eg. Don't stuff",
//                   icon: new Icon(Icons.update)
//                 ),
//               ),
//           )
//         ],
//       ),
//       actions: <Widget>[
//         new FlatButton(
//             onPressed: () async{
//                 NoDoItem newUpdatenoDoItem = NoDoItem.fromMap(
//                   {
//                     "itemName" : _textEditingController.text,
//                     "dateCreated" : dateFormatted(),
//                     "id" : item.id
//                   });

//                 _handleSubmittedUpdate(index, item);
//                 await db.update(newUpdatenoDoItem);
//                 setState(() {
//                   _readNoDoList();
//                 });
//                 Navigator.pop(context);
//                 _textEditingController.clear();
//             },
//             child: new Text("UPDATE")),
//         new FlatButton(
//             onPressed: ()=> Navigator.pop(context),
//             child: new Text("CANCEL"))
//       ],
//     );

//     showDialog(
//         context: context,
//         builder: (_){

//           return alert;

//         }
//     );
//   }

//   void _handleSubmittedUpdate(int index, NoDoItem item) {
//           setState(() {
//             _itemList.removeWhere((element) {
//               _itemList[index].itemName == item.itemName;
//             // ignore: missing_return
//             });
//           });

//   }
// }

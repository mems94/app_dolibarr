import 'dart:async';
import 'dart:io' as io;
import 'package:app_dolibarr/models/tiers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Produit(this.id, this.idTiers, this.designation, this.prixUnitaire,
//       this.quantite);

class DbHelperTiers {
  static Database _db;
  static const String ID = "id";
  static const String TYPE = 'type';
  static const String CONTACT = 'contact';
  static const String DATE = 'date';
  static const String PAIEMENT = 'paiement';
  static const String TABLE = 'Tiers';
  static const String DB_NAME = 'Tiers.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory getDocuments = await getApplicationDocumentsDirectory();
    String path = join(getDocuments.path, DB_NAME);
    var db = openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY,$TYPE TEXT, $CONTACT TEXT, $DATE TEXT, $PAIEMENT TEXT)");
  }

  Future<Tiers> save(Tiers tiers) async {
    var dbClient = await db;

    tiers.id = await dbClient.insert(TABLE, tiers.toMap());

    return tiers;

    /*await dbClient.transaction((txn) async {
      var query = "INSERT INTO $TABLE ( $NAME ) VALUES('" + employee.name + "')";
      return await txn.rawInsert(query);
    });*/
  }

  Future<List<Tiers>> getTiers() async {
    var dbClient = await db;
    List<Map> maps = await dbClient
        .query(TABLE, columns: [ID, TYPE, CONTACT, DATE, PAIEMENT]);
    // List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");

    List<Tiers> tierses = [];

    if (tierses.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        tierses.add(Tiers.fromMap(maps[i]));
      }
    }

    return tierses;
  }

  // Future<int> delete(int id) async {
  //   var dbClient = await db;
  //   return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs:[id]);
  // }

  // Future<int> update(Employee employee) async{
  //   var dbClient = await db;
  //   return dbClient.update(TABLE, employee.toMap(),
  //       where: '$ID=?',
  //       whereArgs: [employee.id]);
  // }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}

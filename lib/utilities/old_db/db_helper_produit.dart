import 'dart:async';
import 'dart:io' as io;
import 'package:app_dolibarr/models/produit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Produit(this.id, this.idTiers, this.designation, this.prixUnitaire,
//       this.quantite);

class DbHelperProduit {
  static Database _db;
  static const String ID = "id";
  static const String ID_TIERS = "idTiers";
  static const String DESIGNATION = 'designation';
  static const String PRIX_UNITAIRE = 'prixUnitaire';
  static const String QUANTITE = 'quantite';
  static const String CONTACT = 'contact';
  static const String DATE = 'date';
  static const String TABLE = 'Produit';
  static const String TABLE_TIERS = 'Tiers';
  static const String DB_NAME = 'Produit.db';

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
        "CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY,$ID_TIERS INTEGER,$DESIGNATION TEXT, $PRIX_UNITAIRE REAL,$QUANTITE INTEGER)");
  }

  Future<Produit> save(Produit produit) async {
    var dbClient = await db;

    produit.id = await dbClient.insert(TABLE, produit.toMap());

    return produit;

    /*await dbClient.transaction((txn) async {
      var query = "INSERT INTO $TABLE ( $NAME ) VALUES('" + employee.name + "')";
      return await txn.rawInsert(query);
    });*/
  }

  Future<List<Produit>> getProduits() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE,
        columns: [ID, ID_TIERS, DESIGNATION, PRIX_UNITAIRE, QUANTITE]);
    // List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");

    List<Produit> produits = [];

    if (produits.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        produits.add(Produit.fromMap(maps[i]));
      }
    }

    return produits;
  }

//get liste des produits de la combinaison
  Future<List<Map>> getProduitsAndTiers() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery(
        "SELECT $CONTACT, $DATE, $PRIX_UNITAIRE, $QUANTITE FROM $TABLE_TIERS INNER JOIN $TABLE ON $ID = $ID_TIERS");
    // List<Map> produitTiers = [];
    return maps;
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

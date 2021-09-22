class Produit {
  int id;
  int idTiers;
  String designation;
  double prixUnitaire;
  int quantite;

  Produit(this.idTiers, this.designation, this.prixUnitaire, this.quantite);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'idTiers': idTiers,
      'designation': designation,
      'prixUnitaire': prixUnitaire,
      'quantite': quantite
    };

    return map;
  }

  Produit.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    idTiers = map['idTiers'];
    designation = map['designation'];
    prixUnitaire = map['prixUnitaire'];
    quantite = map['quantite'];
  }

  Produit.map(dynamic obj) {
    this.id = obj['id'];
    this.idTiers = obj['idTiers'];
    this.designation = obj['designation'];
    this.prixUnitaire = obj['prixUnitaire'];
    this.quantite = obj['quantite'];
  }

  int get getId => id;
  String get getDesignation => designation;
  double get getPrixUnitaire => prixUnitaire;
  int get getQuantite => quantite;
}

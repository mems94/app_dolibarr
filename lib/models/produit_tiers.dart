class ProduitTiers {
  int id;
  int idTiers;
  String designation;
  String contact;
  String date;
  double prixUnitaire;
  int quantite;
  int status = 0;

  ProduitTiers(this.id, int idTiers, this.designation, this.contact, this.date,
      this.prixUnitaire, this.quantite);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'idTiers': idTiers,
      'designation': designation,
      'contact': contact,
      'date': date,
      'prixUnitaire': prixUnitaire,
      'quantite': quantite,
      'status': status
    };

    return map;
  }

  ProduitTiers.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    idTiers = map['idTiers'];
    designation = map['designation'];
    contact = map['contact'];
    date = map['date'];
    prixUnitaire = map['prixUnitaire'];
    quantite = map['quantite'];
    status = map['status'];
  }
}

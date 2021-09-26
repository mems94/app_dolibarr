class ProduitTiers {
  int id;
  String designation;
  String contact;
  String date;
  double prixUnitaire;
  int quantite;

  ProduitTiers(this.id, this.designation, this.contact, this.date,
      this.prixUnitaire, this.quantite);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'designation': designation,
      'contact': contact,
      'date': date,
      'prixUnitaire': prixUnitaire,
      'quantite': quantite
    };

    return map;
  }

  ProduitTiers.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    designation = map['designation'];
    contact = map['contact'];
    date = map['date'];
    prixUnitaire = map['prixUnitaire'];
    quantite = map['quantite'];
  }
}

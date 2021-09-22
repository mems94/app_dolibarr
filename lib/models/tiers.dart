class Tiers {
  int id;
  String type;
  String contact;
  String date;
  String paiement;

  Tiers(this.type, this.contact, this.date, this.paiement);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'type': type,
      'contact': contact,
      'date': date,
      'paiement': paiement
    };

    return map;
  }

  Tiers.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    type = map['type'];
    contact = map['contact'];
    date = map['date'];
    paiement = map['paiement'];
  }
}

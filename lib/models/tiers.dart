class Tiers {
  int id;
  String type;
  String contact;
  String date;
  String paiement;
  int status = 0;

  Tiers(this.type, this.contact, this.date, this.paiement, this.status);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'type': type,
      'contact': contact,
      'date': date,
      'paiement': paiement,
      'status': status
    };

    return map;
  }

  Tiers.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    type = map['type'];
    contact = map['contact'];
    date = map['date'];
    paiement = map['paiement'];
    status = map['status'];
  }
}

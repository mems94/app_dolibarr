class ProductTiersModelAPI {
  int socid;
  String datecreation;
  String type;
  String contact;
  String paye;
  String label;
  int qty;
  double subprice;

  ProductTiersModelAPI(
      {this.socid,
      this.datecreation,
      this.type,
      this.paye,
      this.label,
      this.qty,
      this.subprice});

  ProductTiersModelAPI.fromMap(Map<String, dynamic> map) {
    socid = map['id'];
    datecreation = map['date'];
    type = map['type'];
    contact = map['contact'];
    paye = map['paiement'];
    label = map['designation'];
    qty = map['quantite'];
    subprice = map['prixUnitaire'];
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     "socid": this.socid,
  //     "date_creation": this.datecreation,
  //     "type": this.type,
  //     "paye": this.paye,
  //     "lines": [
  //       {
  //         "label": this.label,
  //         "qty": this.qty,
  //         "subprice": this.subprice,
  //       }
  //     ]
  //   };
  // }
}

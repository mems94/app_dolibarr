class ModeleFactureFournisseur {
  String refSupplier;
  String socid;
  int date;
  List<Lines> lines;

  ModeleFactureFournisseur(
      {this.refSupplier, this.socid, this.date, this.lines});

  ModeleFactureFournisseur.fromJson(Map<String, dynamic> json) {
    refSupplier = json['ref_supplier'];
    socid = json['socid'];
    date = json['date'];
    if (json['lines'] != null) {
      lines = new List<Lines>();
      json['lines'].forEach((v) {
        lines.add(new Lines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ref_supplier'] = this.refSupplier;
    data['socid'] = this.socid;
    data['date'] = this.date;
    if (this.lines != null) {
      data['lines'] = this.lines.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lines {
  String description;
  String qty;
  String multicurrencySubprice;

  Lines({this.description, this.qty, this.multicurrencySubprice});

  Lines.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    qty = json['qty'];
    multicurrencySubprice = json['multicurrency_subprice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['qty'] = this.qty;
    data['multicurrency_subprice'] = this.multicurrencySubprice;
    return data;
  }
}

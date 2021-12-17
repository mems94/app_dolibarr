class DolibarrModel {
  int socid;
  int dateCreation;
  String type;
  String paye;
  List<Lines> lines;

  DolibarrModel(
      {this.socid, this.dateCreation, this.type, this.paye, this.lines});

  DolibarrModel.fromJson(Map<String, dynamic> json) {
    socid = json['socid'];
    dateCreation = json['date_creation'];
    type = json['type'];
    paye = json['paye'];
    if (json['lines'] != null) {
      lines = new List<Lines>();
      json['lines'].forEach((v) {
        lines.add(new Lines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['socid'] = this.socid;
    data['date_creation'] = this.dateCreation;
    data['type'] = this.type;
    data['paye'] = this.paye;
    if (this.lines != null) {
      data['lines'] = this.lines.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lines {
  String label;
  String qty;
  int subprice;

  Lines({this.label, this.qty, this.subprice});

  Lines.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    qty = json['qty'];
    subprice = json['subprice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['qty'] = this.qty;
    data['subprice'] = this.subprice;
    return data;
  }
}

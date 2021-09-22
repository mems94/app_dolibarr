class Product {
  String label;
  String ref;

  Product({this.label, this.ref});

  Map<String, dynamic> toJson() {
    return {"ref": this.ref, "label": this.label};
  }
}

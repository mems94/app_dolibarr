class Product {
  String label;
  String ref;
  String price;

  Product({this.label, this.ref, this.price});

  Map<String, dynamic> toJson() {
    return {"ref": this.ref, "label": this.label, "price": this.price};
  }
}

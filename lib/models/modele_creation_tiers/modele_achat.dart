class ModeleAchat {
  String name;
  String fournisseur;
  String codeFournisseur;

  ModeleAchat({this.name, this.fournisseur, this.codeFournisseur});

  ModeleAchat.fromJson(Map<String, dynamic> json) {
    name = json['name '];
    fournisseur = json['fournisseur'];
    codeFournisseur = json['code_fournisseur'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name '] = this.name;
    data['fournisseur'] = this.fournisseur;
    data['code_fournisseur'] = this.codeFournisseur;
    return data;
  }
}

class ModeleVente {
  String name;
  String client;
  String codeClient;

  ModeleVente({this.name, this.client, this.codeClient});

  ModeleVente.fromJson(Map<String, dynamic> json) {
    name = json['name '];
    client = json['client'];
    codeClient = json['code_client'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name '] = this.name;
    data['client'] = this.client;
    data['code_client'] = this.codeClient;
    return data;
  }
}

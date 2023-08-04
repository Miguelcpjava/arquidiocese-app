import 'package:arquidiocese_maceio_app/src/models/Paroquia.dart';

class Bairro {
  String? nome;
  Paroquia? paroquia;

  Bairro({this.nome, this.paroquia});

  Bairro.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    paroquia = json['paroquia'] != null
        ? new Paroquia.fromJson(json['paroquia'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    if (this.paroquia != null) {
      data['paroquia'] = this.paroquia!.toJson();
    }
    return data;
  }
}

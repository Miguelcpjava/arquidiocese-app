import 'package:arquidiocese_maceio_app/src/models/Bairro.dart';

class Cidade {
  String? nome;
  String? padroeiro;
  List<Bairro>? bairro;

  Cidade({this.nome, this.padroeiro, this.bairro});

  Cidade.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    padroeiro = json['padroeiro'];
    if (json['bairro'] != null) {
      bairro = <Bairro>[];
      json['bairro'].forEach((v) {
        bairro!.add(new Bairro.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['padroeiro'] = this.padroeiro;
    if (this.bairro != null) {
      data['bairro'] = this.bairro!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

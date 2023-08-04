import 'package:arquidiocese_maceio_app/src/models/Igreja.dart';

class Paroquia {
  String? nome;
  String? whatsapp;
  String? telefone;
  String? youtube;
  String? instagram;
  int? fundacao;
  List<Igreja>? igreja;

  Paroquia(
      {this.nome,
      this.whatsapp,
      this.telefone,
      this.youtube,
      this.instagram,
      this.fundacao,
      this.igreja});

  Paroquia.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    whatsapp = json['whatsapp'];
    telefone = json['telefone'];
    youtube = json['youtube'];
    instagram = json['instagram'];
    fundacao = json['fundacao'];
    if (json['igreja'] != null) {
      igreja = <Igreja>[];
      json['igreja'].forEach((v) {
        igreja!.add(new Igreja.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['whatsapp'] = this.whatsapp;
    data['telefone'] = this.telefone;
    data['youtube'] = this.youtube;
    data['instagram'] = this.instagram;
    data['fundacao'] = this.fundacao;
    if (this.igreja != null) {
      data['igreja'] = this.igreja!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

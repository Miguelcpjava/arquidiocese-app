import 'package:arquidiocese_maceio_app/src/models/Missa.dart';

class Igreja {
  String? homenageado;
  String? vigario;
  String? festa;
  String? historia;
  String? endereco;
  Missa? missa;

  Igreja(
      {this.homenageado,
      this.vigario,
      this.festa,
      this.historia,
      this.missa,
      this.endereco});

  Igreja.fromJson(Map<String, dynamic> json) {
    homenageado = json['homenageado'];
    vigario = json['vigario'];
    festa = json['festa'];
    historia = json['historia'];
    endereco = json['endereco'];
    missa = json['missa'] != null ? new Missa.fromJson(json['missa']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['homenageado'] = this.homenageado;
    data['vigario'] = this.vigario;
    data['festa'] = this.festa;
    data['historia'] = this.historia;
    data['endereco'] = this.endereco;
    if (this.missa != null) {
      data['missa'] = this.missa!.toJson();
    }
    return data;
  }
}

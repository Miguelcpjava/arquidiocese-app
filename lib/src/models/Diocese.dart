import 'package:arquidiocese_maceio_app/src/models/Cidade.dart';

class Diocese {
  String? diocese;
  Cidade? cidade;

  Diocese({this.diocese, this.cidade});

  Diocese.fromJson(Map<String, dynamic> json) {
    diocese = json['diocese'];
    cidade =
        json['cidade'] != null ? new Cidade.fromJson(json['cidade']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['diocese'] = this.diocese;
    if (this.cidade != null) {
      data['cidade'] = this.cidade!.toJson();
    }
    return data;
  }
}

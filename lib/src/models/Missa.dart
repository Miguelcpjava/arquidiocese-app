class Missa {
  String? segunda;
  String? terca;
  String? quarta;
  String? quinta;
  String? sexta;
  String? sabado;
  String? domingo;

  Missa(
      {this.segunda,
      this.terca,
      this.quarta,
      this.quinta,
      this.sexta,
      this.sabado,
      this.domingo});

  Missa.fromJson(Map<String, dynamic> json) {
    segunda = json['segunda'];
    terca = json['terca'];
    quarta = json['quarta'];
    quinta = json['quinta'];
    sexta = json['sexta'];
    sabado = json['sabado'];
    domingo = json['domingo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['segunda'] = this.segunda;
    data['terca'] = this.terca;
    data['quarta'] = this.quarta;
    data['quinta'] = this.quinta;
    data['sexta'] = this.sexta;
    data['sabado'] = this.sabado;
    data['domingo'] = this.domingo;
    return data;
  }
}

class PodCast {
  String? titulo;
  String? data;
  String? url;
  int? ano;

  PodCast(
      {required this.url,
      required this.data,
      required this.titulo,
      required this.ano});

  PodCast.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    titulo = json['titulo'];
    ano = json['ano'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['titulo'] = this.titulo;
    data['ano'] = this.ano;
    data['url'] = this.url;
    return data;
  }
}

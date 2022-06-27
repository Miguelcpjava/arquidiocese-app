class Noticia {
  var image;
  String? title;
  String? subtitle;
  var date;
  String? category;
  var _icon; //Esse icone é o que vai aparecer na lista de visualização
  String? content;
  String? link;

  Noticia(
      {var image,
      String? title,
      String? subtitle,
      var date,
      String? category,
      var icon,
      String? link,
      String? content}) {
    this.image = image;
    this.title = title;
    this.subtitle = subtitle;
    this.date = date;
    this.category = category;
    _icon = icon;
    this.link = link;
    this.content = content;
  }

  Noticia.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
    subtitle = json['subtitle'];
    date = json['date'];
    category = json['category'];
    _icon = json['icon'];
    link = json['link'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['date'] = date;
    data['category'] = category;
    data['icon'] = _icon;
    data['link'] = link;
    data['content'] = content;
    return data;
  }
}

class Noticia {
  var image;
  String? title;
  String? subtitle;
  var date;
  String? category;
  var _icon; //Esse icone é o que vai aparecer na lista de visualização
  String? content;

  Noticia(
      {var image,
      String? title,
      String? subtitle,
      var date,
      String? category,
      var icon,
      String? content}) {
    this.image = image;
    this.title = title;
    this.subtitle = subtitle;
    this.date = date;
    this.category = category;
    this._icon = icon;
    this.content = content;
  }

  Noticia.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
    subtitle = json['subtitle'];
    date = json['date'];
    category = json['category'];
    _icon = json['icon'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['date'] = this.date;
    data['category'] = this.category;
    data['icon'] = this._icon;
    data['content'] = this.content;
    return data;
  }
}

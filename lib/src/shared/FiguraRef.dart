import 'dart:convert';

class FiguraRef {
  final String? url;
  final int? width;
  final int? height;

  FiguraRef({
    required this.url,
    required this.width,
    required this.height,
  });

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'width': width,
      'height': height,
    };
  }

  factory FiguraRef.fromMap(Map<String, dynamic> map) {
    return FiguraRef(
      url: map['url'],
      width: map['width'],
      height: map['height'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FiguraRef.fromJson(String source) =>
      FiguraRef.fromMap(json.decode(source));
}

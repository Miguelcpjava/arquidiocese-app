import 'dart:convert';

import 'package:arquidiocese_maceio_app/src/shared/FiguraRef.dart';

class Figuras {
  final FiguraRef small;
  final FiguraRef medium;
  final FiguraRef high;
  Figuras({
    required this.small,
    required this.medium,
    required this.high,
  });

  Figuras copyWith({
    FiguraRef? small,
    FiguraRef? medium,
    FiguraRef? high,
  }) {
    return Figuras(
      small: small ?? this.small,
      medium: medium ?? this.medium,
      high: high ?? this.high,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'default': small.toMap(),
      'medium': medium.toMap(),
      'high': high.toMap(),
    };
  }

  factory Figuras.fromMap(Map<String, dynamic> map) {
    return Figuras(
      small: FiguraRef.fromMap(map['default']),
      medium: FiguraRef.fromMap(map['medium']),
      high: FiguraRef.fromMap(map['high']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Figuras.fromJson(String source) =>
      Figuras.fromMap(json.decode(source));

  @override
  String toString() => 'Figuras(default: $small, medium: $medium, high: $high)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Figuras &&
        other.small == small &&
        other.medium == medium &&
        other.high == high;
  }

  @override
  int get hashCode => small.hashCode ^ medium.hashCode ^ high.hashCode;
}

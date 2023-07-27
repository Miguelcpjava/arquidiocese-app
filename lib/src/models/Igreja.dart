import 'package:arquidiocese_maceio_app/src/models/Missa.dart';

class Igreja {
  String? homenageado;
  String? vigario;
  DateTime? festa;
  String? historia;
  List<Missa> missa;

  Igreja(
      {this.homenageado,
      this.festa,
      this.historia,
      required this.missa,
      this.vigario});
}

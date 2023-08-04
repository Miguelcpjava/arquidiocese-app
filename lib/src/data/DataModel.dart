import 'package:arquidiocese_maceio_app/src/models/Bairro.dart';
import 'package:arquidiocese_maceio_app/src/models/Igreja.dart';
import 'package:arquidiocese_maceio_app/src/models/Missa.dart';
import 'package:arquidiocese_maceio_app/src/models/Paroquia.dart';

List<Bairro> bairros = [
  Bairro(
    nome: "Serraria",
  ),
  Bairro(nome: "Gruta de Lourdes")
];

List<Igreja> igrejas = [
  Igreja(
      endereco: "R. Cedro, 27",
      vigario: "Mons. Rubião",
      festa: "11/02",
      homenageado: "Nossa Senhora de Lourdes",
      historia: "Texto Grande",
      missa: Missa(
          segunda: "Não há horário",
          terca: "17h",
          quarta: "17h",
          quinta: "6:30",
          sexta: "17h (exceto a primeira sexta, 19h)",
          sabado: "19h",
          domingo: "7:30 e 19h")),
];
List<Paroquia> paroquias = [
  Paroquia(
      nome: "Nossa Senhora da Gruta de Lourdes",
      instagram: "",
      youtube: "",
      telefone: "(82)3333-3333",
      whatsapp: "(82)3333-3333",
      igreja: igrejas)
];

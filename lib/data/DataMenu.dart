import 'package:arquidiocese_maceio_app/data/Constants.dart';
import 'package:arquidiocese_maceio_app/models/Menu.dart';
import 'package:arquidiocese_maceio_app/screens/UltimasNoticiasScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<Menu> menus = [
  Menu(
      height: 100.0,
      icon: Icons.newspaper,
      title: "Últimas Noticias",
      widget: UltimasNoticiasScreen()),
  Menu(
      height: 100.0,
      icon: Icons.keyboard_voice_sharp,
      title: "Podcasts",
      widget: UltimasNoticiasScreen()),
  Menu(
      height: 100.0,
      icon: Icons.church,
      title: "Paróquias",
      widget: UltimasNoticiasScreen()),
  Menu(
      height: 100.0,
      icon: Icons.video_library_outlined,
      title: "Videos",
      widget: UltimasNoticiasScreen()),
  Menu(
      height: 100.0,
      icon: FontAwesomeIcons.handsPraying,
      title: "Pedido de Oração",
      widget: UltimasNoticiasScreen()),
  Menu(
      height: 100.0,
      icon: Icons.contacts,
      title: "Contato",
      widget: UltimasNoticiasScreen()),
  Menu(
      height: 100.0,
      icon: FontAwesomeIcons.church,
      title: "Santuário",
      widget: UltimasNoticiasScreen()),
  Menu(
      height: 100.0,
      icon: Icons.church_sharp,
      title: "Seminários e Conventos",
      widget: UltimasNoticiasScreen()),
  Menu(
      height: 100.0,
      icon: pope_crown,
      title: "Cúria Metropolitana",
      widget: UltimasNoticiasScreen()),
];

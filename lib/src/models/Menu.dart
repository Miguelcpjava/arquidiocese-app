import 'package:flutter/material.dart';

class Menu {
  String title;
  IconData icon;
  double height;
  Widget widget;

  Menu(
      {required this.title,
      required this.icon,
      required this.height,
      required this.widget});
}

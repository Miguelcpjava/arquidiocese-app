import 'package:flutter/material.dart';

class CardsMenu extends StatefulWidget {
  final double height;
  final IconData icon;
  final String text;

  const CardsMenu(
      {Key? key, required this.height, required this.icon, required this.text})
      : super(key: key);

  @override
  State<CardsMenu> createState() => _CardsMenuState();
}

class _CardsMenuState extends State<CardsMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: 110,
      padding: const EdgeInsets.all(5.0),
      margin: const EdgeInsets.all(7.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: Colors.white,
      ),
      child: Column(
        // Replace with a Row for horizontal icon + text
        children: <Widget>[
          Icon(
            widget.icon ?? Icons.info,
            color: Theme.of(context).primaryColor,
            size: 45.0,
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
          Text(
            widget.text,
            textAlign: TextAlign.center,
            style: TextStyle(
                decoration: TextDecoration.none,
                color: Theme.of(context).primaryColor,
                fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}

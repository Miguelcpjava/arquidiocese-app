import 'package:flutter/material.dart';

class CardsMenu extends StatefulWidget {
  final double height;
  final IconData icon;
  final String text;

  CardsMenu(
      {Key? key, required this.height, required this.icon, required this.text})
      : super(key: key);

  @override
  State<CardsMenu> createState() => _CardsMenuState();
}

class _CardsMenuState extends State<CardsMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: double.infinity,
      padding: EdgeInsets.all(5.0),
      margin: EdgeInsets.all(7.0),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
        color: Colors.white,
      ),
      child: Column(
        // Replace with a Row for horizontal icon + text
        children: <Widget>[
          Icon(
            widget.icon == null ? Icons.info : widget.icon,
            color: Theme.of(context).primaryColor,
            size: 50.0,
          ),
          new Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
          Text(
            widget.text,
            textAlign: TextAlign.center,
            style: new TextStyle(
                decoration: TextDecoration.none,
                color: Theme.of(context).primaryColor,
                fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}

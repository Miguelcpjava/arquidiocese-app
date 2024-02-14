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
    return Card(
      child: SizedBox(
        width: 130.0,
        height: 130.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                widget.icon,
                size: 48.0,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 8.0),
              Align(
                alignment: Alignment.center,
                child: Text(
                  widget.text,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

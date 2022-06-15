import 'package:arquidiocese_maceio_app/data/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomAlertDialog extends StatelessWidget {
  String texto;

  CustomAlertDialog(this.texto);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260.0,
      height: 230.0,
      decoration: new BoxDecoration(
        shape: BoxShape.rectangle,
        color: const Color(0xFFFFFF),
        borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
      ),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // dialog top
          new Expanded(
            child: new Row(
              children: <Widget>[
                new Container(
                  // padding: new EdgeInsets.all(10.0),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                  ),
                  child: new Text(
                    'Alerta!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontFamily: 'helvetica_neue_light',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),

          // dialog centre
          Expanded(
            child: new Container(
              child: new Text(
                texto,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 12.0,
                  fontFamily: 'helvetica_neue_light',
                ),
              ),
            ),
          ),

          // dialog bottom
          Expanded(
            child: new Container(
              padding: new EdgeInsets.all(16.0),
              decoration: new BoxDecoration(
                color: Colors.white,
              ),
              child: new Text(
                'OK',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontFamily: 'helvetica_neue_light',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

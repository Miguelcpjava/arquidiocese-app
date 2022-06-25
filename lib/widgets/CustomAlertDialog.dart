import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  String texto;
  String descricao;

  CustomAlertDialog(this.texto, this.descricao);

  contentBox(context) {
    const double PADDING_PADRAO = 20;
    const double RADIUS_PADRAO = 45;
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
              left: PADDING_PADRAO,
              top: RADIUS_PADRAO + PADDING_PADRAO,
              right: PADDING_PADRAO,
              bottom: PADDING_PADRAO),
          margin: const EdgeInsets.only(top: RADIUS_PADRAO),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(PADDING_PADRAO),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                texto,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                descricao,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      texto,
                      style: const TextStyle(fontSize: 18),
                    )),
              ),
            ],
          ),
        ), // bottom part
        Positioned(
          left: PADDING_PADRAO,
          right: PADDING_PADRAO,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: RADIUS_PADRAO,
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(RADIUS_PADRAO)),
                child: Image.asset("assets/img/arqbrasao.png")),
          ),
        ), // top part
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
}

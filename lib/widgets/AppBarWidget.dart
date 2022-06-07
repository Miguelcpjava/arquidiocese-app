import 'package:arquidiocese_maceio_app/data/Constants.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    leading: BackButton(),
    backgroundColor: darkBlue,
    elevation: 0,
  );
}

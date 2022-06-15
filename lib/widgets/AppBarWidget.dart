import 'package:arquidiocese_maceio_app/data/Constants.dart';
import 'package:flutter/material.dart';

Widget buildAppBar(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          SafeArea(
            child: Container(
              decoration: BoxDecoration(
                color: darkBlue,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
              ),
              alignment: Alignment.topLeft,
              height: 16,
              width: 16,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

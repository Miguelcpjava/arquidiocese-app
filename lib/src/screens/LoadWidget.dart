import 'package:flutter/material.dart';

Container Loading() {
  return Container(
    child: const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    ),
  );
}

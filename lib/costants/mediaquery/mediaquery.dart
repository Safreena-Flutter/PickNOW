import 'package:flutter/material.dart';

double mediaqueryheight(double value, context) {
  return MediaQuery.of(context).size.height * value;
}

double mediaquerywidth(double value, context) {
  return MediaQuery.of(context).size.width * value;
}
double mediaquerySize(double value, BuildContext context) {
  return MediaQuery.of(context).size.width * value;
}

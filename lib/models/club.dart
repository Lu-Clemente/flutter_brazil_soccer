import 'package:flutter/material.dart';
import 'package:flutter_brazil_soccer/models/championship.dart';

class Club {
  String name;
  String shield;
  int points;
  List<Championship> championships = [];
  Color? color;

  Club({
    this.color,
    required this.name,
    required this.shield,
    required this.points,
  });
}

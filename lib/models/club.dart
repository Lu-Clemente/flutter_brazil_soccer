import 'package:flutter/material.dart';
import 'package:flutter_brazil_soccer/models/championship.dart';

class Club {
  int? id;
  String name;
  String shield;
  int points;
  List<Championship> championships = [];
  Color color;

  Club({
    this.id,
    required this.color,
    required this.name,
    required this.shield,
    required this.points,
    this.championships = const [],
  });
}

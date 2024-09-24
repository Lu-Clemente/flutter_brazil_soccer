import 'dart:collection';

import 'package:flutter_brazil_soccer/models/club.dart';
import 'package:flutter_brazil_soccer/models/championship.dart';
import 'package:flutter/material.dart';

class ClubsRepository extends ChangeNotifier {
  final List<Club> _clubs = [];

  UnmodifiableListView<Club> get clubs => UnmodifiableListView(_clubs);

  void addChampionship(Club club, Championship championship) {
    final index = _clubs.indexWhere((c) => c.name == club.name);
    if (index != -1) {
      _clubs[index].championships.add(championship);
      notifyListeners();
    }
  }

  ClubsRepository() {
    _clubs.addAll([
      Club(
        name: 'Flamengo',
        points: 71,
        shield: 'https://e.imguol.com/futebol/brasoes/40x40/flamengo.png',
        color: Colors.red,
      ),
      Club(
          name: 'Internacional',
          points: 69,
          shield:
              'https://e.imguol.com/futebol/brasoes/40x40/internacional.png',
          color: Colors.red),
      Club(
          name: 'Atlético-MG',
          points: 65,
          shield: 'https://e.imguol.com/futebol/brasoes/40x40/atletico-mg.png',
          color: Colors.black),
      Club(
          name: 'São Paulo',
          points: 63,
          shield: 'https://e.imguol.com/futebol/brasoes/40x40/sao-paulo.png',
          color: Colors.red),
      Club(
          name: 'Fluminense',
          points: 61,
          shield: 'https://e.imguol.com/futebol/brasoes/40x40/fluminense.png',
          color: Colors.green),
      Club(
          name: 'Grêmio',
          points: 59,
          shield: 'https://e.imguol.com/futebol/brasoes/40x40/gremio.png',
          color: Colors.blue),
      Club(
          name: 'Palmeiras',
          points: 58,
          shield: 'https://e.imguol.com/futebol/brasoes/40x40/palmeiras.png',
          color: Colors.green),
      Club(
          name: 'Santos',
          points: 54,
          shield: 'https://e.imguol.com/futebol/brasoes/40x40/santos.png',
          color: Colors.white),
      Club(
          name: 'Athletico-PR',
          points: 53,
          shield: 'https://e.imguol.com/futebol/brasoes/40x40/atletico-pr.png',
          color: Colors.red),
      Club(
          name: 'Bragantino',
          points: 53,
          shield:
              'https://e.imguol.com/futebol/brasoes/40x40/red-bull-bragantino.png',
          color: Colors.red),
      Club(
          name: 'Ceará',
          points: 52,
          shield: 'https://e.imguol.com/futebol/brasoes/40x40/ceara.png',
          color: Colors.black),
      Club(
          name: 'Corinthians',
          points: 51,
          shield: 'https://e.imguol.com/futebol/brasoes/40x40/corinthians.png',
          color: Colors.black),
      Club(
          name: 'Atlético-GO',
          points: 50,
          shield: 'https://e.imguol.com/futebol/brasoes/40x40/atletico-go.png',
          color: Colors.black),
      Club(
          name: 'Bahia',
          points: 44,
          shield: 'https://e.imguol.com/futebol/brasoes/40x40/bahia.png',
          color: Colors.blue),
      Club(
          name: 'Sport',
          points: 42,
          shield: 'https://e.imguol.com/futebol/brasoes/40x40/sport.png',
          color: Colors.red),
      Club(
          name: 'Fortaleza',
          points: 41,
          shield: 'https://e.imguol.com/futebol/brasoes/40x40/fortaleza.png',
          color: Colors.blue),
      Club(
          name: 'Vasco',
          points: 41,
          shield: 'https://e.imguol.com/futebol/brasoes/40x40/vasco.png',
          color: Colors.black),
      Club(
          name: 'Goiás',
          points: 37,
          shield: 'https://e.imguol.com/futebol/brasoes/40x40/goias.png',
          color: Colors.green),
      Club(
          name: 'Coritiba',
          points: 31,
          shield: 'https://e.imguol.com/futebol/brasoes/40x40/coritiba.png',
          color: Colors.green),
      Club(
          name: 'Botafogo',
          points: 27,
          shield: 'https://e.imguol.com/futebol/brasoes/40x40/botafogo.png',
          color: Colors.black),
    ]);
  }
}

import 'dart:collection';

import 'package:flutter_brazil_soccer/database/db.dart';
import 'package:flutter_brazil_soccer/models/club.dart';
import 'package:flutter_brazil_soccer/models/championship.dart';
import 'package:flutter/material.dart';

class ClubsRepository extends ChangeNotifier {
  final List<Club> _clubs = [];

  UnmodifiableListView<Club> get clubs => UnmodifiableListView(_clubs);

  void addChampionship(Club club, Championship championship) async {
    var db = await DB.get();
    final int id = await db.insert('championships', {
      'competition': championship.competition,
      'year': championship.year,
      'club_id': club.id,
    });
    championship.id = id;
    final index = _clubs.indexWhere((c) => c.name == club.name);
    if (index != -1) {
      _clubs[index].championships.add(championship);
      notifyListeners();
    }
  }

  void removeChampionship({
    required Club club,
    required Championship championship,
  }) async {
    var db = await DB.get();
    await db.delete(
      'championships',
      where: 'id = ?',
      whereArgs: [championship.id],
    );
    final index = _clubs.indexWhere((c) => c.name == club.name);
    if (index != -1) {
      _clubs[index].championships.removeWhere((c) => c.id == championship.id);
      notifyListeners();
    }
  }

  void editChampionship({
    required Club club,
    required Championship oldChampionship,
    required Championship newChampionship,
  }) async {
    var db = await DB.get();
    final int id = await db.update(
      'championships',
      {
        'competition': newChampionship.competition,
        'year': newChampionship.year,
      },
      where: 'id = ?',
      whereArgs: [oldChampionship.id],
    );
    newChampionship.id = id;
    final index = _clubs.indexWhere((c) => c.name == club.name);
    if (index != -1) {
      final championshipIndex = _clubs[index]
          .championships
          .indexWhere((c) => c.id == oldChampionship.id);
      if (championshipIndex != -1) {
        _clubs[index].championships[championshipIndex] = newChampionship;
        notifyListeners();
      }
    }
  }

  static setupClubs() {
    return [
      Club(
        name: 'Flamengo',
        points: 71,
        shield: 'https://e.imguol.com/futebol/brasoes/100x100/flamengo.png',
        color: Colors.red,
      ),
      Club(
          name: 'Internacional',
          points: 69,
          shield:
              'https://e.imguol.com/futebol/brasoes/100x100/internacional.png',
          color: Colors.red),
      Club(
          name: 'Atlético-MG',
          points: 65,
          shield:
              'https://e.imguol.com/futebol/brasoes/100x100/atletico-mg.png',
          color: Colors.black),
      Club(
          name: 'São Paulo',
          points: 63,
          shield: 'https://e.imguol.com/futebol/brasoes/100x100/sao-paulo.png',
          color: Colors.red),
      Club(
          name: 'Fluminense',
          points: 61,
          shield: 'https://e.imguol.com/futebol/brasoes/100x100/fluminense.png',
          color: Colors.green),
      Club(
          name: 'Grêmio',
          points: 59,
          shield: 'https://e.imguol.com/futebol/brasoes/100x100/gremio.png',
          color: Colors.blue),
      Club(
          name: 'Palmeiras',
          points: 58,
          shield: 'https://e.imguol.com/futebol/brasoes/100x100/palmeiras.png',
          color: Colors.green),
      Club(
          name: 'Santos',
          points: 54,
          shield: 'https://e.imguol.com/futebol/brasoes/100x100/santos.png',
          color: Colors.white),
      Club(
          name: 'Athletico-PR',
          points: 53,
          shield:
              'https://e.imguol.com/futebol/brasoes/100x100/atletico-pr.png',
          color: Colors.red),
      Club(
          name: 'Bragantino',
          points: 53,
          shield:
              'https://e.imguol.com/futebol/brasoes/100x100/red-bull-bragantino.png',
          color: Colors.red),
      Club(
          name: 'Ceará',
          points: 52,
          shield: 'https://e.imguol.com/futebol/brasoes/100x100/ceara.png',
          color: Colors.black),
      Club(
          name: 'Corinthians',
          points: 51,
          shield:
              'https://e.imguol.com/futebol/brasoes/100x100/corinthians.png',
          color: Colors.black),
      Club(
          name: 'Atlético-GO',
          points: 50,
          shield:
              'https://e.imguol.com/futebol/brasoes/100x100/atletico-go.png',
          color: Colors.black),
      Club(
          name: 'Bahia',
          points: 44,
          shield: 'https://e.imguol.com/futebol/brasoes/100x100/bahia.png',
          color: Colors.blue),
      Club(
          name: 'Sport',
          points: 42,
          shield: 'https://e.imguol.com/futebol/brasoes/100x100/sport.png',
          color: Colors.red),
      Club(
          name: 'Fortaleza',
          points: 41,
          shield: 'https://e.imguol.com/futebol/brasoes/100x100/fortaleza.png',
          color: Colors.blue),
      Club(
          name: 'Vasco',
          points: 41,
          shield: 'https://e.imguol.com/futebol/brasoes/100x100/vasco.png',
          color: Colors.black),
      Club(
          name: 'Goiás',
          points: 37,
          shield: 'https://e.imguol.com/futebol/brasoes/100x100/goias.png',
          color: Colors.green),
      Club(
          name: 'Coritiba',
          points: 31,
          shield: 'https://e.imguol.com/futebol/brasoes/100x100/coritiba.png',
          color: Colors.green),
      Club(
          name: 'Botafogo',
          points: 27,
          shield: 'https://e.imguol.com/futebol/brasoes/100x100/botafogo.png',
          color: Colors.black),
    ];
  }

  ClubsRepository() {
    initRepository();
  }

  void initRepository() async {
    var db = await DB.get();
    final List<Map<String, dynamic>> clubs = await db.query('clubs');

    for (final club in clubs) {
      _clubs.add(Club(
        id: club['id'],
        name: club['name'],
        points: club['points'],
        shield: club['shield'],
        color: Color(int.parse(club['color'], radix: 16)),
        championships: await getChampionships(club['id']),
      ));
    }
    notifyListeners();
  }

  Future<List<Championship>> getChampionships(int clubId) async {
    var db = await DB.get();
    final List<Map<String, dynamic>> championships = await db.query(
      'championships',
      where: 'club_id = ?',
      whereArgs: [clubId],
    );

    return championships
        .map((championship) => Championship(
              id: championship['id'],
              competition: championship['competition'],
              year: championship['year'],
            ))
        .toList();
  }
}

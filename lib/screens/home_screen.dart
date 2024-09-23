import 'package:flutter/material.dart';
import 'package:flutter_brazil_soccer/models/club.dart';
import 'package:flutter_brazil_soccer/screens/club_screen.dart';
import 'package:flutter_brazil_soccer/screens/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeController controller;

  @override
  void initState() {
    super.initState();
    controller = HomeController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Brasileirão 2024',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.separated(
          itemBuilder: (BuildContext ctx, int index) {
            final Club club = controller.standings[index];
            return ListTile(
              leading: Image.network(club.shield),
              title: Text(club.name),
              trailing: Text('${club.points} pts'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext ctx) => ClubScreen(
                        key: Key(
                          club.name,
                        ),
                        club: club),
                  ),
                );
              },
            );
          },
          separatorBuilder: (BuildContext ctx, int index) => const Divider(),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          itemCount: controller.standings.length),
    );
  }
}

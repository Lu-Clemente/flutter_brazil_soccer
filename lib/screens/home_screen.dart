import 'package:flutter/material.dart';
import 'package:flutter_brazil_soccer/controllers/theme_controller.dart';
import 'package:flutter_brazil_soccer/models/club.dart';
import 'package:flutter_brazil_soccer/repositories/clubs_repository.dart';
import 'package:flutter_brazil_soccer/screens/club_screen.dart';
import 'package:flutter_brazil_soccer/controllers/home_controller.dart';
import 'package:flutter_brazil_soccer/widgets/shield.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeController controller;
  ThemeController themeController = ThemeController.to;

  @override
  void initState() {
    super.initState();
    controller = HomeController();
  }

  goToClubScreen(Club club) {
    Get.to(() => ClubScreen(key: Key(club.name), club: club));
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
        actions: [
          IconButton(
            icon: Obx(() => Icon(
                  themeController.isDarkMode.value
                      ? Icons.light_mode
                      : Icons.dark_mode,
                  color: Colors.white,
                )),
            onPressed: themeController.changeTheme,
          ),
        ],
      ),
      body: Consumer<ClubsRepository>(
        builder: (context, repository, child) => ListView.separated(
          itemBuilder: (BuildContext ctx, int index) {
            final Club club = repository.clubs[index];
            return ListTile(
              leading: Shield(imageSrc: club.shield, size: 40),
              title: Text(club.name),
              subtitle: Text('Championships: ${club.championships.length}'),
              trailing: Text('${club.points} pts'),
              onTap: () => goToClubScreen(club),
            );
          },
          separatorBuilder: (BuildContext ctx, int index) => const Divider(),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          itemCount: repository.clubs.length,
        ),
      ),
    );
  }
}

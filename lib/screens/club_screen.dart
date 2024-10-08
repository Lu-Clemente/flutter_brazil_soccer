import 'package:flutter/material.dart';
import 'package:flutter_brazil_soccer/models/championship.dart';
import 'package:flutter_brazil_soccer/models/club.dart';
import 'package:flutter_brazil_soccer/repositories/clubs_repository.dart';
import 'package:flutter_brazil_soccer/screens/add_championship_screen.dart';
import 'package:flutter_brazil_soccer/screens/edit_championship_screen.dart';
import 'package:flutter_brazil_soccer/widgets/shield.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ClubScreen extends StatefulWidget {
  final Club club;

  const ClubScreen({super.key, required this.club});

  @override
  State<ClubScreen> createState() => _ClubScreenState();
}

class _ClubScreenState extends State<ClubScreen> with TickerProviderStateMixin {
  void navigatoToChampinshipsTab() {
    Get.back();
    _tabController.animateTo(1);
  }

  void goToNewChampionshipScreen() {
    Get.to(
      () => AddChampionshipScreen(
        key: const Key("AddChampionshipScreen"),
        club: widget.club,
        redirect: navigatoToChampinshipsTab,
      ),
    );
  }

  void openDialog(Championship championship) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        final club = Provider.of<ClubsRepository>(context, listen: false)
            .clubs
            .firstWhere(
              (club) => club.name == widget.club.name,
            );
        return AlertDialog(
          title:
              const Text("Would you like to edit or delete this championship?"),
          content: Text(
            "${championship.competition} - ${championship.year} (${club.name})",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Provider.of<ClubsRepository>(
                  context,
                  listen: false,
                ).removeChampionship(
                  club: club,
                  championship: championship,
                );
                Get.back();
              },
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all(Colors.red),
              ),
              child: const Text("Delete"),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                Get.to(
                  () => EditChampionshipScreen(
                    championship: championship,
                    club: club,
                  ),
                  fullscreenDialog: true,
                );
              },
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all(Colors.blue),
              ),
              child: const Text("Edit"),
            ),
            TextButton(
              onPressed: () => Get.back(),
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all(Colors.grey[800]),
              ),
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  Widget championshipsTab() {
    final club = Provider.of<ClubsRepository>(
      context,
    ).clubs.firstWhere(
          (club) => club.name == widget.club.name,
        );

    final championshipCount = club.championships.length;

    if (championshipCount == 0) {
      return const Center(
        child: Text("No championships found"),
      );
    }

    final championships = club.championships;

    return ListView.separated(
      itemBuilder: (BuildContext ctx, int index) {
        return ListTile(
          leading: const Icon(Icons.emoji_events),
          title: Text(championships[index].competition),
          trailing: Text(championships[index].year.toString()),
          onLongPress: () => openDialog(championships[index]),
        );
      },
      itemCount: championshipCount,
      separatorBuilder: (BuildContext ctx, int index) => const Divider(),
    );
  }

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: widget.club.color,
          title: Text(
            widget.club.name,
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: goToNewChampionshipScreen,
            ),
          ],
          iconTheme: const IconThemeData(color: Colors.white),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                icon: Icon(Icons.stacked_line_chart),
                text: "Statistics",
              ),
              Tab(
                icon: Icon(Icons.emoji_events),
                text: "Championships",
              ),
            ],
            splashBorderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            unselectedLabelColor: Colors.white70,
            labelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 2,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Shield(imageSrc: widget.club.shield, size: 100),
                ),
              ],
            ),
            championshipsTab(),
          ],
        ),
      ),
    );
  }
}

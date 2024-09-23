import 'package:flutter_brazil_soccer/models/club.dart';
import 'package:flutter_brazil_soccer/repositories/clubs_repository.dart';

class HomeController {
  late ClubsRepository _clubsRepository;
  List<Club> get standings => _clubsRepository.clubs;

  HomeController() {
    _clubsRepository = ClubsRepository();
  }
}

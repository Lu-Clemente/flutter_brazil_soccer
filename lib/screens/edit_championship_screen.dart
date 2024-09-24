import 'package:flutter/material.dart';
import 'package:flutter_brazil_soccer/models/championship.dart';
import 'package:flutter_brazil_soccer/models/club.dart';
import 'package:flutter_brazil_soccer/repositories/clubs_repository.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class EditChampionshipScreen extends StatefulWidget {
  final Championship championship;
  final Club club;

  const EditChampionshipScreen({
    super.key,
    required this.championship,
    required this.club,
  });

  @override
  State<EditChampionshipScreen> createState() => _EditChampionshipScreenState();
}

class _EditChampionshipScreenState extends State<EditChampionshipScreen> {
  final _formKey = GlobalKey<FormState>();
  final _competitionController = TextEditingController();
  final _yearController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _competitionController.text = widget.championship.competition;
    _yearController.text = widget.championship.year.toString();
  }

  void edit() {
    if (_formKey.currentState!.validate()) {
      final championship = Championship(
        competition: _competitionController.text,
        year: int.parse(_yearController.text),
      );

      Provider.of<ClubsRepository>(
        context,
        listen: false,
      ).editChampionship(
        club: widget.club,
        oldChampionship: widget.championship,
        newChampionship: championship,
      );

      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Championship'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: edit,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _competitionController,
                decoration: const InputDecoration(
                  labelText: 'Competition Name',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Competition is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _yearController,
                decoration: const InputDecoration(
                  labelText: 'Year',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Year is required';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

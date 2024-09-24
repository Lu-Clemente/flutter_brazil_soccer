import 'package:flutter/material.dart';
import 'package:flutter_brazil_soccer/models/championship.dart';
import 'package:flutter_brazil_soccer/models/club.dart';
import 'package:flutter_brazil_soccer/repositories/clubs_repository.dart';
import 'package:provider/provider.dart';

class AddChampionshipScreen extends StatefulWidget {
  final Club club;
  final Function redirect;

  const AddChampionshipScreen({
    super.key,
    required this.club,
    required this.redirect,
  });

  @override
  State<AddChampionshipScreen> createState() => _AddChampionshipScreenState();
}

class _AddChampionshipScreenState extends State<AddChampionshipScreen> {
  final _competitionController = TextEditingController();
  final _yearController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void handleSave() {
    if (_formKey.currentState!.validate()) {
      final championship = Championship(
        competition: _competitionController.text,
        year: int.parse(_yearController.text),
      );

      save(championship);
    }

    const SnackBar(
      content: Text("Unable to add championship"),
      duration: Duration(seconds: 2),
    );
  }

  void save(Championship competition) {
    Provider.of<ClubsRepository>(
      context,
      listen: false,
    ).addChampionship(widget.club, competition);

    widget.redirect();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Championship added successfully"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Championship'),
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
                  if (value == null || value.isEmpty) {
                    return 'Please enter the competition name';
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
                  if (value == null || value.isEmpty) {
                    return 'Please enter a year';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 22),
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: WidgetStateProperty.all(
                        const Size(double.infinity, 50),
                      ),
                      backgroundColor: WidgetStateProperty.all(
                          Theme.of(context).colorScheme.primary),
                    ),
                    onPressed: handleSave,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check, color: Colors.white),
                        SizedBox(width: 10),
                        Text('Save',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

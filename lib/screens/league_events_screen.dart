import 'package:flutter/material.dart';
import '../models/model.dart';

class LeagueEventsScreen extends StatelessWidget {
  final League league;

  LeagueEventsScreen(this.league);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('League Events'),
      ),
      body: Center(
        child: Text('Details for League: id: ${league.id}\n name: ${league.name}'),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../models/model.dart';
import '../widgets/league_widget.dart';

class LeaguesScreen extends StatelessWidget {
  final List<League> leagues;

  LeaguesScreen(this.leagues);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: leagues.length,
      itemBuilder: (context, index) {
        final league = leagues[index];
        return LeagueWidget(league);
      },
    );
  }
}

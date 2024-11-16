import 'package:flutter/material.dart';
import '../models/model.dart';
import '../utils/http_getters.dart';
import '../widgets/league_widget.dart';

class LeaguesScreen extends StatefulWidget {
  @override
  State<LeaguesScreen> createState() => _LeaguesScreenState();
}

class _LeaguesScreenState extends State<LeaguesScreen> {
  late Future<List<League>> futureLeagues;

  @override
  void initState() {
    super.initState();
    futureLeagues = getLeagues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Leagues'),
      ),
      body: Center(
        child: FutureBuilder<List<League>>(
          future: futureLeagues,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final leagues = snapshot.data!;
              return ListView.builder(
                  itemCount: leagues.length,
                  itemBuilder: (context, index) {
                    final league = leagues[index];
                    return LeagueWidget(league);
                  });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

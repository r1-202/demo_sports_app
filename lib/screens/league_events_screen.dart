import 'package:demo_sports_app/widgets/event_widget.dart';
import 'package:flutter/material.dart';
import '../models/model.dart';
import '../utils/http_getters.dart';

class LeagueEventsScreen extends StatefulWidget {
  final League league;

  LeagueEventsScreen(this.league);

  @override
  State<LeagueEventsScreen> createState() => _LeagueEventsScreenState();
}

class _LeagueEventsScreenState extends State<LeagueEventsScreen>  {
  late Future<List<Event>> futureEvents;

  @override
  void initState() {
    super.initState();
    futureEvents = getEvents(widget.league.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.league.name} Events'),
      ),
      body: Center(
        child: FutureBuilder<List<Event>>(
          future: futureEvents,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final events = snapshot.data!;
              return ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return EventWidget(event);
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
import 'package:demo_sports_app/screens/leagues_screen.dart';
import 'package:flutter/material.dart';
import 'models/model.dart';
import 'utils/http_getters.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late Future<List<League>> futureLeagues;

  @override
  void initState() {
    super.initState();
    futureLeagues = getLeagues();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Sports App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        ),
        home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<List<League>>(
            future: futureLeagues,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return LeaguesScreen(snapshot.data!);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
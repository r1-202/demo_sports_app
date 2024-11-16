library http_getters;

import 'dart:convert';

import '../models/model.dart';
import 'package:http/http.dart' as http;

Future<List<League>> getLeagues() async {
  http.Response response = await http.get(
      Uri.parse("https://www.thesportsdb.com/api/v1/json/3/all_leagues.php"));
  if (response.statusCode != 200) {
    return List<League>.empty();
  }
  Map<String, dynamic> jsonMap =
      jsonDecode(response.body) as Map<String, dynamic>;
  var listJson = jsonMap["leagues"] as List<dynamic>;
  List<League> list = List<League>.empty(growable: true);
  for (var l in listJson) {
    var league = League(l["idLeague"], l["strLeague"], l["strSport"], "");
    if (idList.contains(league.id)) {
      league.bannerUrl = bannerUrlList[idList.indexOf(league.id)];
      list.add(league);
    }
  }
  return list;
}

Future<List<Event>> getEvents(String leagueId) async {
  List<Event> list = List<Event>.empty(growable: true);
  DateTime now = DateTime.now().toUtc();
  for (int i = 0; i < 2; ++i) {
    int currentYear = now.year+i;
    http.Response response = await http.get(Uri.parse(
        "https://www.thesportsdb.com/api/v1/json/3/eventsseason.php?id=$leagueId&s=${currentYear - 1}-$currentYear"));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonMap =
          jsonDecode(response.body) as Map<String, dynamic>;
      var listJson = jsonMap["events"] as List<dynamic>;
      for (var l in listJson) {
        if(l["strTimestamp"] == null) continue;
        DateTime eventTime = DateTime.parse(l["strTimestamp"]);

        // Add the below line if we only want to show upcoming events.
        //if (!eventTime.isAfter(now)){continue;}
         
        list.add(Event(l["strEvent"], l["strSeason"], eventTime));
      }
    }
  }

  return list;
}

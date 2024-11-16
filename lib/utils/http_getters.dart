library http_getters;

import 'dart:convert';

import '../models/model.dart';
import 'package:http/http.dart' as http;

Future<List<League>> getLeagues() async
{
  http.Response response = await http.get(Uri.parse(
    "https://www.thesportsdb.com/api/v1/json/3/all_leagues.php"));
  if(response.statusCode != 200)
  {
    return List<League>.empty();
  }
  Map<String, dynamic> jsonMap = jsonDecode(response.body) as Map<String, dynamic>;
  var listJson = jsonMap["leagues"] as List<dynamic>;
  List<League> list = List<League>.empty(growable: true);
  for(var l in listJson)
  {
    var league = League(l["idLeague"], l["strLeague"], l["strSport"], "");
    if(idList.contains(league.id))
    {
      league.bannerUrl = bannerUrlList[idList.indexOf(league.id)];
      list.add(league);
    }
  }
  return list;
}

Future<List<Event>> getEvents(String leagueId) async
{
  return List<Event>.empty();
}
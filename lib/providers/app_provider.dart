import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ApplicationProvider extends ChangeNotifier {
//   bool isDark = false;
//
//   Future setBoolean({
//   bool? theme,
// }) async {
//     var pref = await SharedPreferences.getInstance();
//     pref.setBool('isDark', isDark);
//   }
//
//   void changeAppTheme() {
//     isDark = !isDark;
//     setBoolean(theme: isDark);
//     notifyListeners();
//   }

  Future getAllGamesData() async {
    var allGamesUrl = Uri.parse('https://www.freetogame.com/api/games');
    var response = await http.get(allGamesUrl);
    return json.decode(response.body);
  }

  Future getBrowserGamesData() async {
    var browserGamesUrl =
        Uri.parse('https://www.freetogame.com/api/games?platform=browser');
    var response = await http.get(browserGamesUrl);
    return json.decode(response.body);
  }

  Future getGamesByCategoriesData({
    required String categories,
  }) async {
    var gamesByCategoriesUrl =
        Uri.parse('https://www.freetogame.com/api/games?category=$categories');
    var response = await http.get(gamesByCategoriesUrl);
    return json.decode(response.body);
  }

  Future getGameDetails({
    required String gameId,
  }) async {
    var gameDetailsUrl =
        Uri.parse('https://www.freetogame.com/api/game?id=$gameId');
    var response = await http.get(gameDetailsUrl);
    return json.decode(response.body);
  }
}

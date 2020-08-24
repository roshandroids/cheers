import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class BeerRepository {
  Future<List> getBeers(int page);
}

class BeerRepositoryImpl implements BeerRepository {
  @override
  Future<List> getBeers(int page) async {
    try {
      var response =
          await http.get("https://api.punkapi.com/v2/beers?page$page");
      var data = json.decode(response.body);
      return data;
    } catch (e) {
      print(e);
      return e;
    }
  }
}

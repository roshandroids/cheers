import 'dart:convert';

import 'package:cheers/API/strings.dart';
import 'package:http/http.dart' as http;

abstract class BeerRepository {
  Future<List> getBeers();
}

class BeerRepositoryImpl implements BeerRepository {
  @override
  Future<List> getBeers() async {
    var response = await http.get(ApiUrl.url);
    var data = json.decode(response.body);
    return data;
  }
}

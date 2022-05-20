import 'dart:convert';

import 'package:star_war_api/features/people/data/models/people_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';

abstract class PeopleRemoteDataSource {
  /// Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<PeopleModel>> getPeopleList();
}

class PeopleRemoteDataSourceImpl implements PeopleRemoteDataSource {
  final http.Client client;
  PeopleRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PeopleModel>> getPeopleList() async {
    final response = await client
        .get(Uri.parse('https://swapi.dev/api/people/?page=1'), headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      Iterable p = json['results'];
      List<PeopleModel> list =
          List<PeopleModel>.from(p.map((e) => PeopleModel.fromJson(e)));
      // return PeopleModel.fromJson(singlePeople);
      print(list);
      return list;
    } else {
      throw ServerException();
    }
  }
}

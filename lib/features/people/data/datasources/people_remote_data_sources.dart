import 'dart:convert';

import 'package:star_war_api/features/people/data/models/people_model.dart';
import 'package:http/http.dart' as http;
import 'package:star_war_api/features/people/domain/entities/people.dart';
import 'package:star_war_api/features/people/domain/usecases/get_people_list.dart';

import '../../../../core/error/exceptions.dart';

abstract class PeopleRemoteDataSource {
  /// Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<PeopleResponse> getPeopleList(Params params);
}

class PeopleRemoteDataSourceImpl implements PeopleRemoteDataSource {
  final http.Client client;
  PeopleRemoteDataSourceImpl({required this.client});

  @override
  Future<PeopleResponse> getPeopleList(Params params) async {
    final response = await client.get(
        Uri.parse(
            'https://swapi.dev/api/people/?page=${params.pageIndex}&${params.limit}'),
        headers: {
          'Content-Type': 'application/json',
        });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      Iterable p = json['results'];
      final totalItem = json['count'];
      List<People> list =
          List<People>.from(p.map((e) => PeopleModel.fromJson(e)));
      // return PeopleModel.fromJson(singlePeople);
      print(list);
      PeopleResponse peopleResponse =
          PeopleResponse(peoples: list, totalItem: totalItem);
      return peopleResponse;
    } else {
      throw ServerException();
    }
  }
}

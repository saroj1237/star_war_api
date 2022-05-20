import 'package:dartz/dartz.dart';
import 'package:star_war_api/features/people/domain/usecases/get_people_list.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/people_model.dart';

abstract class PeopleRepository {
  Future<Either<Failure, PeopleResponse>> getPeopleList(Params params);
}
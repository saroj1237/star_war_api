import 'package:dartz/dartz.dart';
import 'package:star_war_api/features/people/domain/entities/people.dart';

import '../../../../core/error/failures.dart';

abstract class PeopleRepository {
  Future<Either<Failure, List<People>>> getPeopleList();
}
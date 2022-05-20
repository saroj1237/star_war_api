import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/people.dart';
import '../repositories/people_repository.dart';

class GetPeopleList implements UseCase<People, NoParams> {
  final PeopleRepository repository;
  GetPeopleList(this.repository);
  @override
  Future<Either<Failure, People>> call(NoParams params) async {
    return await repository.getPeopleList();
  }
}

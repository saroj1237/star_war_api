import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:star_war_api/features/people/data/models/people_model.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/people.dart';
import '../repositories/people_repository.dart';

class GetPeopleList implements UseCase<PeopleResponse, Params> {
  final PeopleRepository repository;
  GetPeopleList(this.repository);
  @override
  Future<Either<Failure, PeopleResponse>> call(Params params) async {
    return await repository.getPeopleList(params);
  }
}

class Params extends Equatable {
  final int pageIndex;
  final int limit;
  Params({required this.pageIndex,required this.limit});
  @override
  List<Object?> get props => [pageIndex, limit];
}

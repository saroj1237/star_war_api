import 'package:star_war_api/core/error/exceptions.dart';
import 'package:star_war_api/features/people/data/datasources/people_remote_data_sources.dart';
import 'package:star_war_api/features/people/domain/entities/people.dart';
import 'package:star_war_api/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:star_war_api/features/people/domain/repositories/people_repository.dart';
import 'package:star_war_api/features/people/domain/usecases/get_people_list.dart';

import '../../../../core/network/network_info.dart';
import '../models/people_model.dart';

class PeopleRepositoryImpl implements PeopleRepository {
  final PeopleRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  PeopleRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, PeopleResponse>> getPeopleList(Params params) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.getPeopleList(params));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}

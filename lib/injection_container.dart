import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:star_war_api/core/network/network_info.dart';
import 'package:star_war_api/features/people/data/datasources/people_remote_data_sources.dart';
import 'package:star_war_api/features/people/data/repositories/people_repository_impl.dart';
import 'package:star_war_api/features/people/domain/repositories/people_repository.dart';
import 'package:star_war_api/features/people/domain/usecases/get_people_list.dart';
import 'package:star_war_api/features/people/presentation/bloc/people_bloc.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
//  Feature 1. People
// Bloc
  sl.registerFactory(() => PeopleBloc(getPeopleList: sl()));
// usecases
  sl.registerLazySingleton(() => GetPeopleList(sl()));
// repositories
  sl.registerLazySingleton<PeopleRepository>(
      () => PeopleRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  // datasources
  sl.registerLazySingleton<PeopleRemoteDataSource>(
      () => PeopleRemoteDataSourceImpl(client: sl()));
  // core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  //external
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}

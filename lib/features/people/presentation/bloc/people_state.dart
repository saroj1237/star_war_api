part of 'people_bloc.dart';

abstract class PeopleState extends Equatable {
  const PeopleState();

  @override
  List<Object> get props => [];
}

class PeopleInitial extends PeopleState {}

class PeopleLoading extends PeopleState {}

class PeopleLoaded extends PeopleState {
  final List<People> people;
  const PeopleLoaded({required this.people});
}

class PeopleError extends PeopleState {
  final String error;
  PeopleError({this.error = 'Something went wrong'});
}

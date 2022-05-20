part of 'people_bloc.dart';

abstract class PeopleEvent extends Equatable {
  const PeopleEvent();

  @override
  List<Object> get props => [];
}

class GetPeopleEvent extends PeopleEvent {}

class GetMorePeopleEvent extends PeopleEvent {}

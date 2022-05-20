import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:star_war_api/core/error/failures.dart';
import 'package:star_war_api/core/usecases/usecases.dart';
import 'package:star_war_api/features/people/data/models/people_model.dart';
import 'package:star_war_api/features/people/domain/entities/people.dart';

import '../../domain/usecases/get_people_list.dart';

part 'people_event.dart';
part 'people_state.dart';

class PeopleBloc extends Bloc<PeopleEvent, PeopleState> {
  final GetPeopleList getPeopleList;
  PeopleBloc({required this.getPeopleList}) : super(PeopleInitial()) {
    on<GetPeopleEvent>(_onGetPeopleEvent);
  }
  _onGetPeopleEvent(GetPeopleEvent event, Emitter<PeopleState> emit) async {
    emit(PeopleLoading());
    final failureOrPeople = await getPeopleList(NoParams());
    failureOrPeople.fold((failure) {
      emit(PeopleError());
    }, (people) {
      emit(PeopleLoaded(people: people));
    });
  }
}

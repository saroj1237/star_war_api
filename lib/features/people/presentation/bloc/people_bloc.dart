import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:star_war_api/features/people/domain/entities/people.dart';

import '../../domain/usecases/get_people_list.dart';

part 'people_event.dart';
part 'people_state.dart';

class PeopleBloc extends Bloc<PeopleEvent, PeopleState> {
  final GetPeopleList getPeopleList;
  int totalCount = 0;
  int pageIndex = 1;
  int limit = 10;
  List<People> peopleList = [];
  PeopleBloc({required this.getPeopleList}) : super(PeopleInitial()) {
    on<GetPeopleEvent>(_onGetPeopleEvent);
    on<GetMorePeopleEvent>(_onGetMorePeopleEvent);
  }
  _onGetPeopleEvent(GetPeopleEvent event, Emitter<PeopleState> emit) async {
    emit(PeopleLoading());
    final failureOrPeople =
        await getPeopleList(Params(pageIndex: pageIndex, limit: limit));
    failureOrPeople.fold((failure) {
      emit(PeopleError());
    }, (peopleResponse) {
      pageIndex++;
      totalCount = peopleResponse.totalItem;
      peopleList.addAll(peopleResponse.peoples);
      emit(PeopleLoaded(people: peopleList, showLodingMoreIndicator: false));
    });
  }

  _onGetMorePeopleEvent(
      GetMorePeopleEvent event, Emitter<PeopleState> emit) async {
    final state = this.state;
    if (state is! PeopleLoaded) {
      emit(state);
    } else {
      if (pageIndex * limit < totalCount) {
        emit(PeopleLoaded(people: peopleList, showLodingMoreIndicator: true));
        final failureOrPeople =
            await getPeopleList(Params(pageIndex: pageIndex, limit: limit));
        failureOrPeople.fold((l) {
          emit(state);
        }, (morePeopleResponse) {
          emit(PeopleLoaded(people: peopleList, showLodingMoreIndicator: true));
          List<People> morePeople = morePeopleResponse.peoples;
          peopleList.addAll(morePeople);
          emit(
              PeopleLoaded(people: peopleList, showLodingMoreIndicator: false));
        });
      } else {
        emit(state);
      }
    }
  }
}

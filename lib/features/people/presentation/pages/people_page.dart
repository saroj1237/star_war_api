import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_war_api/features/people/presentation/bloc/people_bloc.dart';

import '../../domain/entities/people.dart';
import '../widgets/people_tile.dart';

class PeoplePage extends StatelessWidget {
  const PeoplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("People"),
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<PeopleBloc, PeopleState>(
        builder: (context, state) {
          if (state is PeopleLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PeopleError) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is PeopleLoaded) {
            return ListView.builder(
                itemCount: state.people.length,
                itemBuilder: (context, index) {
                  People people = state.people[index];
                  return PeopleTile(people: people);
                });
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

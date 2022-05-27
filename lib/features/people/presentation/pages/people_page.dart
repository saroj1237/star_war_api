import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_war_api/features/people/presentation/bloc/people_bloc.dart';

import '../../domain/entities/people.dart';
import '../widgets/people_tile.dart';

class PeoplePage extends StatefulWidget {
  const PeoplePage({Key? key}) : super(key: key);

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  final scrollController = ScrollController();
  @override
  void initState() {
    scrollController.addListener(() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;

      print(maxScroll);
      print('current-> $currentScroll');
      if (currentScroll == maxScroll) {
        print(
            "Start calling api-----------------------------BOttom of list---------");
       
        context.read<PeopleBloc>().add(GetMorePeopleEvent());
        setState(() {});
      }
    });
    super.initState();
  }

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
            return Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Stack(children: [
                ListView.builder(
                    controller: scrollController,
                    itemCount: state.people.length,
                    itemBuilder: (context, index) {
                      People people = state.people[index];
                      return PeopleTile(people: people);
                    }),
                state.showLodingMoreIndicator
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox.shrink()
              ]),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

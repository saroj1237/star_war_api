import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
    ScrollDirection scrollDirection;
    scrollController.addListener(() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;
      scrollDirection = scrollController.position.userScrollDirection;
      if (scrollDirection == ScrollDirection.forward) {
        print("scrolling down");
        visible = false;
        setState(() {});
      } else {
        print('scrolling up');
        visible = true;
        setState(() {});
      }
      if (currentScroll == maxScroll) {
        print(
            "Start calling api-----------------------------BOttom of list---------");

        context.read<PeopleBloc>().add(GetMorePeopleEvent());
        setState(() {});
      }
    });
    super.initState();
  }

  bool visible = false;

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
                    : SizedBox.shrink(),
              ]),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: visible
          ? FloatingActionButton(
              // style: ButtonStyle(
              //     backgroundColor:
              //         MaterialStateProperty.all<Color>(Colors.grey.shade200),
              //     elevation: MaterialStateProperty.all<double>(5),
              //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //       RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(180),
              //         // side: BorderSide(color: Colors.red),
              //       ),
              //     )),
              onPressed: () {},
              child: IconButton(
                icon: Icon(
                  Icons.arrow_upward,
                ),
                onPressed: () {
                  scrollController.animateTo(0,
                      duration: const Duration(seconds: 1),
                      curve: Curves.linear);
                },
              ),
            )
          : null,
    );
  }
}

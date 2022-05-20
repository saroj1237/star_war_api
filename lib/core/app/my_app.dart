import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_war_api/features/people/presentation/pages/people_page.dart';

import '../../features/people/presentation/bloc/people_bloc.dart';
import '../../injection_container.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PeopleBloc>()..add(GetPeopleEvent()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const PeoplePage(),
      ),
    );
  }
}

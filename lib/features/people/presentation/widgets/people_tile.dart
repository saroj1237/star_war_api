import 'package:flutter/material.dart';
import 'package:star_war_api/features/people/domain/entities/people.dart';

class PeopleTile extends StatelessWidget {
  const PeopleTile({Key? key, required this.people}) : super(key: key);
  final People people;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      alignment: Alignment.center,
      child: Text(
        people.name,
      ),
    );
  }
}

import 'package:star_war_api/features/people/domain/entities/people.dart';

class PeopleModel extends People {
  const PeopleModel(
      {required String name, required String height, required String gender})
      : super(name: name, height: height, gender: gender);

  factory PeopleModel.fromJson(Map<String, dynamic> json) {
    return PeopleModel(
      name: json['name'],
      height: json['height'],
      gender: json['gender'],
    );
  }
  // Map<String, dynamic> toJson() {

  // }
}

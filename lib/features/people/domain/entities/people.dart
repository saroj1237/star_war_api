import 'package:equatable/equatable.dart';

class People extends Equatable {
  final String name;
  final String height;
  final String gender;
  const People({
    required this.name,
    required this.gender,
    required this.height,
  });
  @override
  List<Object?> get props => [
        name,
        height,
        gender,
      ];
}

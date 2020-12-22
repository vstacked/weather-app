import 'package:equatable/equatable.dart';

class Params extends Equatable {
  final String country;
  final String state;
  final String city;

  Params({
    this.country,
    this.state,
    this.city,
  });

  @override
  List<Object> get props => [country, state, city];
}

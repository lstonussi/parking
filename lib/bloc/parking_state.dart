part of 'parking_bloc.dart';

abstract class ParkingState extends Equatable {
  const ParkingState();

  @override
  List<Object> get props => [];
}

class Idle extends ParkingState {}

class Loading extends ParkingState {}

class Loaded extends ParkingState {}

class NotConfigured extends ParkingState {}

class AlreadyConfigured extends ParkingState {}

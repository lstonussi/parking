part of 'parking_bloc.dart';

abstract class ParkingEvent extends Equatable {
  const ParkingEvent();

  @override
  List<Object> get props => [];
}

class SaveConfigForm extends ParkingEvent {
  const SaveConfigForm({
    required this.name,
    required this.parkingSpace,
  });

  final String name;
  final int parkingSpace;

  @override
  String toString() => 'SaveConfigForm';
}

class IsAlreadyConfigured extends ParkingEvent {
  @override
  String toString() => 'IsAlreadyConfigured';
}

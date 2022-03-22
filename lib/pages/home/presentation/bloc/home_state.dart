import 'package:equatable/equatable.dart';
import 'package:parking/domain/models/parking_lots.dart';
import 'package:parking/pages/home/presentation/bloc/_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class Idle extends HomeState {}

class Loading extends HomeState {}

class ViewChanged extends HomeState {
  const ViewChanged({
    required this.typeView,
  });
  final TypeView typeView;
}

class LoadedParkingLots extends HomeState {
  const LoadedParkingLots({
    required this.parkingLots,
  });
  final List<ParkingLots> parkingLots;
}

class SavedNewCar extends HomeState {}

class Error extends HomeState {}

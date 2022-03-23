import 'package:equatable/equatable.dart';
import 'package:parking/domain/models/parking_space_model.dart';
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

class LoadedParkingSpace extends HomeState {
  const LoadedParkingSpace({
    required this.parkingSpace,
  });
  final List<ParkingSpaceModel> parkingSpace;
}

class SavedNewCar extends HomeState {}

class UpdatedDate extends HomeState {}

class Error extends HomeState {}

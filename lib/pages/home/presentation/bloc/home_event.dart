import 'package:equatable/equatable.dart';
import 'package:parking/pages/home/presentation/bloc/home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class NewCarEntry extends HomeEvent {
  const NewCarEntry({
    required this.plate,
    required this.modelCar,
    required this.spaceParkingCode,
    required this.entryHour,
  });
  final String plate;
  final String modelCar;
  final int spaceParkingCode;
  final DateTime entryHour;
}

class ChangeView extends HomeEvent {
  const ChangeView({
    required this.typeView,
  });
  final TypeView typeView;
}

class RefreshList extends HomeEvent {}

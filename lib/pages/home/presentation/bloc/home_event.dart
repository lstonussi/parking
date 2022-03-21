import 'package:equatable/equatable.dart';
import 'package:parking/pages/home/presentation/bloc/home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class NewCar extends HomeEvent {}

class ChangeView extends HomeEvent {
  const ChangeView({
    required this.typeView,
  });
  final TypeView typeView;
}

class RefreshList extends HomeEvent {}

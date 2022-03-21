import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:parking/pages/home/presentation/bloc/_bloc.dart';
import 'package:parking/repositories/parking_lots_repository.dart';

enum TypeView {
  compact,
  detail,
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this.parkingLotsRepository,
  }) : super(Idle()) {
    on<NewCar>(_onNewCar);
    on<RefreshList>(_onRefreshList);
    on<ChangeView>(_onChangeView);
  }

  final ParkingLotsRepository parkingLotsRepository;

  Future<void> _onNewCar(NewCar event, Emitter<HomeState> emit) async {}

  Future<void> _onChangeView(ChangeView event, Emitter<HomeState> emit) async {
    final type = TypeView.values.indexOf(event.typeView);
    if (type == 0) {
      emit(const ViewChanged(typeView: TypeView.detail));
    } else {
      emit(const ViewChanged(typeView: TypeView.compact));
    }
  }

  Future<void> _onRefreshList(
      RefreshList event, Emitter<HomeState> emit) async {
    emit(Loading());
    final resultOrFailure = await parkingLotsRepository.getAll();
    emit(
      resultOrFailure.fold(
        (error) => Error(),
        (list) => Loaded(
          parkingLots: list,
        ),
      ),
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parking/repositories/parking_config_repository.dart';

part 'parking_event.dart';
part 'parking_state.dart';

class ParkingBloc extends Bloc<ParkingEvent, ParkingState> {
  ParkingBloc({
    required this.parkingConfigRepository,
  }) : super(Idle()) {
    on<IsAlreadyConfigured>(_onIsAlreadyConfigured);
    on<SaveConfigForm>(_onSavedForm);
  }

  final ParkingConfigRepository parkingConfigRepository;

  Future<void> _onSavedForm(
      SaveConfigForm event, Emitter<ParkingState> emit) async {
    emit(Loading());

    final resultOrFailure = await parkingConfigRepository.insert(
      name: event.name,
      quantitySpace: event.parkingSpace,
    );

    resultOrFailure.fold(
      (error) => emit(SaveError()),
      (parkingConfig) {
        emit(Saved());
      },
    );
  }

  Future<void> _onIsAlreadyConfigured(
      ParkingEvent event, Emitter<ParkingState> emit) async {
    emit(Loading());
    final resultOrFailure = await parkingConfigRepository.getConfig();
    resultOrFailure.fold(
      (error) => null,
      (parkingConfig) {
        if (parkingConfig.id == null) {
          emit(NotConfigured());
        } else {
          emit(AlreadyConfigured());
        }
      },
    );
  }
}

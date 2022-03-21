import 'package:bloc/bloc.dart';
import 'package:parking/pages/config/presentation/bloc/_bloc.dart';
import 'package:parking/repositories/parking_config_repository.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  ConfigBloc({
    required this.parkingConfigRepository,
  }) : super(Idle()) {
    on<IsAlreadyConfigured>(_onIsAlreadyConfigured);
    on<SaveConfigForm>(_onSavedForm);
  }

  final ParkingConfigRepository parkingConfigRepository;

  Future<void> _onSavedForm(
      SaveConfigForm event, Emitter<ConfigState> emit) async {
    emit(Loading());

    final resultOrFailure = await parkingConfigRepository.insert(
      name: event.name,
      quantitySpace: event.quantitySpace,
    );

    resultOrFailure.fold(
      (error) => emit(SaveError()),
      (parkingConfig) {
        emit(
          AlreadyConfigured(
            name: event.name,
            quantitySpace: event.quantitySpace,
          ),
        );
      },
    );
  }

  Future<void> _onIsAlreadyConfigured(
      ConfigEvent event, Emitter<ConfigState> emit) async {
    emit(Loading());
    final resultOrFailure = await parkingConfigRepository.getConfig();
    resultOrFailure.fold(
      (error) => null,
      (parkingConfig) {
        if (parkingConfig.id != null &&
            parkingConfig.name != null &&
            parkingConfig.spaceQuantity != null) {
          emit(
            AlreadyConfigured(
              name: parkingConfig.name!,
              quantitySpace: parkingConfig.spaceQuantity!,
            ),
          );
        } else {
          emit(NotConfigured());
        }
      },
    );
  }
}

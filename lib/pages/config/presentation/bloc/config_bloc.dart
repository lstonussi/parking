import 'package:bloc/bloc.dart';
import 'package:parking/pages/config/data/repositories/parking_config_repository_impl.dart';
import 'package:parking/pages/config/presentation/bloc/_bloc.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  ConfigBloc({
    required this.parkingConfigRepository,
  }) : super(Idle()) {
    on<IsAlreadyConfigured>(_onIsAlreadyConfigured);
    on<SaveConfigForm>(_onSavedForm);
  }

  final ParkingConfigRepositoryImpl parkingConfigRepository;

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
    emit(
      resultOrFailure.fold(
        (error) => Error(),
        (parkingConfig) {
          if (parkingConfig.id != null &&
              parkingConfig.name != null &&
              parkingConfig.spaceQuantity != null) {
            return AlreadyConfigured(
              name: parkingConfig.name!,
              quantitySpace: parkingConfig.spaceQuantity!,
            );
          } else {
            return NotConfigured();
          }
        },
      ),
    );
  }
}

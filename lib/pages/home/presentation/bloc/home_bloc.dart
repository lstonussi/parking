import 'package:bloc/bloc.dart';
import 'package:parking/domain/models/parking_space_model.dart';
import 'package:parking/pages/home/presentation/bloc/_bloc.dart';
import 'package:parking/pages/home/data/repositories/parking_space_repository_impl.dart';

enum TypeView {
  compact,
  detail,
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this.parkingSpaceRepository,
  }) : super(Idle()) {
    on<NewCarEntry>(_onNewCar);
    on<DepartureCar>(_onDepartureCar);
    on<RefreshList>(_onRefreshList);
    on<ChangeView>(_onChangeView);
  }

  final ParkingSpaceRepositoryImpl parkingSpaceRepository;

  Future<void> _onNewCar(NewCarEntry event, Emitter<HomeState> emit) async {
    emit(Loading());

    final resultOrFailure = await parkingSpaceRepository.insert(
      parkingConfig: ParkingSpaceModel(
        plate: event.plate,
        modelCar: event.modelCar,
        spaceParkingCode: event.spaceParkingCode,
        entryDateTime: event.entryHour,
        departureDateTime: null,
      ),
    );
    emit(
      resultOrFailure.fold(
        (error) => Error(),
        (list) => SavedNewCar(),
      ),
    );
  }

  Future<void> _onChangeView(ChangeView event, Emitter<HomeState> emit) async {
    emit(
      event.typeView == TypeView.detail
          ? const ViewChanged(typeView: TypeView.compact)
          : const ViewChanged(typeView: TypeView.detail),
    );
  }

  Future<void> _onDepartureCar(
      DepartureCar event, Emitter<HomeState> emit) async {
    emit(Loading());
    final resultOrFailure = await parkingSpaceRepository.updateDate(
      parkingSpaceModel: ParkingSpaceModel(
        id: event.id,
        plate: 'plate',
        spaceParkingCode: 0,
        modelCar: 'modelCar',
        entryDateTime: DateTime.now(),
        departureDateTime: event.departureDateTime,
      ),
    );
    emit(
      resultOrFailure.fold(
        (error) => Error(),
        (list) => UpdatedDate(),
      ),
    );
  }

  Future<void> _onRefreshList(
      RefreshList event, Emitter<HomeState> emit) async {
    emit(Loading());
    final resultOrFailure = await parkingSpaceRepository.getAll();
    emit(
      resultOrFailure.fold(
        (error) => Error(),
        (list) => LoadedParkingSpace(
          parkingSpace: list,
          typeView: event.typeView,
        ),
      ),
    );
  }
}

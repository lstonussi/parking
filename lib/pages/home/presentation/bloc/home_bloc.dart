import 'package:bloc/bloc.dart';
import 'package:parking/domain/models/parking_space_model.dart';
import 'package:parking/pages/home/presentation/bloc/_bloc.dart';
import 'package:parking/repositories/parking_space_repository.dart';

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

  final ParkingSpaceRepository parkingSpaceRepository;

  Future<void> _onNewCar(NewCarEntry event, Emitter<HomeState> emit) async {
    emit(Loading());

    final resultOrFailure = await parkingSpaceRepository.insert(
      ParkingSpaceModel(
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
    final type = TypeView.values.indexOf(event.typeView);
    if (type == 0) {
      emit(const ViewChanged(typeView: TypeView.detail));
    } else {
      emit(const ViewChanged(typeView: TypeView.compact));
    }
  }

  Future<void> _onDepartureCar(
      DepartureCar event, Emitter<HomeState> emit) async {
    emit(Loading());
    final resultOrFailure = await parkingSpaceRepository.updateDate(
      ParkingSpaceModel(
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
        ),
      ),
    );
  }
}

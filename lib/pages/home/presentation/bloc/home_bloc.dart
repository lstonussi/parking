import 'package:bloc/bloc.dart';
import 'package:parking/pages/home/presentation/bloc/_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(Idle()) {
    on<NewCar>(_onNewCar);
  }

  Future<void> _onNewCar(NewCar event, Emitter<HomeState> emit) async {
    emit(Idle());
  }
}

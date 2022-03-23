import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/pages/home/presentation/bloc/_bloc.dart';
import 'package:parking/pages/home/presentation/notifiers/parking_space_notifier.dart';
import 'package:parking/pages/home/presentation/widgets/parking_space_grid_widget.dart';
import 'package:parking/pages/home/presentation/widgets/parking_space_widget.dart';
import 'package:parking/pages/home/utils/entry_bottom_sheet.dart';

TypeView typeView = TypeView.detail;

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    required this.name,
    required this.quantitySpace,
  }) : super(key: key);

  final String name;
  final int quantitySpace;

  @override
  Widget build(BuildContext context) {
    final _bloc = context.read<HomeBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                showEntryBottomSheet(context: context);
              }),
          IconButton(
            icon: const Icon(Icons.view_comfortable),
            onPressed: () {
              _bloc.add(ChangeView(typeView: typeView));
            },
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previousState, state) => previousState != state,
        builder: (context, state) {
          if (state is Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is SavedNewCar || state is UpdatedDate) {
            _bloc.add(RefreshList());
          }

          if (state is LoadedParkingSpace) {
            context
                .read<ParkingSpaceNotifier>()
                .onListRecieve(state.parkingSpace);
            final listWidget = List.generate(
              quantitySpace,
              (index) {
                return ParkingSpace(
                  index: index,
                  parkingSpace: state.parkingSpace,
                );
              },
            );

            return LayoutBuilder(
              builder: (_, contraints) => Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: (contraints.maxWidth * .1),
                ),
                child: ParkingSpaceGrid(
                  listParkingSpace: listWidget,
                  avaibleLots: quantitySpace -
                      state.parkingSpace
                          .where((element) => element.departureDateTime == null)
                          .length,
                ),
              ),
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

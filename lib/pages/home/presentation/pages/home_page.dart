import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/pages/home/presentation/bloc/_bloc.dart';
import 'package:parking/pages/home/presentation/notifiers/parking_space_notifier.dart';
import 'package:parking/pages/home/presentation/widgets/parking_space_grid_widget.dart';
import 'package:parking/pages/home/presentation/widgets/parking_space_widget.dart';
import 'package:parking/pages/home/utils/entry_bottom_sheet.dart';
import 'package:parking/pages/report/presentation/pages/report_page.dart';

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
    final notifier = context.read<ParkingSpaceNotifier>();
    TypeView typeView = TypeView.compact;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(name),
        actions: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                showEntryBottomSheet(context: context);
              }),
          IconButton(
            icon: const Icon(Icons.text_increase),
            onPressed: () {
              _bloc.add(ChangeView(typeView: typeView));
            },
          ),
          IconButton(
            icon: const Icon(Icons.insert_chart_outlined_sharp),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReportPage(
                    parkingSpace: notifier.list,
                  ),
                ),
              );
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

          if (state is ViewChanged) {
            typeView = state.typeView;
            _bloc.add(RefreshList(typeView: state.typeView));
          }

          if (state is SavedNewCar || state is UpdatedDate) {
            _bloc.add(const RefreshList());
          }

          if (state is LoadedParkingSpace) {
            if (state.typeView != null) {
              typeView = state.typeView!;
            }
            context
                .read<ParkingSpaceNotifier>()
                .onListRecieve(state.parkingSpace);
            final listWidget = List.generate(
              quantitySpace,
              (index) {
                return ParkingSpace(
                  typeView: typeView,
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
                  typeView: typeView,
                  listParkingSpace: listWidget,
                  avaibleLots: quantitySpace -
                      state.parkingSpace
                          .where((element) => element.departureDateTime == null)
                          .length,
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

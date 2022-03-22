import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/pages/home/presentation/bloc/_bloc.dart';
import 'package:parking/pages/home/presentation/widgets/parking_space.dart';
import 'package:parking/pages/home/utils/entry_bottom_sheet.dart';
import 'package:parking/values/app_texts.dart';

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
              showEntryBottomSheet(context, _bloc);
            },
          ),
          IconButton(
            icon: const Icon(Icons.view_comfortable),
            onPressed: () {
              _bloc.add(ChangeView(typeView: typeView));
            },
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          print('{state: $state}');
          if (state is Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SavedNewCar) {
            _bloc.add(RefreshList());
          }
          if (state is LoadedParkingLots) {
            final listWidget = List.generate(
              30,
              (index) {
                return ParkingSpace(
                  index: index,
                  parkingLots: state.parkingLots,
                );
              },
            );
            // if (state is ViewChanged) {
            //   typeView = state.typeView;
            // }
            print(listWidget);
            return LayoutBuilder(
              builder: (_, contraints) => Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: (contraints.maxWidth * .1),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: [
                          Center(
                            child: Text(
                              '${AppTexts.parkingSpaceAvaible} ${(quantitySpace - state.parkingLots.length).toString()}',
                            ),
                          ),
                          GridView.count(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            children: listWidget,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Container(color: Colors.red);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:parking/pages/home/presentation/bloc/_bloc.dart';
import 'package:parking/pages/home/presentation/widgets/parking_space.dart';
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
    final _formKey = GlobalKey<FormState>();
    final FocusNode _plateFocus = FocusNode(),
        _modelCarFocus = FocusNode(),
        _entryHourFocus = FocusNode(),
        _departureHourFocus = FocusNode();
    final TextEditingController _plateController = TextEditingController(),
        _modelCarController = TextEditingController(),
        _entryHourController = TextEditingController(),
        _departureController = TextEditingController();
    DateFormat dateFormat = DateFormat("HH:mm:ss");
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                useRootNavigator: true,
                enableDrag: true,
                builder: (_) => SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: Container(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom +
                                        100),
                            child: Column(
                              children: [
                                TextFormField(
                                  focusNode: _plateFocus,
                                  controller: _plateController,
                                  decoration: const InputDecoration(
                                    label: Text(AppTexts.plate),
                                  ),
                                  validator: (value) {
                                    // return validateFormName(value);
                                  },
                                ),
                                TextFormField(
                                  focusNode: _modelCarFocus,
                                  controller: _modelCarController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    label: Text(AppTexts.modelCar),
                                  ),
                                  validator: (value) {
                                    // return validateFormQuantity(value);
                                  },
                                ),
                                TextFormField(
                                  focusNode: _entryHourFocus,
                                  controller: _entryHourController,
                                  keyboardType: TextInputType.datetime,
                                  initialValue: dateFormat
                                      .format(DateTime.now())
                                      .toString(),
                                  decoration: const InputDecoration(
                                    label: Text(AppTexts.entryHour),
                                  ),
                                  validator: (value) {
                                    // return validateFormQuantity(value);
                                  },
                                ),
                                // TextFormField(
                                //   focusNode: _departureHourFocus,
                                //   controller: _departureController,
                                //   keyboardType: TextInputType.number,
                                //   decoration: const InputDecoration(
                                //     label: Text(AppTexts.departureHour),
                                //   ),
                                //   validator: (value) {
                                //     // return validateFormQuantity(value);
                                //   },
                                // ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.amber,
                                    fixedSize: const Size(81, 48),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      //   _bloc.add(
                                      //     SaveConfigForm(
                                      //       name: _nameController.text,
                                      //       quantitySpace: int.parse(_quantityController.text),
                                      //     ),
                                      //   );
                                    }
                                  },
                                  child: const Text(
                                    AppTexts.save,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );

              // _bloc.add(NewCar());
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
          if (state is Loaded) {
            // if (state is ViewChanged) {
            //   typeView = state.typeView;
            // }
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
                              '${AppTexts.parkingSpaceAvaible} ${quantitySpace.toString()}',
                            ),
                          ),
                          GridView.builder(
                            physics: const ScrollPhysics(),
                            itemCount: quantitySpace,
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  (typeView == TypeView.detail) ? 2 : 3,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return ParkingSpace(
                                index: index,
                                parkingLots: state.parkingLots,
                              );
                            },
                          ),
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

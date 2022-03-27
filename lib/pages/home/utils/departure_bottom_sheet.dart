import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:parking/commons/button_widget.dart';
import 'package:parking/domain/models/parking_space_model.dart';
import 'package:parking/pages/home/presentation/bloc/_bloc.dart';
import 'package:parking/utils/validators.dart';
import 'package:parking/values/app_texts.dart';
import 'package:provider/provider.dart';

void showDepartureBottomSheet({
  required BuildContext context,
  ParkingSpaceModel? parkingSpace,
}) {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _departureHourFocus = FocusNode();
  final TextEditingController _departureController = TextEditingController();
  DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
  _departureController.text = dateFormat.format(DateTime.now());

  final _bloc = context.read<HomeBloc>();
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
                  bottom: MediaQuery.of(context).viewInsets.bottom + 500,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${AppTexts.wantToExitTheCar} ${parkingSpace!.plate}?',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    DateTimeField(
                      focusNode: _departureHourFocus,
                      controller: _departureController,
                      validator: (value) {
                        return validateFormEmptyText(value.toString());
                      },
                      format: DateFormat('dd/MM/yyyy HH:mm:ss'),
                      onShowPicker:
                          (BuildContext context, DateTime? currentValue) async {
                        final date = await showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                        if (date != null) {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                                currentValue ?? DateTime.now()),
                          );
                          return DateTimeField.combine(date, time);
                        } else {
                          return currentValue;
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ButtonWidget(
                        key: const Key('DepartureSaveKey'),
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _bloc.add(
                              DepartureCar(
                                id: parkingSpace.id!,
                                departureDateTime:
                                    dateFormat.parse(_departureController.text),
                              ),
                            );
                            _departureController.clear();
                            Navigator.pop(context);
                          }
                        },
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
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

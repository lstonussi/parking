import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:parking/commons/button_widget.dart';
import 'package:parking/pages/home/presentation/bloc/_bloc.dart';
import 'package:parking/pages/home/presentation/notifiers/parking_space_notifier.dart';
import 'package:parking/utils/validators.dart';
import 'package:parking/values/app_texts.dart';
import 'package:provider/provider.dart';

void showEntryBottomSheet({
  required BuildContext context,
  int? parkingSpace,
}) {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _plateFocus = FocusNode(),
      _modelCarFocus = FocusNode(),
      _entryHourFocus = FocusNode(),
      _spaceParkingCodeFocus = FocusNode();

  final TextEditingController _plateController = TextEditingController(),
      _modelCarController = TextEditingController(),
      _entryHourController = TextEditingController(),
      _spaceParkingCodeController = TextEditingController();

  DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
  final parkingNotifier = context.read<ParkingSpaceNotifier>();
  _entryHourController.text = dateFormat.format(DateTime.now());
  if (parkingSpace != null) {
    _spaceParkingCodeController.text = parkingSpace.toString();
  }
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
                    TextFormField(
                      key: const Key('EntryBottomSheetPlate'),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      focusNode: _plateFocus,
                      controller: _plateController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        label: Text(AppTexts.plate),
                      ),
                      validator: (value) {
                        return validateFormEmptyText(value);
                      },
                    ),
                    TextFormField(
                      key: const Key('EntryBottomSheetModelCar'),
                      focusNode: _modelCarFocus,
                      controller: _modelCarController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        label: Text(AppTexts.modelCar),
                      ),
                      validator: (value) {
                        return validateFormEmptyText(value);
                      },
                    ),
                    TextFormField(
                      key: const Key('EntryBottomSheetParkingCode'),
                      focusNode: _spaceParkingCodeFocus,
                      controller: _spaceParkingCodeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text(AppTexts.spaceParkingCode),
                      ),
                      validator: (value) {
                        return validateFormEmptyText(value);
                      },
                    ),
                    DateTimeField(
                      key: const Key('EntryBottomSheetEntryHour'),
                      focusNode: _entryHourFocus,
                      controller: _entryHourController,
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
                          key: const Key('EntrySave'),
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              if (parkingNotifier.verifyParkingSpace(
                                      index: int.parse(
                                              _spaceParkingCodeController
                                                  .text) -
                                          1) >
                                  -1) {
                                await showDialog(
                                  context: context,
                                  builder: (context) => const AlertDialog(
                                    content:
                                        Text(AppTexts.parkingSpaceOccupied),
                                  ),
                                );
                                return;
                              }
                              _bloc.add(
                                NewCarEntry(
                                  plate: _plateController.text,
                                  modelCar: _modelCarController.text,
                                  spaceParkingCode: int.parse(
                                    _spaceParkingCodeController.text,
                                  ),
                                  entryHour: dateFormat.parse(
                                    _entryHourController.text,
                                  ),
                                ),
                              );
                              _plateController.clear();
                              _modelCarController.clear();
                              _entryHourController.clear();
                              _spaceParkingCodeController.clear();
                              Navigator.pop(context);
                            }
                          }),
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

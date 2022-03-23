import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parking/domain/models/parking_space_model.dart';
import 'package:parking/values/app_texts.dart';

class ReportPage extends StatelessWidget {
  ReportPage({
    Key? key,
    required this.parkingSpace,
  }) : super(key: key);

  final List<ParkingSpaceModel> parkingSpace;
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss');

  @override
  Widget build(BuildContext context) {
    final myList = List<TableRow>.generate(
      parkingSpace.length,
      (index) {
        final lot = parkingSpace[index];
        return TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(lot.id.toString(), textAlign: TextAlign.center),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(lot.spaceParkingCode.toString(),
                  textAlign: TextAlign.center),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(lot.plate, textAlign: TextAlign.center),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(lot.modelCar, textAlign: TextAlign.center),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(dateFormat.format(lot.entryDateTime),
                  textAlign: TextAlign.center),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: lot.departureDateTime == null
                  ? const Text('')
                  : Text(dateFormat.format(lot.departureDateTime!),
                      textAlign: TextAlign.center),
            ),
          ],
        );
      },
      growable: false,
    );
    const title = TableRow(
      children: [
        Padding(
          padding: EdgeInsets.all(5.0),
          child: Text('ID', textAlign: TextAlign.center),
        ),
        Padding(
          padding: EdgeInsets.all(5.0),
          child: Text(AppTexts.spaceParkingCode, textAlign: TextAlign.center),
        ),
        Padding(
          padding: EdgeInsets.all(5.0),
          child: Text(AppTexts.plate, textAlign: TextAlign.center),
        ),
        Padding(
          padding: EdgeInsets.all(5.0),
          child: Text(AppTexts.modelCar, textAlign: TextAlign.center),
        ),
        Padding(
          padding: EdgeInsets.all(5.0),
          child: Text(AppTexts.entryHour, textAlign: TextAlign.center),
        ),
        Padding(
          padding: EdgeInsets.all(5.0),
          child: Text(AppTexts.departureHour, textAlign: TextAlign.center),
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTexts.report),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Table(
              defaultColumnWidth: const IntrinsicColumnWidth(),
              border: TableBorder.all(color: Colors.black),
              children: [
                ...[title],
                ...myList
              ],
            ),
          ),
        ),
      ),
    );
  }
}

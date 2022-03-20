import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'parking_lots.g.dart';

@JsonSerializable()
class ParkingLots extends Equatable {
  const ParkingLots({
    required this.id,
    required this.plate,
    required this.spaceParkingCode,
    required this.modelCar,
    required this.entryDateTime,
    required this.departureDateTime,
  });

  factory ParkingLots.fromJson(Map<String, dynamic> json) =>
      _$ParkingLotsFromJson(json);

  Map<String, dynamic> toJson() => _$ParkingLotsToJson(this);

  final int id;
  final String plate;
  final String spaceParkingCode;
  final String modelCar;
  final DateTime entryDateTime;
  final DateTime departureDateTime;

  @override
  List<Object?> get props =>
      [id, plate, spaceParkingCode, modelCar, entryDateTime, departureDateTime];
}

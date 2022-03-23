import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'parking_space_model.g.dart';

@JsonSerializable()
class ParkingSpaceModel extends Equatable {
  const ParkingSpaceModel({
    this.id,
    required this.plate,
    required this.spaceParkingCode,
    required this.modelCar,
    required this.entryDateTime,
    this.departureDateTime,
  });

  factory ParkingSpaceModel.fromJson(Map<String, dynamic> json) =>
      _$ParkingSpaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ParkingSpaceModelToJson(this);

  final int? id;
  final String plate;
  final int spaceParkingCode;
  final String modelCar;
  final DateTime entryDateTime;
  final DateTime? departureDateTime;

  @override
  List<Object?> get props =>
      [id, plate, spaceParkingCode, modelCar, entryDateTime, departureDateTime];

  ParkingSpaceModel copyWith({
    int? id,
    String? plate,
    int? spaceParkingCode,
    String? modelCar,
    DateTime? entryDateTime,
    DateTime? departureDateTime,
  }) {
    return ParkingSpaceModel(
      id: id ?? this.id,
      plate: plate ?? this.plate,
      spaceParkingCode: spaceParkingCode ?? this.spaceParkingCode,
      modelCar: modelCar ?? this.modelCar,
      entryDateTime: entryDateTime ?? this.entryDateTime,
      departureDateTime: departureDateTime ?? this.departureDateTime,
    );
  }
}

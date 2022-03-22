// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_lots.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingLots _$ParkingLotsFromJson(Map<String, dynamic> json) => ParkingLots(
      id: json['id'] as int?,
      plate: json['plate'] as String,
      spaceParkingCode: json['spaceParkingCode'] as int,
      modelCar: json['modelCar'] as String,
      entryDateTime: DateTime.parse(json['entryDateTime'] as String),
      departureDateTime: json['departureDateTime'] == null
          ? null
          : DateTime.parse(json['departureDateTime'] as String),
    );

Map<String, dynamic> _$ParkingLotsToJson(ParkingLots instance) =>
    <String, dynamic>{
      'id': instance.id,
      'plate': instance.plate,
      'spaceParkingCode': instance.spaceParkingCode,
      'modelCar': instance.modelCar,
      'entryDateTime': instance.entryDateTime.toIso8601String(),
      'departureDateTime': instance.departureDateTime?.toIso8601String(),
    };

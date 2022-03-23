// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_space_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingSpaceModel _$ParkingSpaceModelFromJson(Map<String, dynamic> json) =>
    ParkingSpaceModel(
      id: json['id'] as int?,
      plate: json['plate'] as String,
      spaceParkingCode: json['spaceParkingCode'] as int,
      modelCar: json['modelCar'] as String,
      entryDateTime: DateTime.parse(json['entryDateTime'] as String),
      departureDateTime: json['departureDateTime'] == null
          ? null
          : DateTime.parse(json['departureDateTime'] as String),
    );

Map<String, dynamic> _$ParkingSpaceModelToJson(ParkingSpaceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'plate': instance.plate,
      'spaceParkingCode': instance.spaceParkingCode,
      'modelCar': instance.modelCar,
      'entryDateTime': instance.entryDateTime.toIso8601String(),
      'departureDateTime': instance.departureDateTime?.toIso8601String(),
    };

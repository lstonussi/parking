// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingConfig _$ParkingConfigFromJson(Map<String, dynamic> json) =>
    ParkingConfig(
      id: json['id'] as int?,
      name: json['name'] as String?,
      spaceQuantity: json['spaceQuantity'] as int?,
    );

Map<String, dynamic> _$ParkingConfigToJson(ParkingConfig instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'spaceQuantity': instance.spaceQuantity,
    };

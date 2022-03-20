import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'parking_config.g.dart';

@JsonSerializable()
class ParkingConfig extends Equatable {
  const ParkingConfig({
    required this.id,
    required this.name,
    required this.spaceQuantity,
  });

  factory ParkingConfig.fromJson(Map<String, dynamic> json) =>
      _$ParkingConfigFromJson(json);

  Map<String, dynamic> toJson() => _$ParkingConfigToJson(this);

  final int id;
  final String name;
  final int spaceQuantity;

  @override
  List<Object?> get props => [id, name, spaceQuantity];
}

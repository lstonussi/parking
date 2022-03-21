part of 'config_bloc.dart';

abstract class ConfigEvent extends Equatable {
  const ConfigEvent();

  @override
  List<Object> get props => [];
}

class SaveConfigForm extends ConfigEvent {
  const SaveConfigForm({
    required this.name,
    required this.parkingSpace,
  });

  final String name;
  final int parkingSpace;

  @override
  String toString() => 'SaveConfigForm';
}

class IsAlreadyConfigured extends ConfigEvent {
  @override
  String toString() => 'IsAlreadyConfigured';
}

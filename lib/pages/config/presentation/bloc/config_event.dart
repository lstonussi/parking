import 'package:equatable/equatable.dart';

abstract class ConfigEvent extends Equatable {
  const ConfigEvent();

  @override
  List<Object> get props => [];
}

class SaveConfigForm extends ConfigEvent {
  const SaveConfigForm({
    required this.name,
    required this.quantitySpace,
  });

  final String name;
  final int quantitySpace;

  @override
  String toString() => 'SaveConfigForm';
}

class IsAlreadyConfigured extends ConfigEvent {
  @override
  String toString() => 'IsAlreadyConfigured';
}

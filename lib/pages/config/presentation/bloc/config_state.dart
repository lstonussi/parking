import 'package:equatable/equatable.dart';

abstract class ConfigState extends Equatable {
  const ConfigState();

  @override
  List<Object> get props => [];
}

class Idle extends ConfigState {}

class Loading extends ConfigState {}

class Saved extends ConfigState {}

class SaveError extends ConfigState {}

class Error extends ConfigState {}

class NotConfigured extends ConfigState {}

class AlreadyConfigured extends ConfigState {
  const AlreadyConfigured({
    required this.name,
    required this.quantitySpace,
  });
  final String name;
  final int quantitySpace;
}

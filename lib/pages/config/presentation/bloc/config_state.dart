part of 'config_bloc.dart';

abstract class ConfigState extends Equatable {
  const ConfigState();

  @override
  List<Object> get props => [];
}

class Idle extends ConfigState {}

class Loading extends ConfigState {}

class Saved extends ConfigState {}

class SaveError extends ConfigState {}

class NotConfigured extends ConfigState {}

class AlreadyConfigured extends ConfigState {}

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();

  @override
  List<Object?> get props => [];
}

// General failures

class SaveFailure extends Failure {}

class InsertDataBaseFailure extends Failure {}

class SelectDataBaseFailure extends Failure {}

class DeleteDataBaseFailure extends Failure {}

class GenericFailure extends Failure {
  const GenericFailure({
    this.message,
  });

  final String? message;
}

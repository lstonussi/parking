// Mocks generated by Mockito 5.1.0 from annotations
// in parking/test/pages/config/data/repositories/parking_config_repository_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:parking/data/db/dao/parking_dao.dart' as _i3;
import 'package:parking/domain/models/parking_config.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeParkingConfig_0 extends _i1.Fake implements _i2.ParkingConfig {}

/// A class which mocks [ParkingConfigDAO].
///
/// See the documentation for Mockito's code generation for more information.
class MockParkingConfigDAO extends _i1.Mock implements _i3.ParkingConfigDAO {
  MockParkingConfigDAO() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<int> insert({String? name, int? quantitySpace}) => (super
      .noSuchMethod(
          Invocation.method(
              #insert, [], {#name: name, #quantitySpace: quantitySpace}),
          returnValue: Future<int>.value(0)) as _i4.Future<int>);
  @override
  _i4.Future<_i2.ParkingConfig> getConfig() => (super.noSuchMethod(
          Invocation.method(#getConfig, []),
          returnValue: Future<_i2.ParkingConfig>.value(_FakeParkingConfig_0()))
      as _i4.Future<_i2.ParkingConfig>);
}
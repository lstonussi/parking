// Mocks generated by Mockito 5.1.0 from annotations
// in parking/test/pages/home/presentation/page/home_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:parking/data/db/dao/parking_space_dao.dart' as _i2;
import 'package:parking/domain/models/parking_space_model.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [ParkingSpaceDAO].
///
/// See the documentation for Mockito's code generation for more information.
class MockParkingSpaceDAO extends _i1.Mock implements _i2.ParkingSpaceDAO {
  MockParkingSpaceDAO() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<int> insert(_i4.ParkingSpaceModel? parkingSpaceModel) =>
      (super.noSuchMethod(Invocation.method(#insert, [parkingSpaceModel]),
          returnValue: Future<int>.value(0)) as _i3.Future<int>);
  @override
  _i3.Future<int> updateDate(_i4.ParkingSpaceModel? parkingSpaceModel) =>
      (super.noSuchMethod(Invocation.method(#updateDate, [parkingSpaceModel]),
          returnValue: Future<int>.value(0)) as _i3.Future<int>);
  @override
  _i3.Future<List<_i4.ParkingSpaceModel>> getAll() =>
      (super.noSuchMethod(Invocation.method(#getAll, []),
              returnValue: Future<List<_i4.ParkingSpaceModel>>.value(
                  <_i4.ParkingSpaceModel>[]))
          as _i3.Future<List<_i4.ParkingSpaceModel>>);
  @override
  _i3.Future<int> deleteAll() =>
      (super.noSuchMethod(Invocation.method(#deleteAll, []),
          returnValue: Future<int>.value(0)) as _i3.Future<int>);
}

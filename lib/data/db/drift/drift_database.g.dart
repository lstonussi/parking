// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class ParkingConfigData extends DataClass
    implements Insertable<ParkingConfigData> {
  final int id;
  final String name;
  final int spaceQuantity;
  ParkingConfigData(
      {required this.id, required this.name, required this.spaceQuantity});
  factory ParkingConfigData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ParkingConfigData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      spaceQuantity: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}space_quantity'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['space_quantity'] = Variable<int>(spaceQuantity);
    return map;
  }

  ParkingConfigCompanion toCompanion(bool nullToAbsent) {
    return ParkingConfigCompanion(
      id: Value(id),
      name: Value(name),
      spaceQuantity: Value(spaceQuantity),
    );
  }

  factory ParkingConfigData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ParkingConfigData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      spaceQuantity: serializer.fromJson<int>(json['spaceQuantity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'spaceQuantity': serializer.toJson<int>(spaceQuantity),
    };
  }

  ParkingConfigData copyWith({int? id, String? name, int? spaceQuantity}) =>
      ParkingConfigData(
        id: id ?? this.id,
        name: name ?? this.name,
        spaceQuantity: spaceQuantity ?? this.spaceQuantity,
      );
  @override
  String toString() {
    return (StringBuffer('ParkingConfigData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('spaceQuantity: $spaceQuantity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, spaceQuantity);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ParkingConfigData &&
          other.id == this.id &&
          other.name == this.name &&
          other.spaceQuantity == this.spaceQuantity);
}

class ParkingConfigCompanion extends UpdateCompanion<ParkingConfigData> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> spaceQuantity;
  const ParkingConfigCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.spaceQuantity = const Value.absent(),
  });
  ParkingConfigCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int spaceQuantity,
  })  : name = Value(name),
        spaceQuantity = Value(spaceQuantity);
  static Insertable<ParkingConfigData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? spaceQuantity,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (spaceQuantity != null) 'space_quantity': spaceQuantity,
    });
  }

  ParkingConfigCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<int>? spaceQuantity}) {
    return ParkingConfigCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      spaceQuantity: spaceQuantity ?? this.spaceQuantity,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (spaceQuantity.present) {
      map['space_quantity'] = Variable<int>(spaceQuantity.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ParkingConfigCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('spaceQuantity: $spaceQuantity')
          ..write(')'))
        .toString();
  }
}

class $ParkingConfigTable extends ParkingConfig
    with TableInfo<$ParkingConfigTable, ParkingConfigData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ParkingConfigTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _spaceQuantityMeta =
      const VerificationMeta('spaceQuantity');
  @override
  late final GeneratedColumn<int?> spaceQuantity = GeneratedColumn<int?>(
      'space_quantity', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, spaceQuantity];
  @override
  String get aliasedName => _alias ?? 'parking_config';
  @override
  String get actualTableName => 'parking_config';
  @override
  VerificationContext validateIntegrity(Insertable<ParkingConfigData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('space_quantity')) {
      context.handle(
          _spaceQuantityMeta,
          spaceQuantity.isAcceptableOrUnknown(
              data['space_quantity']!, _spaceQuantityMeta));
    } else if (isInserting) {
      context.missing(_spaceQuantityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ParkingConfigData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ParkingConfigData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ParkingConfigTable createAlias(String alias) {
    return $ParkingConfigTable(attachedDatabase, alias);
  }
}

class ParkingSpaceData extends DataClass
    implements Insertable<ParkingSpaceData> {
  final int id;
  final String plate;
  final int spaceParkingCode;
  final String modelCar;
  final DateTime entryDateTime;
  final DateTime? departureDateTime;
  ParkingSpaceData(
      {required this.id,
      required this.plate,
      required this.spaceParkingCode,
      required this.modelCar,
      required this.entryDateTime,
      this.departureDateTime});
  factory ParkingSpaceData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ParkingSpaceData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      plate: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}plate'])!,
      spaceParkingCode: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}space_parking_code'])!,
      modelCar: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}model_car'])!,
      entryDateTime: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}entry_date_time'])!,
      departureDateTime: const DateTimeType().mapFromDatabaseResponse(
          data['${effectivePrefix}departure_date_time']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['plate'] = Variable<String>(plate);
    map['space_parking_code'] = Variable<int>(spaceParkingCode);
    map['model_car'] = Variable<String>(modelCar);
    map['entry_date_time'] = Variable<DateTime>(entryDateTime);
    if (!nullToAbsent || departureDateTime != null) {
      map['departure_date_time'] = Variable<DateTime?>(departureDateTime);
    }
    return map;
  }

  ParkingSpaceCompanion toCompanion(bool nullToAbsent) {
    return ParkingSpaceCompanion(
      id: Value(id),
      plate: Value(plate),
      spaceParkingCode: Value(spaceParkingCode),
      modelCar: Value(modelCar),
      entryDateTime: Value(entryDateTime),
      departureDateTime: departureDateTime == null && nullToAbsent
          ? const Value.absent()
          : Value(departureDateTime),
    );
  }

  factory ParkingSpaceData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ParkingSpaceData(
      id: serializer.fromJson<int>(json['id']),
      plate: serializer.fromJson<String>(json['plate']),
      spaceParkingCode: serializer.fromJson<int>(json['spaceParkingCode']),
      modelCar: serializer.fromJson<String>(json['modelCar']),
      entryDateTime: serializer.fromJson<DateTime>(json['entryDateTime']),
      departureDateTime:
          serializer.fromJson<DateTime?>(json['departureDateTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'plate': serializer.toJson<String>(plate),
      'spaceParkingCode': serializer.toJson<int>(spaceParkingCode),
      'modelCar': serializer.toJson<String>(modelCar),
      'entryDateTime': serializer.toJson<DateTime>(entryDateTime),
      'departureDateTime': serializer.toJson<DateTime?>(departureDateTime),
    };
  }

  ParkingSpaceData copyWith(
          {int? id,
          String? plate,
          int? spaceParkingCode,
          String? modelCar,
          DateTime? entryDateTime,
          DateTime? departureDateTime}) =>
      ParkingSpaceData(
        id: id ?? this.id,
        plate: plate ?? this.plate,
        spaceParkingCode: spaceParkingCode ?? this.spaceParkingCode,
        modelCar: modelCar ?? this.modelCar,
        entryDateTime: entryDateTime ?? this.entryDateTime,
        departureDateTime: departureDateTime ?? this.departureDateTime,
      );
  @override
  String toString() {
    return (StringBuffer('ParkingSpaceData(')
          ..write('id: $id, ')
          ..write('plate: $plate, ')
          ..write('spaceParkingCode: $spaceParkingCode, ')
          ..write('modelCar: $modelCar, ')
          ..write('entryDateTime: $entryDateTime, ')
          ..write('departureDateTime: $departureDateTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, plate, spaceParkingCode, modelCar, entryDateTime, departureDateTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ParkingSpaceData &&
          other.id == this.id &&
          other.plate == this.plate &&
          other.spaceParkingCode == this.spaceParkingCode &&
          other.modelCar == this.modelCar &&
          other.entryDateTime == this.entryDateTime &&
          other.departureDateTime == this.departureDateTime);
}

class ParkingSpaceCompanion extends UpdateCompanion<ParkingSpaceData> {
  final Value<int> id;
  final Value<String> plate;
  final Value<int> spaceParkingCode;
  final Value<String> modelCar;
  final Value<DateTime> entryDateTime;
  final Value<DateTime?> departureDateTime;
  const ParkingSpaceCompanion({
    this.id = const Value.absent(),
    this.plate = const Value.absent(),
    this.spaceParkingCode = const Value.absent(),
    this.modelCar = const Value.absent(),
    this.entryDateTime = const Value.absent(),
    this.departureDateTime = const Value.absent(),
  });
  ParkingSpaceCompanion.insert({
    this.id = const Value.absent(),
    required String plate,
    required int spaceParkingCode,
    required String modelCar,
    required DateTime entryDateTime,
    this.departureDateTime = const Value.absent(),
  })  : plate = Value(plate),
        spaceParkingCode = Value(spaceParkingCode),
        modelCar = Value(modelCar),
        entryDateTime = Value(entryDateTime);
  static Insertable<ParkingSpaceData> custom({
    Expression<int>? id,
    Expression<String>? plate,
    Expression<int>? spaceParkingCode,
    Expression<String>? modelCar,
    Expression<DateTime>? entryDateTime,
    Expression<DateTime?>? departureDateTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (plate != null) 'plate': plate,
      if (spaceParkingCode != null) 'space_parking_code': spaceParkingCode,
      if (modelCar != null) 'model_car': modelCar,
      if (entryDateTime != null) 'entry_date_time': entryDateTime,
      if (departureDateTime != null) 'departure_date_time': departureDateTime,
    });
  }

  ParkingSpaceCompanion copyWith(
      {Value<int>? id,
      Value<String>? plate,
      Value<int>? spaceParkingCode,
      Value<String>? modelCar,
      Value<DateTime>? entryDateTime,
      Value<DateTime?>? departureDateTime}) {
    return ParkingSpaceCompanion(
      id: id ?? this.id,
      plate: plate ?? this.plate,
      spaceParkingCode: spaceParkingCode ?? this.spaceParkingCode,
      modelCar: modelCar ?? this.modelCar,
      entryDateTime: entryDateTime ?? this.entryDateTime,
      departureDateTime: departureDateTime ?? this.departureDateTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (plate.present) {
      map['plate'] = Variable<String>(plate.value);
    }
    if (spaceParkingCode.present) {
      map['space_parking_code'] = Variable<int>(spaceParkingCode.value);
    }
    if (modelCar.present) {
      map['model_car'] = Variable<String>(modelCar.value);
    }
    if (entryDateTime.present) {
      map['entry_date_time'] = Variable<DateTime>(entryDateTime.value);
    }
    if (departureDateTime.present) {
      map['departure_date_time'] = Variable<DateTime?>(departureDateTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ParkingSpaceCompanion(')
          ..write('id: $id, ')
          ..write('plate: $plate, ')
          ..write('spaceParkingCode: $spaceParkingCode, ')
          ..write('modelCar: $modelCar, ')
          ..write('entryDateTime: $entryDateTime, ')
          ..write('departureDateTime: $departureDateTime')
          ..write(')'))
        .toString();
  }
}

class $ParkingSpaceTable extends ParkingSpace
    with TableInfo<$ParkingSpaceTable, ParkingSpaceData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ParkingSpaceTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _plateMeta = const VerificationMeta('plate');
  @override
  late final GeneratedColumn<String?> plate = GeneratedColumn<String?>(
      'plate', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _spaceParkingCodeMeta =
      const VerificationMeta('spaceParkingCode');
  @override
  late final GeneratedColumn<int?> spaceParkingCode = GeneratedColumn<int?>(
      'space_parking_code', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _modelCarMeta = const VerificationMeta('modelCar');
  @override
  late final GeneratedColumn<String?> modelCar = GeneratedColumn<String?>(
      'model_car', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _entryDateTimeMeta =
      const VerificationMeta('entryDateTime');
  @override
  late final GeneratedColumn<DateTime?> entryDateTime =
      GeneratedColumn<DateTime?>('entry_date_time', aliasedName, false,
          type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _departureDateTimeMeta =
      const VerificationMeta('departureDateTime');
  @override
  late final GeneratedColumn<DateTime?> departureDateTime =
      GeneratedColumn<DateTime?>('departure_date_time', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, plate, spaceParkingCode, modelCar, entryDateTime, departureDateTime];
  @override
  String get aliasedName => _alias ?? 'parking_space';
  @override
  String get actualTableName => 'parking_space';
  @override
  VerificationContext validateIntegrity(Insertable<ParkingSpaceData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('plate')) {
      context.handle(
          _plateMeta, plate.isAcceptableOrUnknown(data['plate']!, _plateMeta));
    } else if (isInserting) {
      context.missing(_plateMeta);
    }
    if (data.containsKey('space_parking_code')) {
      context.handle(
          _spaceParkingCodeMeta,
          spaceParkingCode.isAcceptableOrUnknown(
              data['space_parking_code']!, _spaceParkingCodeMeta));
    } else if (isInserting) {
      context.missing(_spaceParkingCodeMeta);
    }
    if (data.containsKey('model_car')) {
      context.handle(_modelCarMeta,
          modelCar.isAcceptableOrUnknown(data['model_car']!, _modelCarMeta));
    } else if (isInserting) {
      context.missing(_modelCarMeta);
    }
    if (data.containsKey('entry_date_time')) {
      context.handle(
          _entryDateTimeMeta,
          entryDateTime.isAcceptableOrUnknown(
              data['entry_date_time']!, _entryDateTimeMeta));
    } else if (isInserting) {
      context.missing(_entryDateTimeMeta);
    }
    if (data.containsKey('departure_date_time')) {
      context.handle(
          _departureDateTimeMeta,
          departureDateTime.isAcceptableOrUnknown(
              data['departure_date_time']!, _departureDateTimeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ParkingSpaceData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ParkingSpaceData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ParkingSpaceTable createAlias(String alias) {
    return $ParkingSpaceTable(attachedDatabase, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $ParkingConfigTable parkingConfig = $ParkingConfigTable(this);
  late final $ParkingSpaceTable parkingSpace = $ParkingSpaceTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [parkingConfig, parkingSpace];
}

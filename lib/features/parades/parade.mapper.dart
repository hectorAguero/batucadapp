// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'parade.dart';

class ParadeMapper extends ClassMapperBase<Parade> {
  ParadeMapper._();

  static ParadeMapper? _instance;
  static ParadeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ParadeMapper._());
      SchoolDivisionMapper.ensureInitialized();
      SchoolMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Parade';

  static int _$id(Parade v) => v.id;
  static const Field<Parade, int> _f$id = Field('id', _$id);
  static String _$carnivalName(Parade v) => v.carnivalName;
  static const Field<Parade, String> _f$carnivalName =
      Field('carnivalName', _$carnivalName);
  static String _$enredo(Parade v) => v.enredo;
  static const Field<Parade, String> _f$enredo = Field('enredo', _$enredo);
  static List<String> _$carnavalescos(Parade v) => v.carnavalescos;
  static const Field<Parade, List<String>> _f$carnavalescos =
      Field('carnavalescos', _$carnavalescos);
  static String _$division(Parade v) => v.division;
  static const Field<Parade, String> _f$division =
      Field('division', _$division);
  static int _$schoolId(Parade v) => v.schoolId;
  static const Field<Parade, int> _f$schoolId = Field('schoolId', _$schoolId);
  static SchoolDivision _$divisionNumber(Parade v) => v.divisionNumber;
  static const Field<Parade, SchoolDivision> _f$divisionNumber =
      Field('divisionNumber', _$divisionNumber);
  static int _$paradeYear(Parade v) => v.paradeYear;
  static const Field<Parade, int> _f$paradeYear =
      Field('paradeYear', _$paradeYear);
  static DateTime _$date(Parade v) => v.date;
  static const Field<Parade, DateTime> _f$date = Field('date', _$date);
  static DateTime? _$championParade(Parade v) => v.championParade;
  static const Field<Parade, DateTime> _f$championParade =
      Field('championParade', _$championParade);
  static int _$components(Parade v) => v.components;
  static const Field<Parade, int> _f$components =
      Field('components', _$components);
  static int _$numberOfWings(Parade v) => v.numberOfWings;
  static const Field<Parade, int> _f$numberOfWings =
      Field('numberOfWings', _$numberOfWings);
  static int _$numberOfFloats(Parade v) => v.numberOfFloats;
  static const Field<Parade, int> _f$numberOfFloats =
      Field('numberOfFloats', _$numberOfFloats);
  static int _$numberOfTripods(Parade v) => v.numberOfTripods;
  static const Field<Parade, int> _f$numberOfTripods =
      Field('numberOfTripods', _$numberOfTripods);
  static int _$placing(Parade v) => v.placing;
  static const Field<Parade, int> _f$placing = Field('placing', _$placing);
  static bool _$relegated(Parade v) => v.relegated;
  static const Field<Parade, bool> _f$relegated =
      Field('relegated', _$relegated);
  static int _$performanceOrder(Parade v) => v.performanceOrder;
  static const Field<Parade, int> _f$performanceOrder =
      Field('performanceOrder', _$performanceOrder);
  static double _$points(Parade v) => v.points;
  static const Field<Parade, double> _f$points = Field('points', _$points);
  static String _$translatedCarnivalName(Parade v) => v.translatedCarnivalName;
  static const Field<Parade, String> _f$translatedCarnivalName =
      Field('translatedCarnivalName', _$translatedCarnivalName);
  static String _$translatedEnredo(Parade v) => v.translatedEnredo;
  static const Field<Parade, String> _f$translatedEnredo =
      Field('translatedEnredo', _$translatedEnredo);
  static String _$translatedDivision(Parade v) => v.translatedDivision;
  static const Field<Parade, String> _f$translatedDivision =
      Field('translatedDivision', _$translatedDivision);
  static List<String> _$translatedCarnavalescos(Parade v) =>
      v.translatedCarnavalescos;
  static const Field<Parade, List<String>> _f$translatedCarnavalescos =
      Field('translatedCarnavalescos', _$translatedCarnavalescos);
  static School? _$school(Parade v) => v.school;
  static const Field<Parade, School> _f$school = Field('school', _$school);

  @override
  final MappableFields<Parade> fields = const {
    #id: _f$id,
    #carnivalName: _f$carnivalName,
    #enredo: _f$enredo,
    #carnavalescos: _f$carnavalescos,
    #division: _f$division,
    #schoolId: _f$schoolId,
    #divisionNumber: _f$divisionNumber,
    #paradeYear: _f$paradeYear,
    #date: _f$date,
    #championParade: _f$championParade,
    #components: _f$components,
    #numberOfWings: _f$numberOfWings,
    #numberOfFloats: _f$numberOfFloats,
    #numberOfTripods: _f$numberOfTripods,
    #placing: _f$placing,
    #relegated: _f$relegated,
    #performanceOrder: _f$performanceOrder,
    #points: _f$points,
    #translatedCarnivalName: _f$translatedCarnivalName,
    #translatedEnredo: _f$translatedEnredo,
    #translatedDivision: _f$translatedDivision,
    #translatedCarnavalescos: _f$translatedCarnavalescos,
    #school: _f$school,
  };

  static Parade _instantiate(DecodingData data) {
    return Parade(
        id: data.dec(_f$id),
        carnivalName: data.dec(_f$carnivalName),
        enredo: data.dec(_f$enredo),
        carnavalescos: data.dec(_f$carnavalescos),
        division: data.dec(_f$division),
        schoolId: data.dec(_f$schoolId),
        divisionNumber: data.dec(_f$divisionNumber),
        paradeYear: data.dec(_f$paradeYear),
        date: data.dec(_f$date),
        championParade: data.dec(_f$championParade),
        components: data.dec(_f$components),
        numberOfWings: data.dec(_f$numberOfWings),
        numberOfFloats: data.dec(_f$numberOfFloats),
        numberOfTripods: data.dec(_f$numberOfTripods),
        placing: data.dec(_f$placing),
        relegated: data.dec(_f$relegated),
        performanceOrder: data.dec(_f$performanceOrder),
        points: data.dec(_f$points),
        translatedCarnivalName: data.dec(_f$translatedCarnivalName),
        translatedEnredo: data.dec(_f$translatedEnredo),
        translatedDivision: data.dec(_f$translatedDivision),
        translatedCarnavalescos: data.dec(_f$translatedCarnavalescos),
        school: data.dec(_f$school));
  }

  @override
  final Function instantiate = _instantiate;

  static Parade fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Parade>(map);
  }

  static Parade fromJson(String json) {
    return ensureInitialized().decodeJson<Parade>(json);
  }
}

mixin ParadeMappable {
  String toJson() {
    return ParadeMapper.ensureInitialized().encodeJson<Parade>(this as Parade);
  }

  Map<String, dynamic> toMap() {
    return ParadeMapper.ensureInitialized().encodeMap<Parade>(this as Parade);
  }

  ParadeCopyWith<Parade, Parade, Parade> get copyWith =>
      _ParadeCopyWithImpl(this as Parade, $identity, $identity);
  @override
  String toString() {
    return ParadeMapper.ensureInitialized().stringifyValue(this as Parade);
  }

  @override
  bool operator ==(Object other) {
    return ParadeMapper.ensureInitialized().equalsValue(this as Parade, other);
  }

  @override
  int get hashCode {
    return ParadeMapper.ensureInitialized().hashValue(this as Parade);
  }
}

extension ParadeValueCopy<$R, $Out> on ObjectCopyWith<$R, Parade, $Out> {
  ParadeCopyWith<$R, Parade, $Out> get $asParade =>
      $base.as((v, t, t2) => _ParadeCopyWithImpl(v, t, t2));
}

abstract class ParadeCopyWith<$R, $In extends Parade, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
      get carnavalescos;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
      get translatedCarnavalescos;
  SchoolCopyWith<$R, School, School>? get school;
  $R call(
      {int? id,
      String? carnivalName,
      String? enredo,
      List<String>? carnavalescos,
      String? division,
      int? schoolId,
      SchoolDivision? divisionNumber,
      int? paradeYear,
      DateTime? date,
      DateTime? championParade,
      int? components,
      int? numberOfWings,
      int? numberOfFloats,
      int? numberOfTripods,
      int? placing,
      bool? relegated,
      int? performanceOrder,
      double? points,
      String? translatedCarnivalName,
      String? translatedEnredo,
      String? translatedDivision,
      List<String>? translatedCarnavalescos,
      School? school});
  ParadeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ParadeCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Parade, $Out>
    implements ParadeCopyWith<$R, Parade, $Out> {
  _ParadeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Parade> $mapper = ParadeMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
      get carnavalescos => ListCopyWith(
          $value.carnavalescos,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(carnavalescos: v));
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
      get translatedCarnavalescos => ListCopyWith(
          $value.translatedCarnavalescos,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(translatedCarnavalescos: v));
  @override
  SchoolCopyWith<$R, School, School>? get school =>
      $value.school?.copyWith.$chain((v) => call(school: v));
  @override
  $R call(
          {int? id,
          String? carnivalName,
          String? enredo,
          List<String>? carnavalescos,
          String? division,
          int? schoolId,
          SchoolDivision? divisionNumber,
          int? paradeYear,
          DateTime? date,
          Object? championParade = $none,
          int? components,
          int? numberOfWings,
          int? numberOfFloats,
          int? numberOfTripods,
          int? placing,
          bool? relegated,
          int? performanceOrder,
          double? points,
          String? translatedCarnivalName,
          String? translatedEnredo,
          String? translatedDivision,
          List<String>? translatedCarnavalescos,
          Object? school = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (carnivalName != null) #carnivalName: carnivalName,
        if (enredo != null) #enredo: enredo,
        if (carnavalescos != null) #carnavalescos: carnavalescos,
        if (division != null) #division: division,
        if (schoolId != null) #schoolId: schoolId,
        if (divisionNumber != null) #divisionNumber: divisionNumber,
        if (paradeYear != null) #paradeYear: paradeYear,
        if (date != null) #date: date,
        if (championParade != $none) #championParade: championParade,
        if (components != null) #components: components,
        if (numberOfWings != null) #numberOfWings: numberOfWings,
        if (numberOfFloats != null) #numberOfFloats: numberOfFloats,
        if (numberOfTripods != null) #numberOfTripods: numberOfTripods,
        if (placing != null) #placing: placing,
        if (relegated != null) #relegated: relegated,
        if (performanceOrder != null) #performanceOrder: performanceOrder,
        if (points != null) #points: points,
        if (translatedCarnivalName != null)
          #translatedCarnivalName: translatedCarnivalName,
        if (translatedEnredo != null) #translatedEnredo: translatedEnredo,
        if (translatedDivision != null) #translatedDivision: translatedDivision,
        if (translatedCarnavalescos != null)
          #translatedCarnavalescos: translatedCarnavalescos,
        if (school != $none) #school: school
      }));
  @override
  Parade $make(CopyWithData data) => Parade(
      id: data.get(#id, or: $value.id),
      carnivalName: data.get(#carnivalName, or: $value.carnivalName),
      enredo: data.get(#enredo, or: $value.enredo),
      carnavalescos: data.get(#carnavalescos, or: $value.carnavalescos),
      division: data.get(#division, or: $value.division),
      schoolId: data.get(#schoolId, or: $value.schoolId),
      divisionNumber: data.get(#divisionNumber, or: $value.divisionNumber),
      paradeYear: data.get(#paradeYear, or: $value.paradeYear),
      date: data.get(#date, or: $value.date),
      championParade: data.get(#championParade, or: $value.championParade),
      components: data.get(#components, or: $value.components),
      numberOfWings: data.get(#numberOfWings, or: $value.numberOfWings),
      numberOfFloats: data.get(#numberOfFloats, or: $value.numberOfFloats),
      numberOfTripods: data.get(#numberOfTripods, or: $value.numberOfTripods),
      placing: data.get(#placing, or: $value.placing),
      relegated: data.get(#relegated, or: $value.relegated),
      performanceOrder:
          data.get(#performanceOrder, or: $value.performanceOrder),
      points: data.get(#points, or: $value.points),
      translatedCarnivalName:
          data.get(#translatedCarnivalName, or: $value.translatedCarnivalName),
      translatedEnredo:
          data.get(#translatedEnredo, or: $value.translatedEnredo),
      translatedDivision:
          data.get(#translatedDivision, or: $value.translatedDivision),
      translatedCarnavalescos: data.get(#translatedCarnavalescos,
          or: $value.translatedCarnavalescos),
      school: data.get(#school, or: $value.school));

  @override
  ParadeCopyWith<$R2, Parade, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ParadeCopyWithImpl($value, $cast, t);
}

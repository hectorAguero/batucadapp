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
  static int _$schoolId(Parade v) => v.schoolId;
  static const Field<Parade, int> _f$schoolId = Field('schoolId', _$schoolId);
  static int _$carnivalId(Parade v) => v.carnivalId;
  static const Field<Parade, int> _f$carnivalId =
      Field('carnivalId', _$carnivalId);
  static String _$carnivalName(Parade v) => v.carnivalName;
  static const Field<Parade, String> _f$carnivalName =
      Field('carnivalName', _$carnivalName);
  static String _$enredo(Parade v) => v.enredo;
  static const Field<Parade, String> _f$enredo = Field('enredo', _$enredo);
  static UnmodifiableListView<String> _$carnavalescos(Parade v) =>
      v.carnavalescos;
  static const Field<Parade, UnmodifiableListView<String>> _f$carnavalescos =
      Field('carnavalescos', _$carnavalescos);
  static String _$division(Parade v) => v.division;
  static const Field<Parade, String> _f$division =
      Field('division', _$division);
  static SchoolDivision _$divisionNumber(Parade v) => v.divisionNumber;
  static const Field<Parade, SchoolDivision> _f$divisionNumber =
      Field('divisionNumber', _$divisionNumber);
  static int? _$subdivisionNumber(Parade v) => v.subdivisionNumber;
  static const Field<Parade, int> _f$subdivisionNumber =
      Field('subdivisionNumber', _$subdivisionNumber);
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
  static bool _$promoted(Parade v) => v.promoted;
  static const Field<Parade, bool> _f$promoted = Field('promoted', _$promoted);
  static bool _$champion(Parade v) => v.champion;
  static const Field<Parade, bool> _f$champion = Field('champion', _$champion);
  static int _$performanceOrder(Parade v) => v.performanceOrder;
  static const Field<Parade, int> _f$performanceOrder =
      Field('performanceOrder', _$performanceOrder);
  static int _$performanceDay(Parade v) => v.performanceDay;
  static const Field<Parade, int> _f$performanceDay =
      Field('performanceDay', _$performanceDay);
  static double _$points(Parade v) => v.points;
  static const Field<Parade, double> _f$points = Field('points', _$points);
  static String _$details(Parade v) => v.details;
  static const Field<Parade, String> _f$details = Field('details', _$details);
  static String _$translatedCarnivalName(Parade v) => v.translatedCarnivalName;
  static const Field<Parade, String> _f$translatedCarnivalName =
      Field('translatedCarnivalName', _$translatedCarnivalName);
  static String _$translatedEnredo(Parade v) => v.translatedEnredo;
  static const Field<Parade, String> _f$translatedEnredo =
      Field('translatedEnredo', _$translatedEnredo);
  static String _$translatedDivision(Parade v) => v.translatedDivision;
  static const Field<Parade, String> _f$translatedDivision =
      Field('translatedDivision', _$translatedDivision);
  static UnmodifiableListView<String> _$translatedCarnavalescos(Parade v) =>
      v.translatedCarnavalescos;
  static const Field<Parade, UnmodifiableListView<String>>
      _f$translatedCarnavalescos =
      Field('translatedCarnavalescos', _$translatedCarnavalescos);
  static School _$school(Parade v) => v.school;
  static const Field<Parade, School> _f$school = Field('school', _$school);

  @override
  final MappableFields<Parade> fields = const {
    #id: _f$id,
    #schoolId: _f$schoolId,
    #carnivalId: _f$carnivalId,
    #carnivalName: _f$carnivalName,
    #enredo: _f$enredo,
    #carnavalescos: _f$carnavalescos,
    #division: _f$division,
    #divisionNumber: _f$divisionNumber,
    #subdivisionNumber: _f$subdivisionNumber,
    #paradeYear: _f$paradeYear,
    #date: _f$date,
    #championParade: _f$championParade,
    #components: _f$components,
    #numberOfWings: _f$numberOfWings,
    #numberOfFloats: _f$numberOfFloats,
    #numberOfTripods: _f$numberOfTripods,
    #placing: _f$placing,
    #relegated: _f$relegated,
    #promoted: _f$promoted,
    #champion: _f$champion,
    #performanceOrder: _f$performanceOrder,
    #performanceDay: _f$performanceDay,
    #points: _f$points,
    #details: _f$details,
    #translatedCarnivalName: _f$translatedCarnivalName,
    #translatedEnredo: _f$translatedEnredo,
    #translatedDivision: _f$translatedDivision,
    #translatedCarnavalescos: _f$translatedCarnavalescos,
    #school: _f$school,
  };

  static Parade _instantiate(DecodingData data) {
    return Parade(
        id: data.dec(_f$id),
        schoolId: data.dec(_f$schoolId),
        carnivalId: data.dec(_f$carnivalId),
        carnivalName: data.dec(_f$carnivalName),
        enredo: data.dec(_f$enredo),
        carnavalescos: data.dec(_f$carnavalescos),
        division: data.dec(_f$division),
        divisionNumber: data.dec(_f$divisionNumber),
        subdivisionNumber: data.dec(_f$subdivisionNumber),
        paradeYear: data.dec(_f$paradeYear),
        date: data.dec(_f$date),
        championParade: data.dec(_f$championParade),
        components: data.dec(_f$components),
        numberOfWings: data.dec(_f$numberOfWings),
        numberOfFloats: data.dec(_f$numberOfFloats),
        numberOfTripods: data.dec(_f$numberOfTripods),
        placing: data.dec(_f$placing),
        relegated: data.dec(_f$relegated),
        promoted: data.dec(_f$promoted),
        champion: data.dec(_f$champion),
        performanceOrder: data.dec(_f$performanceOrder),
        performanceDay: data.dec(_f$performanceDay),
        points: data.dec(_f$points),
        details: data.dec(_f$details),
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
  SchoolCopyWith<$R, School, School> get school;
  $R call(
      {int? id,
      int? schoolId,
      int? carnivalId,
      String? carnivalName,
      String? enredo,
      UnmodifiableListView<String>? carnavalescos,
      String? division,
      SchoolDivision? divisionNumber,
      int? subdivisionNumber,
      int? paradeYear,
      DateTime? date,
      DateTime? championParade,
      int? components,
      int? numberOfWings,
      int? numberOfFloats,
      int? numberOfTripods,
      int? placing,
      bool? relegated,
      bool? promoted,
      bool? champion,
      int? performanceOrder,
      int? performanceDay,
      double? points,
      String? details,
      String? translatedCarnivalName,
      String? translatedEnredo,
      String? translatedDivision,
      UnmodifiableListView<String>? translatedCarnavalescos,
      School? school});
  ParadeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ParadeCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Parade, $Out>
    implements ParadeCopyWith<$R, Parade, $Out> {
  _ParadeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Parade> $mapper = ParadeMapper.ensureInitialized();
  @override
  SchoolCopyWith<$R, School, School> get school =>
      $value.school.copyWith.$chain((v) => call(school: v));
  @override
  $R call(
          {int? id,
          int? schoolId,
          int? carnivalId,
          String? carnivalName,
          String? enredo,
          UnmodifiableListView<String>? carnavalescos,
          String? division,
          SchoolDivision? divisionNumber,
          Object? subdivisionNumber = $none,
          int? paradeYear,
          DateTime? date,
          Object? championParade = $none,
          int? components,
          int? numberOfWings,
          int? numberOfFloats,
          int? numberOfTripods,
          int? placing,
          bool? relegated,
          bool? promoted,
          bool? champion,
          int? performanceOrder,
          int? performanceDay,
          double? points,
          String? details,
          String? translatedCarnivalName,
          String? translatedEnredo,
          String? translatedDivision,
          UnmodifiableListView<String>? translatedCarnavalescos,
          School? school}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (schoolId != null) #schoolId: schoolId,
        if (carnivalId != null) #carnivalId: carnivalId,
        if (carnivalName != null) #carnivalName: carnivalName,
        if (enredo != null) #enredo: enredo,
        if (carnavalescos != null) #carnavalescos: carnavalescos,
        if (division != null) #division: division,
        if (divisionNumber != null) #divisionNumber: divisionNumber,
        if (subdivisionNumber != $none) #subdivisionNumber: subdivisionNumber,
        if (paradeYear != null) #paradeYear: paradeYear,
        if (date != null) #date: date,
        if (championParade != $none) #championParade: championParade,
        if (components != null) #components: components,
        if (numberOfWings != null) #numberOfWings: numberOfWings,
        if (numberOfFloats != null) #numberOfFloats: numberOfFloats,
        if (numberOfTripods != null) #numberOfTripods: numberOfTripods,
        if (placing != null) #placing: placing,
        if (relegated != null) #relegated: relegated,
        if (promoted != null) #promoted: promoted,
        if (champion != null) #champion: champion,
        if (performanceOrder != null) #performanceOrder: performanceOrder,
        if (performanceDay != null) #performanceDay: performanceDay,
        if (points != null) #points: points,
        if (details != null) #details: details,
        if (translatedCarnivalName != null)
          #translatedCarnivalName: translatedCarnivalName,
        if (translatedEnredo != null) #translatedEnredo: translatedEnredo,
        if (translatedDivision != null) #translatedDivision: translatedDivision,
        if (translatedCarnavalescos != null)
          #translatedCarnavalescos: translatedCarnavalescos,
        if (school != null) #school: school
      }));
  @override
  Parade $make(CopyWithData data) => Parade(
      id: data.get(#id, or: $value.id),
      schoolId: data.get(#schoolId, or: $value.schoolId),
      carnivalId: data.get(#carnivalId, or: $value.carnivalId),
      carnivalName: data.get(#carnivalName, or: $value.carnivalName),
      enredo: data.get(#enredo, or: $value.enredo),
      carnavalescos: data.get(#carnavalescos, or: $value.carnavalescos),
      division: data.get(#division, or: $value.division),
      divisionNumber: data.get(#divisionNumber, or: $value.divisionNumber),
      subdivisionNumber:
          data.get(#subdivisionNumber, or: $value.subdivisionNumber),
      paradeYear: data.get(#paradeYear, or: $value.paradeYear),
      date: data.get(#date, or: $value.date),
      championParade: data.get(#championParade, or: $value.championParade),
      components: data.get(#components, or: $value.components),
      numberOfWings: data.get(#numberOfWings, or: $value.numberOfWings),
      numberOfFloats: data.get(#numberOfFloats, or: $value.numberOfFloats),
      numberOfTripods: data.get(#numberOfTripods, or: $value.numberOfTripods),
      placing: data.get(#placing, or: $value.placing),
      relegated: data.get(#relegated, or: $value.relegated),
      promoted: data.get(#promoted, or: $value.promoted),
      champion: data.get(#champion, or: $value.champion),
      performanceOrder:
          data.get(#performanceOrder, or: $value.performanceOrder),
      performanceDay: data.get(#performanceDay, or: $value.performanceDay),
      points: data.get(#points, or: $value.points),
      details: data.get(#details, or: $value.details),
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

class ParadeQueryParamsMapper extends ClassMapperBase<ParadeQueryParams> {
  ParadeQueryParamsMapper._();

  static ParadeQueryParamsMapper? _instance;
  static ParadeQueryParamsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ParadeQueryParamsMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ParadeQueryParams';

  static String? _$language(ParadeQueryParams v) => v.language;
  static const Field<ParadeQueryParams, String> _f$language =
      Field('language', _$language, opt: true);
  static String? _$filter(ParadeQueryParams v) => v.filter;
  static const Field<ParadeQueryParams, String> _f$filter =
      Field('filter', _$filter, opt: true);
  static String? _$sort(ParadeQueryParams v) => v.sort;
  static const Field<ParadeQueryParams, String> _f$sort =
      Field('sort', _$sort, opt: true);
  static String? _$sortOrder(ParadeQueryParams v) => v.sortOrder;
  static const Field<ParadeQueryParams, String> _f$sortOrder =
      Field('sortOrder', _$sortOrder, opt: true);
  static String? _$search(ParadeQueryParams v) => v.search;
  static const Field<ParadeQueryParams, String> _f$search =
      Field('search', _$search, opt: true);
  static int? _$page(ParadeQueryParams v) => v.page;
  static const Field<ParadeQueryParams, int> _f$page =
      Field('page', _$page, opt: true);
  static int? _$pageSize(ParadeQueryParams v) => v.pageSize;
  static const Field<ParadeQueryParams, int> _f$pageSize =
      Field('pageSize', _$pageSize, opt: true);

  @override
  final MappableFields<ParadeQueryParams> fields = const {
    #language: _f$language,
    #filter: _f$filter,
    #sort: _f$sort,
    #sortOrder: _f$sortOrder,
    #search: _f$search,
    #page: _f$page,
    #pageSize: _f$pageSize,
  };

  static ParadeQueryParams _instantiate(DecodingData data) {
    return ParadeQueryParams(
        language: data.dec(_f$language),
        filter: data.dec(_f$filter),
        sort: data.dec(_f$sort),
        sortOrder: data.dec(_f$sortOrder),
        search: data.dec(_f$search),
        page: data.dec(_f$page),
        pageSize: data.dec(_f$pageSize));
  }

  @override
  final Function instantiate = _instantiate;

  static ParadeQueryParams fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ParadeQueryParams>(map);
  }

  static ParadeQueryParams fromJson(String json) {
    return ensureInitialized().decodeJson<ParadeQueryParams>(json);
  }
}

mixin ParadeQueryParamsMappable {
  String toJson() {
    return ParadeQueryParamsMapper.ensureInitialized()
        .encodeJson<ParadeQueryParams>(this as ParadeQueryParams);
  }

  Map<String, dynamic> toMap() {
    return ParadeQueryParamsMapper.ensureInitialized()
        .encodeMap<ParadeQueryParams>(this as ParadeQueryParams);
  }

  ParadeQueryParamsCopyWith<ParadeQueryParams, ParadeQueryParams,
          ParadeQueryParams>
      get copyWith => _ParadeQueryParamsCopyWithImpl(
          this as ParadeQueryParams, $identity, $identity);
  @override
  String toString() {
    return ParadeQueryParamsMapper.ensureInitialized()
        .stringifyValue(this as ParadeQueryParams);
  }

  @override
  bool operator ==(Object other) {
    return ParadeQueryParamsMapper.ensureInitialized()
        .equalsValue(this as ParadeQueryParams, other);
  }

  @override
  int get hashCode {
    return ParadeQueryParamsMapper.ensureInitialized()
        .hashValue(this as ParadeQueryParams);
  }
}

extension ParadeQueryParamsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ParadeQueryParams, $Out> {
  ParadeQueryParamsCopyWith<$R, ParadeQueryParams, $Out>
      get $asParadeQueryParams =>
          $base.as((v, t, t2) => _ParadeQueryParamsCopyWithImpl(v, t, t2));
}

abstract class ParadeQueryParamsCopyWith<$R, $In extends ParadeQueryParams,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? language,
      String? filter,
      String? sort,
      String? sortOrder,
      String? search,
      int? page,
      int? pageSize});
  ParadeQueryParamsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ParadeQueryParamsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ParadeQueryParams, $Out>
    implements ParadeQueryParamsCopyWith<$R, ParadeQueryParams, $Out> {
  _ParadeQueryParamsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ParadeQueryParams> $mapper =
      ParadeQueryParamsMapper.ensureInitialized();
  @override
  $R call(
          {Object? language = $none,
          Object? filter = $none,
          Object? sort = $none,
          Object? sortOrder = $none,
          Object? search = $none,
          Object? page = $none,
          Object? pageSize = $none}) =>
      $apply(FieldCopyWithData({
        if (language != $none) #language: language,
        if (filter != $none) #filter: filter,
        if (sort != $none) #sort: sort,
        if (sortOrder != $none) #sortOrder: sortOrder,
        if (search != $none) #search: search,
        if (page != $none) #page: page,
        if (pageSize != $none) #pageSize: pageSize
      }));
  @override
  ParadeQueryParams $make(CopyWithData data) => ParadeQueryParams(
      language: data.get(#language, or: $value.language),
      filter: data.get(#filter, or: $value.filter),
      sort: data.get(#sort, or: $value.sort),
      sortOrder: data.get(#sortOrder, or: $value.sortOrder),
      search: data.get(#search, or: $value.search),
      page: data.get(#page, or: $value.page),
      pageSize: data.get(#pageSize, or: $value.pageSize));

  @override
  ParadeQueryParamsCopyWith<$R2, ParadeQueryParams, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ParadeQueryParamsCopyWithImpl($value, $cast, t);
}

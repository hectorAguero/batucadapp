// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'app_theme_colors.dart';

class AppThemeColorsMapper extends ClassMapperBase<AppThemeColors> {
  AppThemeColorsMapper._();

  static AppThemeColorsMapper? _instance;
  static AppThemeColorsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AppThemeColorsMapper._());
      MapperContainer.globals.useAll([ColorMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'AppThemeColors';

  static Color _$primary(AppThemeColors v) => v.primary;
  static const Field<AppThemeColors, Color> _f$primary =
      Field('primary', _$primary);
  static String _$name(AppThemeColors v) => v.name;
  static const Field<AppThemeColors, String> _f$name = Field('name', _$name);
  static Color? _$secondary(AppThemeColors v) => v.secondary;
  static const Field<AppThemeColors, Color> _f$secondary =
      Field('secondary', _$secondary, opt: true);
  static Color? _$tertiary(AppThemeColors v) => v.tertiary;
  static const Field<AppThemeColors, Color> _f$tertiary =
      Field('tertiary', _$tertiary, opt: true);

  @override
  final MappableFields<AppThemeColors> fields = const {
    #primary: _f$primary,
    #name: _f$name,
    #secondary: _f$secondary,
    #tertiary: _f$tertiary,
  };

  static AppThemeColors _instantiate(DecodingData data) {
    return AppThemeColors(
        primary: data.dec(_f$primary),
        name: data.dec(_f$name),
        secondary: data.dec(_f$secondary),
        tertiary: data.dec(_f$tertiary));
  }

  @override
  final Function instantiate = _instantiate;

  static AppThemeColors fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AppThemeColors>(map);
  }

  static AppThemeColors fromJson(String json) {
    return ensureInitialized().decodeJson<AppThemeColors>(json);
  }
}

mixin AppThemeColorsMappable {
  String toJson() {
    return AppThemeColorsMapper.ensureInitialized()
        .encodeJson<AppThemeColors>(this as AppThemeColors);
  }

  Map<String, dynamic> toMap() {
    return AppThemeColorsMapper.ensureInitialized()
        .encodeMap<AppThemeColors>(this as AppThemeColors);
  }

  AppThemeColorsCopyWith<AppThemeColors, AppThemeColors, AppThemeColors>
      get copyWith => _AppThemeColorsCopyWithImpl(
          this as AppThemeColors, $identity, $identity);
  @override
  String toString() {
    return AppThemeColorsMapper.ensureInitialized()
        .stringifyValue(this as AppThemeColors);
  }

  @override
  bool operator ==(Object other) {
    return AppThemeColorsMapper.ensureInitialized()
        .equalsValue(this as AppThemeColors, other);
  }

  @override
  int get hashCode {
    return AppThemeColorsMapper.ensureInitialized()
        .hashValue(this as AppThemeColors);
  }
}

extension AppThemeColorsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AppThemeColors, $Out> {
  AppThemeColorsCopyWith<$R, AppThemeColors, $Out> get $asAppThemeColors =>
      $base.as((v, t, t2) => _AppThemeColorsCopyWithImpl(v, t, t2));
}

abstract class AppThemeColorsCopyWith<$R, $In extends AppThemeColors, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({Color? primary, String? name, Color? secondary, Color? tertiary});
  AppThemeColorsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _AppThemeColorsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AppThemeColors, $Out>
    implements AppThemeColorsCopyWith<$R, AppThemeColors, $Out> {
  _AppThemeColorsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AppThemeColors> $mapper =
      AppThemeColorsMapper.ensureInitialized();
  @override
  $R call(
          {Color? primary,
          String? name,
          Object? secondary = $none,
          Object? tertiary = $none}) =>
      $apply(FieldCopyWithData({
        if (primary != null) #primary: primary,
        if (name != null) #name: name,
        if (secondary != $none) #secondary: secondary,
        if (tertiary != $none) #tertiary: tertiary
      }));
  @override
  AppThemeColors $make(CopyWithData data) => AppThemeColors(
      primary: data.get(#primary, or: $value.primary),
      name: data.get(#name, or: $value.name),
      secondary: data.get(#secondary, or: $value.secondary),
      tertiary: data.get(#tertiary, or: $value.tertiary));

  @override
  AppThemeColorsCopyWith<$R2, AppThemeColors, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AppThemeColorsCopyWithImpl($value, $cast, t);
}

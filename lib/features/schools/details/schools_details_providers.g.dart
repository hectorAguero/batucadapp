// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schools_details_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$selectedSchoolHash() => r'caae5ffd4b733525c963b09b2b47726e3a1920ec';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$SelectedSchool extends BuildlessAutoDisposeNotifier<School> {
  late final int id;

  School build(
    int id,
  );
}

/// See also [SelectedSchool].
@ProviderFor(SelectedSchool)
const selectedSchoolProvider = SelectedSchoolFamily();

/// See also [SelectedSchool].
class SelectedSchoolFamily extends Family {
  /// See also [SelectedSchool].
  const SelectedSchoolFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'selectedSchoolProvider';

  /// See also [SelectedSchool].
  SelectedSchoolProvider call(
    int id,
  ) {
    return SelectedSchoolProvider(
      id,
    );
  }

  @visibleForOverriding
  @override
  SelectedSchoolProvider getProviderOverride(
    covariant SelectedSchoolProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(SelectedSchool Function() create) {
    return _$SelectedSchoolFamilyOverride(this, create);
  }
}

class _$SelectedSchoolFamilyOverride implements FamilyOverride {
  _$SelectedSchoolFamilyOverride(this.overriddenFamily, this.create);

  final SelectedSchool Function() create;

  @override
  final SelectedSchoolFamily overriddenFamily;

  @override
  SelectedSchoolProvider getProviderOverride(
    covariant SelectedSchoolProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [SelectedSchool].
class SelectedSchoolProvider
    extends AutoDisposeNotifierProviderImpl<SelectedSchool, School> {
  /// See also [SelectedSchool].
  SelectedSchoolProvider(
    int id,
  ) : this._internal(
          () => SelectedSchool()..id = id,
          from: selectedSchoolProvider,
          name: r'selectedSchoolProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$selectedSchoolHash,
          dependencies: SelectedSchoolFamily._dependencies,
          allTransitiveDependencies:
              SelectedSchoolFamily._allTransitiveDependencies,
          id: id,
        );

  SelectedSchoolProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  School runNotifierBuild(
    covariant SelectedSchool notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(SelectedSchool Function() create) {
    return ProviderOverride(
      origin: this,
      override: SelectedSchoolProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  (int,) get argument {
    return (id,);
  }

  @override
  AutoDisposeNotifierProviderElement<SelectedSchool, School> createElement() {
    return _SelectedSchoolProviderElement(this);
  }

  SelectedSchoolProvider _copyWith(
    SelectedSchool Function() create,
  ) {
    return SelectedSchoolProvider._internal(
      () => create()..id = id,
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      id: id,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedSchoolProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SelectedSchoolRef on AutoDisposeNotifierProviderRef<School> {
  /// The parameter `id` of this provider.
  int get id;
}

class _SelectedSchoolProviderElement
    extends AutoDisposeNotifierProviderElement<SelectedSchool, School>
    with SelectedSchoolRef {
  _SelectedSchoolProviderElement(super.provider);

  @override
  int get id => (origin as SelectedSchoolProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package

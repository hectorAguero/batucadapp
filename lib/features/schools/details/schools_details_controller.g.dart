// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schools_details_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$schoolsDetailsControllerHash() =>
    r'29336ca2472c1525ae7bf07f6539f5557d5e486b';

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

abstract class _$SchoolsDetailsController
    extends BuildlessAutoDisposeNotifier<School> {
  late final int id;

  School build(
    int id,
  );
}

/// See also [SchoolsDetailsController].
@ProviderFor(SchoolsDetailsController)
const schoolsDetailsControllerProvider = SchoolsDetailsControllerFamily();

/// See also [SchoolsDetailsController].
class SchoolsDetailsControllerFamily extends Family {
  /// See also [SchoolsDetailsController].
  const SchoolsDetailsControllerFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'schoolsDetailsControllerProvider';

  /// See also [SchoolsDetailsController].
  SchoolsDetailsControllerProvider call(
    int id,
  ) {
    return SchoolsDetailsControllerProvider(
      id,
    );
  }

  @visibleForOverriding
  @override
  SchoolsDetailsControllerProvider getProviderOverride(
    covariant SchoolsDetailsControllerProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(SchoolsDetailsController Function() create) {
    return _$SchoolsDetailsControllerFamilyOverride(this, create);
  }
}

class _$SchoolsDetailsControllerFamilyOverride implements FamilyOverride {
  _$SchoolsDetailsControllerFamilyOverride(this.overriddenFamily, this.create);

  final SchoolsDetailsController Function() create;

  @override
  final SchoolsDetailsControllerFamily overriddenFamily;

  @override
  SchoolsDetailsControllerProvider getProviderOverride(
    covariant SchoolsDetailsControllerProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [SchoolsDetailsController].
class SchoolsDetailsControllerProvider
    extends AutoDisposeNotifierProviderImpl<SchoolsDetailsController, School> {
  /// See also [SchoolsDetailsController].
  SchoolsDetailsControllerProvider(
    int id,
  ) : this._internal(
          () => SchoolsDetailsController()..id = id,
          from: schoolsDetailsControllerProvider,
          name: r'schoolsDetailsControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$schoolsDetailsControllerHash,
          dependencies: SchoolsDetailsControllerFamily._dependencies,
          allTransitiveDependencies:
              SchoolsDetailsControllerFamily._allTransitiveDependencies,
          id: id,
        );

  SchoolsDetailsControllerProvider._internal(
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
    covariant SchoolsDetailsController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(SchoolsDetailsController Function() create) {
    return ProviderOverride(
      origin: this,
      override: SchoolsDetailsControllerProvider._internal(
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
  AutoDisposeNotifierProviderElement<SchoolsDetailsController, School>
      createElement() {
    return _SchoolsDetailsControllerProviderElement(this);
  }

  SchoolsDetailsControllerProvider _copyWith(
    SchoolsDetailsController Function() create,
  ) {
    return SchoolsDetailsControllerProvider._internal(
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
    return other is SchoolsDetailsControllerProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SchoolsDetailsControllerRef on AutoDisposeNotifierProviderRef<School> {
  /// The parameter `id` of this provider.
  int get id;
}

class _SchoolsDetailsControllerProviderElement
    extends AutoDisposeNotifierProviderElement<SchoolsDetailsController, School>
    with SchoolsDetailsControllerRef {
  _SchoolsDetailsControllerProviderElement(super.provider);

  @override
  int get id => (origin as SchoolsDetailsControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package

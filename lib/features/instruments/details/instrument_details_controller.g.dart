// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instrument_details_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$instrumentDetailsControllerHash() =>
    r'62aacbc96a4ab812e1f78ce8707a195dfd47d1d7';

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

abstract class _$InstrumentDetailsController
    extends BuildlessAutoDisposeNotifier<Instrument> {
  late final int id;

  Instrument build(
    int id,
  );
}

/// See also [InstrumentDetailsController].
@ProviderFor(InstrumentDetailsController)
const instrumentDetailsControllerProvider = InstrumentDetailsControllerFamily();

/// See also [InstrumentDetailsController].
class InstrumentDetailsControllerFamily extends Family {
  /// See also [InstrumentDetailsController].
  const InstrumentDetailsControllerFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'instrumentDetailsControllerProvider';

  /// See also [InstrumentDetailsController].
  InstrumentDetailsControllerProvider call(
    int id,
  ) {
    return InstrumentDetailsControllerProvider(
      id,
    );
  }

  @visibleForOverriding
  @override
  InstrumentDetailsControllerProvider getProviderOverride(
    covariant InstrumentDetailsControllerProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(InstrumentDetailsController Function() create) {
    return _$InstrumentDetailsControllerFamilyOverride(this, create);
  }
}

class _$InstrumentDetailsControllerFamilyOverride implements FamilyOverride {
  _$InstrumentDetailsControllerFamilyOverride(
      this.overriddenFamily, this.create);

  final InstrumentDetailsController Function() create;

  @override
  final InstrumentDetailsControllerFamily overriddenFamily;

  @override
  InstrumentDetailsControllerProvider getProviderOverride(
    covariant InstrumentDetailsControllerProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [InstrumentDetailsController].
class InstrumentDetailsControllerProvider
    extends AutoDisposeNotifierProviderImpl<InstrumentDetailsController,
        Instrument> {
  /// See also [InstrumentDetailsController].
  InstrumentDetailsControllerProvider(
    int id,
  ) : this._internal(
          () => InstrumentDetailsController()..id = id,
          from: instrumentDetailsControllerProvider,
          name: r'instrumentDetailsControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$instrumentDetailsControllerHash,
          dependencies: InstrumentDetailsControllerFamily._dependencies,
          allTransitiveDependencies:
              InstrumentDetailsControllerFamily._allTransitiveDependencies,
          id: id,
        );

  InstrumentDetailsControllerProvider._internal(
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
  Instrument runNotifierBuild(
    covariant InstrumentDetailsController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(InstrumentDetailsController Function() create) {
    return ProviderOverride(
      origin: this,
      override: InstrumentDetailsControllerProvider._internal(
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
  AutoDisposeNotifierProviderElement<InstrumentDetailsController, Instrument>
      createElement() {
    return _InstrumentDetailsControllerProviderElement(this);
  }

  InstrumentDetailsControllerProvider _copyWith(
    InstrumentDetailsController Function() create,
  ) {
    return InstrumentDetailsControllerProvider._internal(
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
    return other is InstrumentDetailsControllerProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin InstrumentDetailsControllerRef
    on AutoDisposeNotifierProviderRef<Instrument> {
  /// The parameter `id` of this provider.
  int get id;
}

class _InstrumentDetailsControllerProviderElement
    extends AutoDisposeNotifierProviderElement<InstrumentDetailsController,
        Instrument> with InstrumentDetailsControllerRef {
  _InstrumentDetailsControllerProviderElement(super.provider);

  @override
  int get id => (origin as InstrumentDetailsControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package

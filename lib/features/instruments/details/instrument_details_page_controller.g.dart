// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instrument_details_page_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$instrumentDetailsPageControllerHash() =>
    r'51641bda6cd616bac59379777b639d34d86839b3';

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

abstract class _$InstrumentDetailsPageController
    extends BuildlessAutoDisposeNotifier<Instrument> {
  late final int id;

  Instrument build(
    int id,
  );
}

/// See also [InstrumentDetailsPageController].
@ProviderFor(InstrumentDetailsPageController)
const instrumentDetailsPageControllerProvider =
    InstrumentDetailsPageControllerFamily();

/// See also [InstrumentDetailsPageController].
class InstrumentDetailsPageControllerFamily extends Family<Instrument> {
  /// See also [InstrumentDetailsPageController].
  const InstrumentDetailsPageControllerFamily();

  /// See also [InstrumentDetailsPageController].
  InstrumentDetailsPageControllerProvider call(
    int id,
  ) {
    return InstrumentDetailsPageControllerProvider(
      id,
    );
  }

  @override
  InstrumentDetailsPageControllerProvider getProviderOverride(
    covariant InstrumentDetailsPageControllerProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'instrumentDetailsPageControllerProvider';
}

/// See also [InstrumentDetailsPageController].
class InstrumentDetailsPageControllerProvider
    extends AutoDisposeNotifierProviderImpl<InstrumentDetailsPageController,
        Instrument> {
  /// See also [InstrumentDetailsPageController].
  InstrumentDetailsPageControllerProvider(
    int id,
  ) : this._internal(
          () => InstrumentDetailsPageController()..id = id,
          from: instrumentDetailsPageControllerProvider,
          name: r'instrumentDetailsPageControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$instrumentDetailsPageControllerHash,
          dependencies: InstrumentDetailsPageControllerFamily._dependencies,
          allTransitiveDependencies:
              InstrumentDetailsPageControllerFamily._allTransitiveDependencies,
          id: id,
        );

  InstrumentDetailsPageControllerProvider._internal(
    super._createNotifier, {
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
    covariant InstrumentDetailsPageController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(InstrumentDetailsPageController Function() create) {
    return ProviderOverride(
      origin: this,
      override: InstrumentDetailsPageControllerProvider._internal(
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
  AutoDisposeNotifierProviderElement<InstrumentDetailsPageController,
      Instrument> createElement() {
    return _InstrumentDetailsPageControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is InstrumentDetailsPageControllerProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin InstrumentDetailsPageControllerRef
    on AutoDisposeNotifierProviderRef<Instrument> {
  /// The parameter `id` of this provider.
  int get id;
}

class _InstrumentDetailsPageControllerProviderElement
    extends AutoDisposeNotifierProviderElement<InstrumentDetailsPageController,
        Instrument> with InstrumentDetailsPageControllerRef {
  _InstrumentDetailsPageControllerProviderElement(super.provider);

  @override
  int get id => (origin as InstrumentDetailsPageControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

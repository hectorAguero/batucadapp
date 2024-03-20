// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instrument_details_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$instrumentDetailsHash() => r'9fa45a3540e594758f1b74667382624a5c32bd4a';

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

abstract class _$InstrumentDetails
    extends BuildlessAutoDisposeAsyncNotifier<Instrument> {
  late final int id;

  FutureOr<Instrument> build(
    int id,
  );
}

/// See also [InstrumentDetails].
@ProviderFor(InstrumentDetails)
const instrumentDetailsProvider = InstrumentDetailsFamily();

/// See also [InstrumentDetails].
class InstrumentDetailsFamily extends Family<AsyncValue<Instrument>> {
  /// See also [InstrumentDetails].
  const InstrumentDetailsFamily();

  /// See also [InstrumentDetails].
  InstrumentDetailsProvider call(
    int id,
  ) {
    return InstrumentDetailsProvider(
      id,
    );
  }

  @override
  InstrumentDetailsProvider getProviderOverride(
    covariant InstrumentDetailsProvider provider,
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
  String? get name => r'instrumentDetailsProvider';
}

/// See also [InstrumentDetails].
class InstrumentDetailsProvider extends AutoDisposeAsyncNotifierProviderImpl<
    InstrumentDetails, Instrument> {
  /// See also [InstrumentDetails].
  InstrumentDetailsProvider(
    int id,
  ) : this._internal(
          () => InstrumentDetails()..id = id,
          from: instrumentDetailsProvider,
          name: r'instrumentDetailsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$instrumentDetailsHash,
          dependencies: InstrumentDetailsFamily._dependencies,
          allTransitiveDependencies:
              InstrumentDetailsFamily._allTransitiveDependencies,
          id: id,
        );

  InstrumentDetailsProvider._internal(
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
  FutureOr<Instrument> runNotifierBuild(
    covariant InstrumentDetails notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(InstrumentDetails Function() create) {
    return ProviderOverride(
      origin: this,
      override: InstrumentDetailsProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<InstrumentDetails, Instrument>
      createElement() {
    return _InstrumentDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is InstrumentDetailsProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin InstrumentDetailsRef on AutoDisposeAsyncNotifierProviderRef<Instrument> {
  /// The parameter `id` of this provider.
  int get id;
}

class _InstrumentDetailsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<InstrumentDetails,
        Instrument> with InstrumentDetailsRef {
  _InstrumentDetailsProviderElement(super.provider);

  @override
  int get id => (origin as InstrumentDetailsProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stream_meet_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$streamMeetStateHash() => r'2b5dfdbaa0a6bb85b7675908f4a7c636b9671ef4';

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

/// See also [streamMeetState].
@ProviderFor(streamMeetState)
const streamMeetStateProvider = StreamMeetStateFamily();

/// See also [streamMeetState].
class StreamMeetStateFamily extends Family<AsyncValue<Meet?>> {
  /// See also [streamMeetState].
  const StreamMeetStateFamily();

  /// See also [streamMeetState].
  StreamMeetStateProvider call(
    String id, {
    bool allStatus = false,
  }) {
    return StreamMeetStateProvider(
      id,
      allStatus: allStatus,
    );
  }

  @override
  StreamMeetStateProvider getProviderOverride(
    covariant StreamMeetStateProvider provider,
  ) {
    return call(
      provider.id,
      allStatus: provider.allStatus,
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
  String? get name => r'streamMeetStateProvider';
}

/// See also [streamMeetState].
class StreamMeetStateProvider extends AutoDisposeStreamProvider<Meet?> {
  /// See also [streamMeetState].
  StreamMeetStateProvider(
    String id, {
    bool allStatus = false,
  }) : this._internal(
          (ref) => streamMeetState(
            ref as StreamMeetStateRef,
            id,
            allStatus: allStatus,
          ),
          from: streamMeetStateProvider,
          name: r'streamMeetStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$streamMeetStateHash,
          dependencies: StreamMeetStateFamily._dependencies,
          allTransitiveDependencies:
              StreamMeetStateFamily._allTransitiveDependencies,
          id: id,
          allStatus: allStatus,
        );

  StreamMeetStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.allStatus,
  }) : super.internal();

  final String id;
  final bool allStatus;

  @override
  Override overrideWith(
    Stream<Meet?> Function(StreamMeetStateRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StreamMeetStateProvider._internal(
        (ref) => create(ref as StreamMeetStateRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
        allStatus: allStatus,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Meet?> createElement() {
    return _StreamMeetStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StreamMeetStateProvider &&
        other.id == id &&
        other.allStatus == allStatus;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, allStatus.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin StreamMeetStateRef on AutoDisposeStreamProviderRef<Meet?> {
  /// The parameter `id` of this provider.
  String get id;

  /// The parameter `allStatus` of this provider.
  bool get allStatus;
}

class _StreamMeetStateProviderElement
    extends AutoDisposeStreamProviderElement<Meet?> with StreamMeetStateRef {
  _StreamMeetStateProviderElement(super.provider);

  @override
  String get id => (origin as StreamMeetStateProvider).id;
  @override
  bool get allStatus => (origin as StreamMeetStateProvider).allStatus;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

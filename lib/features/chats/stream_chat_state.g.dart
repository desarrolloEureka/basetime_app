// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stream_chat_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$streamChatStateHash() => r'ed8f7bf99f35f28722302d903e7fac75d1e75dad';

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

/// See also [streamChatState].
@ProviderFor(streamChatState)
const streamChatStateProvider = StreamChatStateFamily();

/// See also [streamChatState].
class StreamChatStateFamily extends Family<AsyncValue<Chat>> {
  /// See also [streamChatState].
  const StreamChatStateFamily();

  /// See also [streamChatState].
  StreamChatStateProvider call(
    String matchID,
  ) {
    return StreamChatStateProvider(
      matchID,
    );
  }

  @override
  StreamChatStateProvider getProviderOverride(
    covariant StreamChatStateProvider provider,
  ) {
    return call(
      provider.matchID,
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
  String? get name => r'streamChatStateProvider';
}

/// See also [streamChatState].
class StreamChatStateProvider extends AutoDisposeStreamProvider<Chat> {
  /// See also [streamChatState].
  StreamChatStateProvider(
    String matchID,
  ) : this._internal(
          (ref) => streamChatState(
            ref as StreamChatStateRef,
            matchID,
          ),
          from: streamChatStateProvider,
          name: r'streamChatStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$streamChatStateHash,
          dependencies: StreamChatStateFamily._dependencies,
          allTransitiveDependencies:
              StreamChatStateFamily._allTransitiveDependencies,
          matchID: matchID,
        );

  StreamChatStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.matchID,
  }) : super.internal();

  final String matchID;

  @override
  Override overrideWith(
    Stream<Chat> Function(StreamChatStateRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StreamChatStateProvider._internal(
        (ref) => create(ref as StreamChatStateRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        matchID: matchID,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Chat> createElement() {
    return _StreamChatStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StreamChatStateProvider && other.matchID == matchID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, matchID.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin StreamChatStateRef on AutoDisposeStreamProviderRef<Chat> {
  /// The parameter `matchID` of this provider.
  String get matchID;
}

class _StreamChatStateProviderElement
    extends AutoDisposeStreamProviderElement<Chat> with StreamChatStateRef {
  _StreamChatStateProviderElement(super.provider);

  @override
  String get matchID => (origin as StreamChatStateProvider).matchID;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

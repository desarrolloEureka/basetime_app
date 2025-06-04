// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$commentsStateHash() => r'6698859d8f48bf33116c3741665f6e56de5470bb';

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

abstract class _$CommentsState
    extends BuildlessAutoDisposeAsyncNotifier<List<Comment>> {
  late final String? userID;

  FutureOr<List<Comment>> build(
    String? userID,
  );
}

/// See also [CommentsState].
@ProviderFor(CommentsState)
const commentsStateProvider = CommentsStateFamily();

/// See also [CommentsState].
class CommentsStateFamily extends Family<AsyncValue<List<Comment>>> {
  /// See also [CommentsState].
  const CommentsStateFamily();

  /// See also [CommentsState].
  CommentsStateProvider call(
    String? userID,
  ) {
    return CommentsStateProvider(
      userID,
    );
  }

  @override
  CommentsStateProvider getProviderOverride(
    covariant CommentsStateProvider provider,
  ) {
    return call(
      provider.userID,
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
  String? get name => r'commentsStateProvider';
}

/// See also [CommentsState].
class CommentsStateProvider
    extends AutoDisposeAsyncNotifierProviderImpl<CommentsState, List<Comment>> {
  /// See also [CommentsState].
  CommentsStateProvider(
    String? userID,
  ) : this._internal(
          () => CommentsState()..userID = userID,
          from: commentsStateProvider,
          name: r'commentsStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$commentsStateHash,
          dependencies: CommentsStateFamily._dependencies,
          allTransitiveDependencies:
              CommentsStateFamily._allTransitiveDependencies,
          userID: userID,
        );

  CommentsStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userID,
  }) : super.internal();

  final String? userID;

  @override
  FutureOr<List<Comment>> runNotifierBuild(
    covariant CommentsState notifier,
  ) {
    return notifier.build(
      userID,
    );
  }

  @override
  Override overrideWith(CommentsState Function() create) {
    return ProviderOverride(
      origin: this,
      override: CommentsStateProvider._internal(
        () => create()..userID = userID,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userID: userID,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<CommentsState, List<Comment>>
      createElement() {
    return _CommentsStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CommentsStateProvider && other.userID == userID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userID.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CommentsStateRef on AutoDisposeAsyncNotifierProviderRef<List<Comment>> {
  /// The parameter `userID` of this provider.
  String? get userID;
}

class _CommentsStateProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CommentsState,
        List<Comment>> with CommentsStateRef {
  _CommentsStateProviderElement(super.provider);

  @override
  String? get userID => (origin as CommentsStateProvider).userID;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

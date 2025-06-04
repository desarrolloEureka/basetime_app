// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stream_skill_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$streamSkillsHash() => r'b68e3f4d2314985cef7bd677c6dab99bde3cab42';

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

/// See also [streamSkills].
@ProviderFor(streamSkills)
const streamSkillsProvider = StreamSkillsFamily();

/// See also [streamSkills].
class StreamSkillsFamily extends Family<AsyncValue<List<Skill>>> {
  /// See also [streamSkills].
  const StreamSkillsFamily();

  /// See also [streamSkills].
  StreamSkillsProvider call(
    String userID,
  ) {
    return StreamSkillsProvider(
      userID,
    );
  }

  @override
  StreamSkillsProvider getProviderOverride(
    covariant StreamSkillsProvider provider,
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
  String? get name => r'streamSkillsProvider';
}

/// See also [streamSkills].
class StreamSkillsProvider extends AutoDisposeStreamProvider<List<Skill>> {
  /// See also [streamSkills].
  StreamSkillsProvider(
    String userID,
  ) : this._internal(
          (ref) => streamSkills(
            ref as StreamSkillsRef,
            userID,
          ),
          from: streamSkillsProvider,
          name: r'streamSkillsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$streamSkillsHash,
          dependencies: StreamSkillsFamily._dependencies,
          allTransitiveDependencies:
              StreamSkillsFamily._allTransitiveDependencies,
          userID: userID,
        );

  StreamSkillsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userID,
  }) : super.internal();

  final String userID;

  @override
  Override overrideWith(
    Stream<List<Skill>> Function(StreamSkillsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StreamSkillsProvider._internal(
        (ref) => create(ref as StreamSkillsRef),
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
  AutoDisposeStreamProviderElement<List<Skill>> createElement() {
    return _StreamSkillsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StreamSkillsProvider && other.userID == userID;
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
mixin StreamSkillsRef on AutoDisposeStreamProviderRef<List<Skill>> {
  /// The parameter `userID` of this provider.
  String get userID;
}

class _StreamSkillsProviderElement
    extends AutoDisposeStreamProviderElement<List<Skill>> with StreamSkillsRef {
  _StreamSkillsProviderElement(super.provider);

  @override
  String get userID => (origin as StreamSkillsProvider).userID;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

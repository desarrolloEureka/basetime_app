// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'async_sub_categories_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$asyncSubCategoriesStateHash() =>
    r'1534a2156bdba828e25f2c93cc521bec0ac8deb4';

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

abstract class _$AsyncSubCategoriesState
    extends BuildlessAutoDisposeAsyncNotifier<List<CategoryEntity>> {
  late final List<CategoryEntity> categories;

  FutureOr<List<CategoryEntity>> build(
    List<CategoryEntity> categories,
  );
}

/// See also [AsyncSubCategoriesState].
@ProviderFor(AsyncSubCategoriesState)
const asyncSubCategoriesStateProvider = AsyncSubCategoriesStateFamily();

/// See also [AsyncSubCategoriesState].
class AsyncSubCategoriesStateFamily
    extends Family<AsyncValue<List<CategoryEntity>>> {
  /// See also [AsyncSubCategoriesState].
  const AsyncSubCategoriesStateFamily();

  /// See also [AsyncSubCategoriesState].
  AsyncSubCategoriesStateProvider call(
    List<CategoryEntity> categories,
  ) {
    return AsyncSubCategoriesStateProvider(
      categories,
    );
  }

  @override
  AsyncSubCategoriesStateProvider getProviderOverride(
    covariant AsyncSubCategoriesStateProvider provider,
  ) {
    return call(
      provider.categories,
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
  String? get name => r'asyncSubCategoriesStateProvider';
}

/// See also [AsyncSubCategoriesState].
class AsyncSubCategoriesStateProvider
    extends AutoDisposeAsyncNotifierProviderImpl<AsyncSubCategoriesState,
        List<CategoryEntity>> {
  /// See also [AsyncSubCategoriesState].
  AsyncSubCategoriesStateProvider(
    List<CategoryEntity> categories,
  ) : this._internal(
          () => AsyncSubCategoriesState()..categories = categories,
          from: asyncSubCategoriesStateProvider,
          name: r'asyncSubCategoriesStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$asyncSubCategoriesStateHash,
          dependencies: AsyncSubCategoriesStateFamily._dependencies,
          allTransitiveDependencies:
              AsyncSubCategoriesStateFamily._allTransitiveDependencies,
          categories: categories,
        );

  AsyncSubCategoriesStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categories,
  }) : super.internal();

  final List<CategoryEntity> categories;

  @override
  FutureOr<List<CategoryEntity>> runNotifierBuild(
    covariant AsyncSubCategoriesState notifier,
  ) {
    return notifier.build(
      categories,
    );
  }

  @override
  Override overrideWith(AsyncSubCategoriesState Function() create) {
    return ProviderOverride(
      origin: this,
      override: AsyncSubCategoriesStateProvider._internal(
        () => create()..categories = categories,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categories: categories,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<AsyncSubCategoriesState,
      List<CategoryEntity>> createElement() {
    return _AsyncSubCategoriesStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AsyncSubCategoriesStateProvider &&
        other.categories == categories;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categories.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AsyncSubCategoriesStateRef
    on AutoDisposeAsyncNotifierProviderRef<List<CategoryEntity>> {
  /// The parameter `categories` of this provider.
  List<CategoryEntity> get categories;
}

class _AsyncSubCategoriesStateProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<AsyncSubCategoriesState,
        List<CategoryEntity>> with AsyncSubCategoriesStateRef {
  _AsyncSubCategoriesStateProviderElement(super.provider);

  @override
  List<CategoryEntity> get categories =>
      (origin as AsyncSubCategoriesStateProvider).categories;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

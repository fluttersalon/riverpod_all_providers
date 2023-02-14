// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api

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

String _$CountHash() => r'b2702e1b03c555c55f544084ce908bd0342c31c9';

/// See also [Count].
final countProvider = AutoDisposeNotifierProvider<Count, int>(
  Count.new,
  name: r'countProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$CountHash,
);
typedef CountRef = AutoDisposeNotifierProviderRef<int>;

abstract class _$Count extends AutoDisposeNotifier<int> {
  @override
  int build();
}

String _$githubUrlHash() => r'2955f53444f1491327c8f25f5f853564945640e3';

/// See also [githubUrl].
final githubUrlProvider = Provider<String>(
  githubUrl,
  name: r'githubUrlProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$githubUrlHash,
);
typedef GithubUrlRef = ProviderRef<String>;
String _$repositoryTitleHash() => r'b21418a57188d40b614745a99e7877e616b1791d';

/// See also [repositoryTitle].
class RepositoryTitleProvider extends AutoDisposeFutureProvider<String> {
  RepositoryTitleProvider({
    required this.page,
    required this.keyword,
  }) : super(
          (ref) => repositoryTitle(
            ref,
            page: page,
            keyword: keyword,
          ),
          from: repositoryTitleProvider,
          name: r'repositoryTitleProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$repositoryTitleHash,
        );

  final int page;
  final String keyword;

  @override
  bool operator ==(Object other) {
    return other is RepositoryTitleProvider &&
        other.page == page &&
        other.keyword == keyword;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);
    hash = _SystemHash.combine(hash, keyword.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef RepositoryTitleRef = AutoDisposeFutureProviderRef<String>;

/// See also [repositoryTitle].
final repositoryTitleProvider = RepositoryTitleFamily();

class RepositoryTitleFamily extends Family<AsyncValue<String>> {
  RepositoryTitleFamily();

  RepositoryTitleProvider call({
    required int page,
    required String keyword,
  }) {
    return RepositoryTitleProvider(
      page: page,
      keyword: keyword,
    );
  }

  @override
  AutoDisposeFutureProvider<String> getProviderOverride(
    covariant RepositoryTitleProvider provider,
  ) {
    return call(
      page: provider.page,
      keyword: provider.keyword,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'repositoryTitleProvider';
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cryptoHash() => r'b075c9c25a7e067d55d6ebfd112c5ee7283af758';

/// See also [Crypto].
@ProviderFor(Crypto)
final cryptoProvider =
    AutoDisposeAsyncNotifierProvider<Crypto, List<Coin>>.internal(
      Crypto.new,
      name: r'cryptoProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$cryptoHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$Crypto = AutoDisposeAsyncNotifier<List<Coin>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

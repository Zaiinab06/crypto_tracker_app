import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/coin_model.dart';

part 'crypto_provider.g.dart';

class CryptoException implements Exception {
  final String message;
  CryptoException(this.message);

  @override
  String toString() => message;
}

@riverpod
class Crypto extends _$Crypto {
  @override
  FutureOr<List<Coin>> build() async {
    return _fetchData();
  }

  Future<List<Coin>> _fetchData() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&page=1&sparkline=false',
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Coin.fromJson(json)).toList();
      } else {
        throw CryptoException(
          'Server error: Too many requests. Please try again in a minute.',
        );
      }
    } catch (e) {
      if (e is CryptoException) {
        rethrow;
      }
      throw CryptoException(
        'Failed to load data. Please check your internet connection.',
      );
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading<List<Coin>>().copyWithPrevious(state);
    state = await AsyncValue.guard(() => _fetchData());
  }
}

import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../models/coin_model.dart';
import 'crypto_event.dart';
import 'crypto_state.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  CryptoBloc() : super(CryptoLoading()) {
    on<FetchCryptoPrices>(_onFetchCryptoPrices);
    on<RefreshCryptoPrices>(_onRefreshCryptoPrices);
  }

  Future<void> _onFetchCryptoPrices(
    FetchCryptoPrices event,
    Emitter<CryptoState> emit,
  ) async {
    emit(CryptoLoading());
    await _fetchData(emit);
  }

  Future<void> _onRefreshCryptoPrices(
    RefreshCryptoPrices event,
    Emitter<CryptoState> emit,
  ) async {
    await _fetchData(emit);
  }

  Future<void> _fetchData(Emitter<CryptoState> emit) async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&page=1&sparkline=false',
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final coins = data.map((json) => Coin.fromJson(json)).toList();
        emit(CryptoSuccess(coins));
      } else {
        emit(
          const CryptoError(
            'Server error: Too many requests. Please try again in a minute.',
          ),
        );
      }
    } catch (e) {
      emit(
        const CryptoError(
          'Failed to load data. Please check your internet connection.',
        ),
      );
    }
  }
}

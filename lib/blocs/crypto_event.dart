import 'package:equatable/equatable.dart';

abstract class CryptoEvent extends Equatable {
  const CryptoEvent();

  @override
  List<Object?> get props => [];
}

// Event 1. fetch
class FetchCryptoPrices extends CryptoEvent {}

// Event 2: refresh
class RefreshCryptoPrices extends CryptoEvent {}

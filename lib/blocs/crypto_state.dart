import 'package:equatable/equatable.dart';
import '../models/coin_model.dart';

abstract class CryptoState extends Equatable {
  const CryptoState();

  @override
  List<Object?> get props => [];
}

//  loading state
class CryptoLoading extends CryptoState {}

// success state
class CryptoSuccess extends CryptoState {
  final List<Coin> coins;

  const CryptoSuccess(this.coins);

  @override
  List<Object?> get props => [coins];
}

//   error state
class CryptoError extends CryptoState {
  final String message;

  const CryptoError(this.message);

  @override
  List<Object?> get props => [message];
}

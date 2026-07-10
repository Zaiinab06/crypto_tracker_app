import 'package:equatable/equatable.dart';

class Coin extends Equatable {
  final String id;
  final String name;
  final String symbol;
  final double currentPrice;
  final String image;

  const Coin({
    required this.id,
    required this.name,
    required this.symbol,
    required this.currentPrice,
    required this.image,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      currentPrice: (json['current_price'] as num).toDouble(),
      image: json['image'],
    );
  }

  @override
  List<Object?> get props => [id, name, symbol, currentPrice, image];
}

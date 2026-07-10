import 'package:crypto_tracker_app/blocs/crypto_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/crypto_event.dart';
import '../blocs/crypto_state.dart';
import '../cubits/favorites_cubit.dart';

class CryptoTrackerScreen extends StatelessWidget {
  const CryptoTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🪙 Live Crypto Tracker'),
        centerTitle: true,
      ),
      body: BlocListener<FavoritesCubit, FavoritesState>(
        listenWhen: (previous, current) => current.lastAdded != null,
        listener: (context, state) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${state.lastAdded!.toUpperCase()} Added to Favorites! ❤️',
              ),
              duration: const Duration(seconds: 1),
              backgroundColor: Colors.green,
            ),
          );
        },
        child: BlocBuilder<CryptoBloc, CryptoState>(
          builder: (context, state) {
            // 1. Loading State
            if (state is CryptoLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            // 2. Success State
            else if (state is CryptoSuccess) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<CryptoBloc>().add(RefreshCryptoPrices());
                },
                child: ListView.builder(
                  itemCount: state.coins.length,
                  itemBuilder: (context, index) {
                    final coin = state.coins[index];
                    return ListTile(
                      leading: Image.network(
                        coin.image,
                        width: 35,
                        height: 35,

                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.monetization_on),
                      ),
                      title: Text(
                        '${coin.name} (${coin.symbol.toUpperCase()})',
                      ),
                      subtitle: Text(
                        '\$${coin.currentPrice.toStringAsFixed(2)}',
                      ),
                      trailing: BlocBuilder<FavoritesCubit, FavoritesState>(
                        builder: (context, favState) {
                          final isFavorite = favState.favoriteIds.contains(
                            coin.id,
                          );
                          return IconButton(
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {
                              context.read<FavoritesCubit>().toggleFavorite(
                                coin.id,
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            }
            // 3. Error State
            else if (state is CryptoError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.wifi_off,
                        size: 60,
                        color: Colors.redAccent,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () {
                          context.read<CryptoBloc>().add(FetchCryptoPrices());
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Try Again'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

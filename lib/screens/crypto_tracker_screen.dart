import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/crypto_provider.dart';
import '../providers/favorites_provider.dart';

class CryptoTrackerScreen extends ConsumerWidget {
  const CryptoTrackerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cryptoState = ref.watch(cryptoProvider);
    final favoritesState = ref.watch(favoritesProvider);

    // Listener for adding to favorites
    ref.listen<FavoritesState>(favoritesProvider, (previous, next) {
      if (next.lastAdded != null && next.lastAdded != previous?.lastAdded) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${next.lastAdded!.toUpperCase()} Added to Favorites! ❤️',
            ),
            duration: const Duration(seconds: 1),
            backgroundColor: Colors.green,
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('🪙 Live Crypto Tracker'),
        centerTitle: true,
      ),
      body: cryptoState.when(
        data: (coins) {
          return RefreshIndicator(
            onRefresh: () async {
              await ref.read(cryptoProvider.notifier).refresh();
            },
            child: ListView.builder(
              itemCount: coins.length,
              itemBuilder: (context, index) {
                final coin = coins[index];
                final isFavorite = favoritesState.favoriteIds.contains(coin.id);

                return ListTile(
                  leading: Padding(
                    padding: EdgeInsets.all(10),
                    child: Image.network(
                      coin.image,
                      width: 35,
                      height: 35,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.monetization_on),
                    ),
                  ),

                  title: Text('${coin.name} (${coin.symbol.toUpperCase()})'),
                  subtitle: Text('\$${coin.currentPrice.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      ref
                          .read(favoritesProvider.notifier)
                          .toggleFavorite(coin.id);
                    },
                  ),
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) {
          final errorMessage = error.toString();
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, size: 60, color: Colors.redAccent),
                  const SizedBox(height: 15),
                  Text(
                    errorMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      ref.read(cryptoProvider.notifier).refresh();
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
        },
      ),
    );
  }
}

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorites_provider.g.dart';

class FavoritesState {
  final List<String> favoriteIds;
  final String? lastAdded;

  FavoritesState({required this.favoriteIds, this.lastAdded});
}

@riverpod
class Favorites extends _$Favorites {
  @override
  FavoritesState build() {
    return FavoritesState(favoriteIds: const []);
  }

  void toggleFavorite(String coinId) {
    final isFavorite = state.favoriteIds.contains(coinId);
    final updatedList = List<String>.from(state.favoriteIds);

    if (isFavorite) {
      updatedList.remove(coinId);
      state = FavoritesState(favoriteIds: updatedList, lastAdded: null);
    } else {
      updatedList.add(coinId);
      state = FavoritesState(favoriteIds: updatedList, lastAdded: coinId);
    }
  }
}

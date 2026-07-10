import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesState {
  final List<String> favoriteIds;
  final String? lastAdded;

  FavoritesState({required this.favoriteIds, this.lastAdded});
}

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesState(favoriteIds: []));

  void toggleFavorite(String coinId) {
    final isFavorite = state.favoriteIds.contains(coinId);
    List<String> updatedList = List.from(state.favoriteIds);

    if (isFavorite) {
      updatedList.remove(coinId);

      emit(FavoritesState(favoriteIds: updatedList, lastAdded: null));
    } else {
      updatedList.add(coinId);

      emit(FavoritesState(favoriteIds: updatedList, lastAdded: coinId));
    }
  }
}

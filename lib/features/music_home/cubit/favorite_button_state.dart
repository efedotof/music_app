part of 'favorite_button_cubit.dart';

@freezed
class FavoriteButtonState with _$FavoriteButtonState {
  const factory FavoriteButtonState.noFavorite() = _NoFavorite;
  const factory FavoriteButtonState.favorite() = _Favorite;
}

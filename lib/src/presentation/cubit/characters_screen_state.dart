part of 'characters_screen_cubit.dart';

@freezed
abstract class CharactersScreenState with _$CharactersScreenState {
  const factory CharactersScreenState.loading() = _Loading;
  const factory CharactersScreenState.loaded({
    required List<Character> characters,
    required int pagesCount,
    required int currentPage,
    @Default(false) bool loadingMore,
    @Default(false) bool errorWhileLoadingMore,
  }) = _Loaded;
  const factory CharactersScreenState.error() = _Error;
}

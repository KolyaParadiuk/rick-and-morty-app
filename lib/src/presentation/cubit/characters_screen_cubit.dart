import 'package:bloc/bloc.dart';
import 'package:casino_test/src/domain/entities/character.dart';
import 'package:casino_test/src/domain/use_cases/get_chatacters_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'characters_screen_state.dart';

part 'characters_screen_cubit.freezed.dart';

class CharactersScreenCubit extends Cubit<CharactersScreenState> {
  final GetCharactersUseCase _getCharactersUseCase;

  CharactersScreenCubit({required GetCharactersUseCase getCharactersUseCase})
      : _getCharactersUseCase = getCharactersUseCase,
        super(const CharactersScreenState.loading());

  void init() async {
    emit(const CharactersScreenState.loading());
    try {
      final (totalPages, items) = await _getCharactersUseCase(1);
      emit(CharactersScreenState.loaded(
        characters: items,
        pagesCount: totalPages,
        currentPage: 1,
      ));
    } catch (_) {
      emit(const CharactersScreenState.error());
    }
  }

  void loadNextPage() async {
    await state.mapOrNull(loaded: (loadedState) async {
      if (loadedState.currentPage == loadedState.pagesCount) return;
      if (loadedState.loadingMore) return;
      emit(loadedState.copyWith(loadingMore: true));
      final page = loadedState.currentPage + 1;
      try {
        final (totalPages, items) = await _getCharactersUseCase(page);
        emit(
          CharactersScreenState.loaded(
            characters: [...loadedState.characters, ...items],
            pagesCount: totalPages,
            currentPage: page,
          ),
        );
      } catch (e) {
        emit(loadedState.copyWith(
            loadingMore: false, errorWhileLoadingMore: true));
      }
    });
  }
}

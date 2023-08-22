import 'package:casino_test/src/domain/entities/character.dart';
import 'package:casino_test/src/domain/failures/character_failure.dart';
import 'package:casino_test/src/domain/repositories/characters_repository.dart';

abstract class GetCharactersUseCase {
  Future<(int, List<Character>)> call(int page);
}

class GetCharactersUseCaseImpl implements GetCharactersUseCase {
  final CharactersRepository _repository;

  GetCharactersUseCaseImpl({required CharactersRepository repository})
      : _repository = repository;

  @override
  Future<(int, List<Character>)> call(int page) async {
    try {
      return await _repository.getCharacters(page);
    } catch (e) {
      throw CharacterFailure();
    }
  }
}

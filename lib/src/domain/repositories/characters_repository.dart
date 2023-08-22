import 'package:casino_test/src/domain/entities/character.dart';

abstract class CharactersRepository {
  Future<(int pagesCount, List<Character> items)> getCharacters(int page);
}

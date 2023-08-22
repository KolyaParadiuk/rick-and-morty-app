import 'dart:async';
import 'package:casino_test/src/data/data_source/characters_api.dart';
import 'package:casino_test/src/domain/entities/character.dart';
import 'package:casino_test/src/domain/repositories/characters_repository.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final CharactersApi _dataSourse;

  CharactersRepositoryImpl({required CharactersApi api}) : _dataSourse = api;

  @override
  Future<(int, List<Character>)> getCharacters(int page) async {
    final response = await _dataSourse.getCharacters(page);

    final items = response.results
        .map((item) => Character(
              name: item.name,
              image: item.image,
              species: item.species,
              gender: item.gender,
            ))
        .toList();
    return (response.info.pages, items);
  }
}

import 'package:casino_test/src/data/models/character_dto.dart';
import 'package:casino_test/src/data/models/response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'characters_api.g.dart';

@RestApi()
abstract class CharactersApi {
  factory CharactersApi(Dio dio) = _CharactersApi;

  @GET('/character')
  Future<BaseResponse<CharacterDTO>> getCharacters(@Query('page') int page);
}

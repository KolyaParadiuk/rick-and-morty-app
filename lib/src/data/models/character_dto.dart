import 'package:json_annotation/json_annotation.dart';

part 'character_dto.g.dart';

@JsonSerializable()
class CharacterDTO {
  final String name;
  final String image;
  final String species;
  final String gender;

  CharacterDTO(this.name, this.image, this.gender, this.species);

  factory CharacterDTO.fromJson(Map<String, dynamic> json) =>
      _$CharacterDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterDTOToJson(this);
}

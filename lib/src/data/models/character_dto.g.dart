// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterDTO _$CharacterDTOFromJson(Map<String, dynamic> json) => CharacterDTO(
      json['name'] as String,
      json['image'] as String,
      json['gender'] as String,
      json['species'] as String,
    );

Map<String, dynamic> _$CharacterDTOToJson(CharacterDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'species': instance.species,
      'gender': instance.gender,
    };

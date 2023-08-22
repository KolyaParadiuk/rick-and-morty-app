// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationInfoDTO _$PaginationInfoDTOFromJson(Map<String, dynamic> json) =>
    PaginationInfoDTO(
      json['count'] as int,
      json['pages'] as int,
    );

Map<String, dynamic> _$PaginationInfoDTOToJson(PaginationInfoDTO instance) =>
    <String, dynamic>{
      'count': instance.count,
      'pages': instance.pages,
    };

import 'package:json_annotation/json_annotation.dart';

part 'pagination_info_dto.g.dart';

@JsonSerializable()
class PaginationInfoDTO {
  final int count;
  final int pages;

  PaginationInfoDTO(this.count, this.pages);

  factory PaginationInfoDTO.fromJson(Map<String, dynamic> json) =>
      _$PaginationInfoDTOFromJson(json);
}

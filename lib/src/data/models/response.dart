import 'package:casino_test/src/data/models/pagination_info_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> {
  final PaginationInfoDTO info;
  final List<T> results;

  BaseResponse(this.info, this.results);

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BaseResponseFromJson(json, fromJsonT);
}

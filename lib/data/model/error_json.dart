
import 'package:json_annotation/json_annotation.dart';

part '../model_json/error_json.g.dart';

@JsonSerializable()
class JsonError{
  int? statusCode;
  String? err;

  JsonError({this.statusCode,this.err});

  factory JsonError.fromJson(Map<String, dynamic> json) => _$JsonErrorFromJson(json);

  Map<String, dynamic> toJson() => _$JsonErrorToJson(this);
}
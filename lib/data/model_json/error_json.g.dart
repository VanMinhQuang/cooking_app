// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../model/error_json.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonError _$JsonErrorFromJson(Map<String, dynamic> json) => JsonError(
      statusCode: (json['statusCode'] as num?)?.toInt(),
      err: json['err'] as String?,
    );

Map<String, dynamic> _$JsonErrorToJson(JsonError instance) => <String, dynamic>{
      'statusCode': instance.statusCode,
      'err': instance.err,
    };

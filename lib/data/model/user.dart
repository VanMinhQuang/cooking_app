import 'package:json_annotation/json_annotation.dart';
part '../model_json/user.g.dart';

@JsonSerializable()
class LocalUser{
  String? uid;
  String? avatar;
  String? email;
  String? displayName;
  String? token;
  LocalUser({this.uid, this.avatar, this.email, this.displayName, this.token});

  factory LocalUser.fromJson(Map<String, dynamic> json) => _$LocalUserFromJson(json);

  Map<String, dynamic> toJson() => _$LocalUserToJson(this);
}
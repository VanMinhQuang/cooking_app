part of '../model/user.dart';
LocalUser _$LocalUserFromJson(Map<String, dynamic> json) => LocalUser(
  uid: json['uid'] ?? '',
  avatar: json['avatar'] ?? '',
  email: json['email'] ?? '',
  token: json['token'] ?? '',
  displayName: json['displayName'] ?? ''
);

Map<String, dynamic> _$LocalUserToJson(LocalUser instance) => <String, dynamic>{
  'uid': instance.uid,
  'avatar': instance.avatar,
  'email': instance.email,
  'token': instance.token,
  'displayName': instance.displayName
};
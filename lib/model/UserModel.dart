import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/UserModel.freezed.dart';
part 'generated/UserModel.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String userId,
    required String userNickname,
    required String userName,
    required String userPhone,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
    required Object createdAt,
    required String profileImageUrl,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

Object _timestampFromJson(Object timestamp) => timestamp;

Object _timestampToJson(Object timestamp) => timestamp;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/UserDataModel.freezed.dart';
part 'generated/UserDataModel.g.dart';

@freezed
class UserDataModel with _$UserDataModel {
  @JsonSerializable(explicitToJson: true)
  factory UserDataModel({
    String? userName,
    String? userEmail,
    String? userNickname,
    String? phone,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
    DateTime? createdAt,
  }) = _UserDataModel;

  factory UserDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserDataModelFromJson(json);
}

DateTime? _timestampFromJson(dynamic timestamp) {
  if (timestamp is Timestamp) {
    return timestamp.toDate();
  } else if (timestamp is int) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }
  return null;
}

Timestamp? _timestampToJson(DateTime? date) =>
    date != null ? Timestamp.fromDate(date) : null;

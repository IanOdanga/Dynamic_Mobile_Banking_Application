import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User({
    required this.token,
    required this.avatar,
    required this.firstname,
    required this.id,
    required this.lastname,
  });

  final int id;

  @JsonKey(name: "first_name")
  final String firstname;

  @JsonKey(name: "last_name")
  final String lastname;

  final String avatar;

  @JsonKey(nullable: true)
  String token;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return "$firstname $lastname".toString();
  }
}
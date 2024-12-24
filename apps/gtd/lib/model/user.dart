import 'package:common/common.dart';
import 'package:json_annotation/json_annotation.dart';

import '../main.dart';
part 'user.g.dart';

@reflectorModel
@JsonSerializable()
class User extends JsonSerializableModel  {

  int? id;
  String? name;
  String? email;

  User({this.id, this.name, this.email});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email}';
  }

}
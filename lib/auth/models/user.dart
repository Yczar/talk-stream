import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'user.g.dart';

/// A class representing a user.
@immutable
@JsonSerializable()
class User extends Equatable {
  const User({
    this.id,
    this.name,
    this.email,
    this.profileImage,
    this.username,
    this.password,
  });

  /// The unique identifier of the user.
  final String? id;

  /// The name of the user.
  final String? name;

  /// The email address of the user.
  final String? email;

  /// The URL of the user's profile image.
  final String? profileImage;

  /// The username of the user.
  final String? username;

  /// The password of the user.
  final String? password;

  /// Creates a new instance of `User` with updated values.
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? profileImage,
    String? username,
    String? password,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  /// Converts a JSON object to an instance of `User`.
  static User fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Converts an instance of `User` to a JSON object.
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props {
    return [
      id,
      name,
      email,
      profileImage,
      username,
      password,
    ];
  }
}

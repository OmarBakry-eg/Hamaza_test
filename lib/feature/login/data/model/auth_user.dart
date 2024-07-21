// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// import 'package:equatable/equatable.dart';

// class AuthenticationUser extends Equatable {
//   const AuthenticationUser({
//     required this.id,
//     this.email,
//     this.name,
//     this.photo,
//     this.isNewUser = true,
//     this.password
//   });

//   /// The current user's email address.
//   final String? email;

//   /// The current user's id.
//   final String id;

//   /// The current user's name (display name).
//   final String? name;

//   /// Url for the current user's photo.
//   final String? photo;

//   /// Whether the current user is a first time user.
//   final bool isNewUser;

//  /// The current user's password. (LOCAL ONLY)
//   final String? password;

//   /// Whether the current user is anonymous.
//   bool get isAnonymous => this == anonymous;

//   /// Anonymous user which represents an unauthenticated user.
//   static const anonymous = AuthenticationUser(id: '');

//   @override
//   List<Object?> get props => [email, id, name, photo, isNewUser];

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'email': email,
//       'id': id,
//       'name': name,
//       'photo': photo,
//       'isNewUser': isNewUser,
//       'password': password
//     };
//   }

//   factory AuthenticationUser.fromMap(Map<String, dynamic> map) {
//     return AuthenticationUser(
//       email: map['email'] != null ? map['email'] as String : null,
//       id: map['id'] as String,
//       name: map['name'] != null ? map['name'] as String : null,
//       photo: map['photo'] != null ? map['photo'] as String : null,
//       isNewUser: map['isNewUser'] as bool,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory AuthenticationUser.fromJson(String source) =>
//       AuthenticationUser.fromMap(json.decode(source) as Map<String, dynamic>);

//   AuthenticationUser copyWith({
//     String? email,
//     String? id,
//     String? name,
//     String? photo,
//     bool? isNewUser,
//     String? password,
//   }) {
//     return AuthenticationUser(
//       email: email ?? this.email,
//       id: id ?? this.id,
//       name: name ?? this.name,
//       photo: photo ?? this.photo,
//       isNewUser: isNewUser ?? this.isNewUser,
//       password: password ?? this.password,
//     );
//   }
// }

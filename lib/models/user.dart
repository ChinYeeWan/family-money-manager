import 'member.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String id;
  final String username;
  final String email;
  final String password;
  final String type;
  final List<Member> members;
  User(
      {this.id,
      this.username,
      this.email,
      this.password,
      this.type,
      this.members});

  User copyWith(
      {String id,
      String username,
      String email,
      String password,
      String type,
      List<Member> members}) {
    return User(
        id: id ?? this.id,
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
        type: type ?? this.type,
        members: members ?? this.members);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'type': type,
      'members': members == null
          ? null
          : List<dynamic>.from(members.map((x) => x.toJson())),
    };
  }

  User.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'] as String,
            username: json['username'] as String,
            email: json['email'] as String,
            password: json['password'] as String,
            type: json['type'] as String,
            members: json['members'] == null
                ? null
                : List<Member>.from(
                    json["members"].map((x) => Member.fromJson(x))));

  @override
  String toString() {
    return 'User(id: $id, username: $username, email: $email, password: $password, type: $type, members: $members)';
  }

  ///get function to get the properties of Item
  dynamic get(String propertyName) {
    var _mapRep = toJson();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError('propery not found');
  }
}

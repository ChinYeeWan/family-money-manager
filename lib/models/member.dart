// ignore_for_file: public_member_api_docs, sort_constructors_first
class Member {
  final String id;
  final String username;
  Member({
    this.id,
    this.username,
  });

  set id(value) => id = value;

  @override
  String toString() => 'Member(id: $id, username: $username)';

  Member copyWith({
    String id,
    String username,
  }) {
    return Member(
      id: id ?? this.id,
      username: username ?? this.username,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'username': username,
    };
  }

  Member.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String,
          username: json['username'] as String,
        );

  ///get function to get the properties of Item
  dynamic get(String propertyName) {
    var _mapRep = toJson();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError('propery not found');
  }
}

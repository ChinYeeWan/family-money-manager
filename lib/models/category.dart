class Category {
  String id;
  String type;
  String name;
  String icon;
  int color;
  bool delete;
  String userId;
  Category(
      {this.id,
      this.type,
      this.name,
      this.icon,
      this.color,
      this.delete,
      this.userId});

  Category copyWith(
      {String id,
      String type,
      String name,
      String icon,
      int color,
      bool delete,
      String userId}) {
    return Category(
        id: id ?? this.id,
        type: type ?? this.type,
        name: name ?? this.name,
        icon: icon ?? this.icon,
        color: color ?? this.color,
        delete: delete ?? this.delete,
        userId: userId ?? this.userId);
  }

  Category.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'] as String,
            type: json['type'] as String,
            name: json['name'] as String,
            icon: json['icon'] as String,
            color: json['color'] as int,
            delete: json['delete'] as bool,
            userId: json['userId'] as String);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'name': name,
      'icon': icon,
      'color': color,
      'delete': delete,
      'userId': userId
    };
  }

  @override
  String toString() {
    return 'Category(id: $id, type: $type, name: $name, icon: $icon, color: $color, delete: $delete, userId: $userId)';
  }

  //get function to get the properties of Item
  dynamic get(String propertyName) {
    var _mapRep = toJson();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError('propery not found');
  }
}

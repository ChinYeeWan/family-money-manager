class Category {
  final String id;
  final String type;
  final String name;
  final String icon;
  final int color;
  final bool delete;
  final int userId;
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
      int userId}) {
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
            userId: json['userId'] as int);

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

  set id(value) => id = value;
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'category.dart';

class Transaction {
  String id;
  String type; // expense / income
  String memo; // asset path / photo
  String month; // month => feb
  int day; // day
  int year; // year
  double amount; // 300 or 200
  Category category; // 0,1,2,...etc
  String userId;
  String imagePath;
  Transaction(
      {this.id,
      this.type,
      this.memo,
      this.day,
      this.month,
      this.year,
      this.amount,
      this.category,
      this.userId,
      this.imagePath});

  Transaction copyWith(
      {String id,
      String type,
      String memo,
      int day,
      String month,
      int year,
      double amount,
      Category category,
      String userId,
      String imagePath}) {
    return Transaction(
        id: id ?? this.id,
        type: type ?? this.type,
        memo: memo ?? this.memo,
        day: day ?? this.day,
        month: month ?? this.month,
        year: year ?? this.year,
        amount: amount ?? this.amount,
        category: category ?? this.category,
        userId: userId ?? this.userId,
        imagePath: imagePath ?? this.imagePath);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'memo': memo,
      'day': day,
      'month': month,
      'year': year,
      'amount': amount,
      'category': category.toJson(),
      'userId': userId,
      'imagePath': imagePath
    };
  }

  Transaction.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            type: json['type'],
            memo: json['memo'],
            day: json['day'],
            month: json['month'],
            year: json['year'],
            amount: json['amount'].toDouble(),
            category:
                Category.fromJson(json['category'] as Map<String, dynamic>),
            userId: json['userId'],
            imagePath: json['imagePath']);

  @override
  String toString() {
    return 'Transaction(id: $id, type: $type, memo: $memo, day: $day, year: $year, amount: $amount, category: $category, userId: $userId, imagePath: $imagePath)';
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

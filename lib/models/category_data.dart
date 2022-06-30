import 'category.dart';

class CategoryData {
  CategoryData(this.category, this.amount);
  final Category category;
  final double amount;

  String toString() {
    return '{category: $category, amount: $amount}';
  }
}

import '../../locator.dart';
import '../../models/category.dart';

import 'rest_service.dart';

class CategoryServiceRest {
  final rest = locator<RestService>();

  Future<List<Category>> getCategoryList(String userId, String type) async {
    final listJson = await rest.get('categories?userId=$userId&type=$type');

    if (listJson.length == 0) {
      return [];
    } else {
      return (listJson as List)
          .map((itemJson) => Category.fromJson(itemJson))
          .toList();
    }
  }

  Future<Category> addCategory(Category category) async {
    final json = await rest.post('categories', data: category);
    return Category.fromJson(json);
  }

  Future<void> deleteCategory(String id) async {
    await rest.delete('categories/$id');
  }
}

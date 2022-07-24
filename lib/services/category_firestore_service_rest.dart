import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/category.dart';

class CategoryFirestoreServiceRest {
  final CollectionReference categoriesCollection =
      FirebaseFirestore.instance.collection("categories");

  Future<List<Category>> getCategoryList(String userId, String type) async {
    final snapshot = await categoriesCollection
        .where("userId", isEqualTo: userId)
        .where("type", isEqualTo: type)
        .get();
    print(snapshot.docs);
    if (snapshot != null) {
      return (snapshot.docs)
          .map((doc) => Category.fromJson(doc.data()))
          .toList();
    } else {
      return [];
    }
  }

  Future<Category> getCategory(Category category) async {
    final snapshot = await categoriesCollection.doc(category.id).get();

    return Category.fromJson(snapshot.data());
  }

  Future<Category> addCategory(Category category) async {
    final docCategory = categoriesCollection.doc();
    Category addCategory = new Category(
        id: docCategory.id,
        type: category.type,
        name: category.name,
        icon: category.icon,
        color: category.color,
        delete: category.delete,
        userId: category.userId);

    await docCategory.set(addCategory.toJson());

    return await getCategory(addCategory);
  }

  Future<void> deleteCategory(String id) async {
    await categoriesCollection.doc(id).delete();
  }
}

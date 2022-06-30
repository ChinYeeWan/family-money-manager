import '../locator.dart';
import '../models/category.dart';
import '../services/category_firestore_service_rest.dart';
import '../services/category_icon_service.dart';
import 'base_model.dart';

class ChooseCategoryModel extends BaseModel {
  final FixCategoryIconService _categoryIconService =
      locator<FixCategoryIconService>();
  final CategoryFirestoreServiceRest _categoryServiceRest =
      locator<CategoryFirestoreServiceRest>();

  String type = "expense"; // 1=>income,2=>expense
  List<Category> categories = [];
  String userId;

  void init(selectedType, uId) {
    userId = uId;
    type = selectedType;
    loadCategoriesIcons();
  }

  void loadCategoriesIcons() async {
    var databaseCategoryList;
    var fixCategoryList;
    setState(ViewState.Busy);
    notifyListeners();
    if (type == 'expense') {
      // load expense
      databaseCategoryList =
          await _categoryServiceRest.getCategoryList(userId, 'expense');
      fixCategoryList = _categoryIconService.expenseList.toList();
    } else {
      // load income
      databaseCategoryList =
          await _categoryServiceRest.getCategoryList(userId, 'income');
      fixCategoryList = _categoryIconService.incomeList.toList();
    }
    categories = fixCategoryList + databaseCategoryList;
    setState(ViewState.Idle);
    notifyListeners();
  }
}

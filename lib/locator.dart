import 'package:fyp/services/auth_service.dart';
import 'package:get_it/get_it.dart';

import 'services/category_firestore_service_rest.dart';
import 'services/category_icon_service.dart';
import 'services/icon_picker_data_service.dart';
import 'services/transaction_firestore_service_rest.dart';
import 'services/user_firestore_service_rest.dart';
import 'viewmodels/add_category_model.dart';
import 'viewmodels/add_member_model.dart';
import 'viewmodels/add_model.dart';
import 'viewmodels/choose_category_model.dart';
import 'viewmodels/detail_model.dart';
import 'viewmodels/edit_model.dart';
import 'viewmodels/login_model.dart';
import 'viewmodels/main_model.dart';
import 'viewmodels/manage_category_model.dart';
import 'viewmodels/manage_members_model.dart';
import 'viewmodels/overview_model.dart';
import 'viewmodels/overview_member_model.dart';
import 'viewmodels/register_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  //!SERVICES
  locator.registerLazySingleton(() => TransactionFirestoreServiceRest());
  locator.registerLazySingleton(() => CategoryFirestoreServiceRest());
  locator.registerLazySingleton(() => FixCategoryIconService());
  locator.registerLazySingleton(() => IconPickerDataService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => UserFirestoreServiceRest());

  //!VIEWMODELS
  locator.registerFactory(() => LoginModel());
  locator.registerFactory(() => RegisterModel());
  locator.registerFactory(() => MainModel());
  locator.registerFactory(() => AddModel());
  locator.registerFactory(() => EditModel());
  locator.registerFactory(() => DetailModel());
  locator.registerFactory(() => ChooseCategoryModel());
  locator.registerFactory(() => ManageCategoryModel());
  locator.registerFactory(() => AddCategoryModel());
  locator.registerFactory(() => ManageMembersModel());
  locator.registerFactory(() => AddMemberModel());
  locator.registerFactory(() => OverviewModel());
  locator.registerFactory(() => OverviewMemberModel());
}

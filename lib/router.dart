import 'package:flutter/material.dart';

import 'models/transaction.dart';
import 'models/user.dart';
import 'view/add_UI.dart';
import 'view/add_category_UI.dart';
import 'view/add_member_UI.dart';
import 'view/choose_category_UI.dart';
import 'view/detail_UI.dart';
import 'view/edit_UI.dart';
import 'view/login_UI.dart';
import 'view/main_UI.dart';
import 'view/manage_category_UI.dart';
import 'view/manage_members_UI.dart';
import 'view/overview_member_UI.dart';
import 'view/register_UI.dart';
import 'view/splash_UI.dart';

class RouterChange {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashUI());
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginUI());
      case 'register':
        return MaterialPageRoute(builder: (_) => RegisterUI());
      case 'home':
        var user = settings.arguments as User;
        return MaterialPageRoute(builder: (_) => MainUI(user));
      case 'detail':
        var transaction = settings.arguments as Transaction;
        return MaterialPageRoute(builder: (_) => DetailUI(transaction));
      case 'add':
        var args = settings.arguments as List<dynamic>;
        return MaterialPageRoute(
          builder: (_) =>
              AddUI(selectedType: args.elementAt(0), user: args.elementAt(1)),
        );
      case 'edit':
        var transaction = settings.arguments as Transaction;
        return MaterialPageRoute(
          builder: (_) => EditUI(transaction: transaction),
        );
      case 'chooseCategory':
        var args = settings.arguments as List<dynamic>;
        return MaterialPageRoute(
            builder: (_) =>
                ChooseCategoryUI(args.elementAt(0), args.elementAt(1)));
      case 'manageCategory':
        var user = settings.arguments as User;
        return MaterialPageRoute(builder: (_) => ManageCategoryUI(user: user));
      case 'addCategory':
        var args = settings.arguments as List<dynamic>;
        return MaterialPageRoute(
            builder: (_) =>
                AddCategoryUI(args.elementAt(0), args.elementAt(1)));
      case 'manageMembers':
        var user = settings.arguments as User;
        return MaterialPageRoute(builder: (_) => ManageMembersUI(user: user));
      case 'addMember':
        var args = settings.arguments as List<dynamic>;
        return MaterialPageRoute(
            builder: (_) => AddMemberUI(
                user: args.elementAt(0), members: args.elementAt(1)));
      case 'overviewMember':
        var member = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => OverviewMemberUI(user: member));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}

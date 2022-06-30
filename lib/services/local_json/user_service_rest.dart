import '../../locator.dart';
import '../../models/member.dart';
import '../../models/user.dart';
import 'rest_service.dart';

class UserServiceRest {
  final rest = locator<RestService>();

  Future<User> authenticate({String email, String password}) async {
    final List json = await rest.get('users?email=$email&&password=$password');
    if (json == null || json.length == 0) return null;

    final user = User.fromJson(json[0]);
    return user;
  }

  Future<User> checkEmailExist({String email}) async {
    final List json = await rest.get('users?email=$email');
    if (json == null || json.length == 0) return null;

    final user = User.fromJson(json[0]);
    return user;
  }

  Future<User> getUser(String userId) async {
    final json = await rest.get('users/$userId');
    return User.fromJson(json);
  }

  Future<User> addUser(User user) async {
    final json = await rest.post('users', data: user);
    return User.fromJson(json);
  }

  Future<User> addMember(String userId, List<Member> members) async {
    final json = await rest.patch('users/$userId', data: {'members': members});
    return User.fromJson(json);
  }

  Future<User> updateMember(String userId, List<Member> members) async {
    final json = await rest.patch('users/$userId', data: {'members': members});
    return User.fromJson(json);
  }

  Future<void> deleteMember(String id) async {
    await rest.delete('users/$id');
  }
}

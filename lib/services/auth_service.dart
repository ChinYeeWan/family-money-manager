import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../locator.dart';
import '../models/user.dart' as userModel;

import 'user_firestore_service_rest.dart';

class AuthService {
  final UserFirestoreServiceRest _userFirestoreService =
      locator<UserFirestoreServiceRest>();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  User get currentUser => _firebaseAuth.currentUser;

  Future<userModel.User> login(String email, String password) async {
    try {
      var _user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      userModel.User user = await _userFirestoreService.getUser(_user.user.uid);
      if (user != null) {
        return user;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Sign Up using email address
  Future<userModel.User> signUp(userModel.User user) async {
    try {
      var _user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      userModel.User addUser = new userModel.User(
          id: _user.user.uid,
          username: user.username,
          email: user.email,
          password: user.password,
          type: user.type,
          members: user.members);
      await _firebaseFirestore
          .collection('users')
          .doc(_user.user.uid)
          .set(addUser.toJson())
          .then((value) => print('User Created : ${_user.user.email}'))
          .catchError((e) => print('Database Error!'));

      return await _userFirestoreService.getUser(_user.user.uid);
    } catch (e) {
      print(e);
      print('${e.toString()} Error Occured!');
      return null;
    }
  }

  //delete user of member
  Future deleteMember(String userId) async {
    try {
      var deleteUser = await _userFirestoreService.getUser(userId);

      var _user = await _firebaseAuth.signInWithEmailAndPassword(
        email: deleteUser.email,
        password: deleteUser.password,
      );
      await _user.user.delete();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  // Sign Out
  Future<String> signOut() async {
    await _firebaseAuth.signOut();
    return 'Signed Out Successfully';
  }
}

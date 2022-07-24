import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/member.dart';
import '../models/user.dart';

class UserFirestoreServiceRest {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection("users");

  Future<User> getUser(String userId) async {
    if (userId.isNotEmpty) {
      final userDoc = await usersCollection.doc(userId).get();
      if (!userDoc.exists) {
        return null;
      }
      return User.fromJson(userDoc.data());
    } else {
      return null;
    }
  }

  Future checkEmailExist({String email}) async {
    final snapshot =
        await usersCollection.where("email", isEqualTo: email).get();
    if (snapshot.docs.length == 0) {
      return false;
    } else {
      return true;
    }
  }

  //add member to the head user
  Future addMember(String userId, Member member) async {
    final complete = await usersCollection.doc(userId).update(
      {
        "members": FieldValue.arrayUnion([member.toJson()])
      },
    ).whenComplete(() => true);
    return complete;
  }

  Future deleteMember(String userId, Member member) async {
    final complete = await usersCollection.doc(userId).update(
      {
        "members": FieldValue.arrayRemove([member.toJson()])
      },
    ).whenComplete(() => true);
    return complete;
  }

  Future deleteUser(String userId) async {
    await usersCollection.doc(userId).delete();
  }
}

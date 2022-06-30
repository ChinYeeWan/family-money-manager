import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/error_codes.dart';
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
      throw FirestoreApiException(
          message:
              'Your userId passed in is empty. Please pass in a valid user if from your Firebase user.');
    }
  }

  //add member to the head user
  Future addMember(String userId, List<Member> members) async {
    String json = jsonEncode(members);
    final complete = await usersCollection
        .doc(userId)
        .update({"members": json}).whenComplete(() => true);
    return complete;
  }

  Future updateMember(String userId, List<Member> members) async {
    String json = jsonEncode(members);
    final complete = await usersCollection
        .doc(userId)
        .update({"members": json}).whenComplete(() => true);
    return complete;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/task.dart';
import 'models/user.dart';

class MyDataBase {
  static CollectionReference<User> collectionUser() {
    return FirebaseFirestore.instance
        .collection(User.collectionName)
        .withConverter<User>(
        fromFirestore: (snapshot, options) =>
            User.FromFireStore(snapshot.data()),
        toFirestore: (user, options) {
          return user.toFireStore();
        }
    );
  }

  static Future<void> addUser(String uId, User user) {
    var collectionReference = collectionUser();
    return collectionReference.doc(uId).set(user);
  }


  static Future<User?> readUser(String uId) async {
    var collectionReference = collectionUser();
    var documentSnapshot = await collectionReference.doc(uId).get();
    return documentSnapshot.data();
  }

}
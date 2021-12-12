import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreAuthData {
  storeSignUpData(String name) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'name': name,
      'address': '',
      'phoneNum': '',
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png'
    }).whenComplete(() {
      print("Auth data is stored");
    });
  }
}

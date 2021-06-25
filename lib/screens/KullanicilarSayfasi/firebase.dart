import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FlutterFireAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  signOut() async {
    return await _firebaseAuth.signOut();
  }

  Future<User> signIn(String email, String sifre) async {
    var user = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: sifre,
    );
    return user.user;
  }

  Future<String> getCurrentUID() async {
    return await _firebaseAuth.currentUser.uid;
  }

  Future<User> signUp(
    String name,
    String phonenumber,
    String email,
    String sifre,
  ) async {
    var user = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: sifre,
    );

    await _firestore.collection("Users").doc(user.user.uid).set({
      'email': email,
      'name': name,
      'password': sifre,
      'phonenumber': phonenumber,
    });

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => BottomNavBar(),
    //   ),
    // );

    return user.user;
  }

  Future<void> updateUser(control1, control2) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(firebaseUser.uid)
        .update({'name': control1, "phonenumber": control2})
        .then((value) => print("Name Updated"))
        .catchError((error) => print("Failed to update name: $error"));
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore =FirebaseFirestore.instance;

  //sign in
  Future<UserCredential> signinwithemailandpassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(
            email: email,
            password: password);
            //add a new document for the user in users collection if it doesn't exist 
            _firestore.collection("users").doc(userCredential.user!.uid).set({
          "uid":userCredential.user!.uid,
          "email":email,
         },SetOptions(merge: true));

            return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
  //creating a new user
  Future<UserCredential> signupwithemailandpassword(String email,String password)async{
    try {
      UserCredential userCredential=await _firebaseAuth
      .createUserWithEmailAndPassword(
        email: email,
         password: password
         );

         //creating a document for the user in the users collection
         _firestore.collection('users').doc(userCredential.user!.uid).set({
          'uid':userCredential.user!.uid,
          'email':email,
          'username': email.split('@')[0],
            'bio':'Empty bio',
         });

         return userCredential;
    }on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
  //sign out
  Future<void> signOut()async{
    return await FirebaseAuth.instance.signOut();
  }

  signinwithgoogle()async{
    //begin interacting sign in process
    final GoogleSignInAccount? gUser=await GoogleSignIn().signIn();
    //ontain auth details from request
    final GoogleSignInAuthentication gAuth=await gUser!.authentication;
    //create new credential for user
    final credential =GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken
    );

    //sign in
    return await _firebaseAuth.signInWithCredential(credential);

  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:step_counter/data/models/person.dart';

class AuthService {
  FirebaseAuth fAuth;
  AuthService({
    required this.fAuth,
  });

  Future<Person?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await fAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return Person.fromFirebase(user!.uid);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Person?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await fAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return Person.fromFirebase(user!.uid);
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return null;
    }
  }

  Future<void> logOut() async {
    return await fAuth.signOut();
  }

  Stream<Person?> get currentUser {
    return fAuth
        .authStateChanges()
        .map((user) => user != null ? Person.fromFirebase(user.uid) : null);
  }
}

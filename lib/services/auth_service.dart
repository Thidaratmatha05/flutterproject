import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  User? _user;
  User? get user => _user;

  AuthService() {
    _user = FirebaseAuth.instance.currentUser;
  }

  Future<bool> register(String email, String password) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      return true;
    } on FirebaseAuthException catch (e) {
      print(e.code.toString());
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  Future<String?> login(
      {required String email, required String password}) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (user.user != null) return "Login Success";
    } on FirebaseAuthException catch (e) {
      print(e.code.toString());
      return e.message;
    }
    return "Can't Login";
  }

  Future<void> logout(User? currentUser) async {
    await FirebaseAuth.instance.signOut();
  }
}

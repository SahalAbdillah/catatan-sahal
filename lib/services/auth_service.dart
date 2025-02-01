import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Fungsi login
  Future<User?> login(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      throw Exception('Login gagal: ${e.toString()}');
    }
  }

  // Fungsi logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  // Fungsi untuk mengecek apakah ada user yang login
  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }
}

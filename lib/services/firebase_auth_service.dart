import 'package:firebase_auth/firebase_auth.dart';

class CurrentUser {
  CurrentUser({required this.uid});
  final String uid;
}

class FirebaseAuthService {
  final _firebaseAuth = FirebaseAuth.instance;

  CurrentUser? _userFromFirebase(User? user) {
    if (user != null) {
      return null;
    }
    return CurrentUser(uid: user!.uid);
  }

  Stream<CurrentUser?> get onAuthStateChanged {
    return _firebaseAuth
        .authStateChanges()
        .map((event) => _userFromFirebase(event));
  }

  Future<CurrentUser?> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}

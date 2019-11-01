import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseHelper {
  FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseReference _databaseRoot = FirebaseDatabase.instance.reference();
  FirebaseUser _firebaseUser;

  static FirebaseHelper instance = FirebaseHelper();

  Future<FirebaseUser> signInWithCredential(AuthCredential credential) async {
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> insertUserData(FirebaseUser user) {
    return _databaseRoot
        .child(FirebaseKeys.USERS)
        .child(user.uid)
        .child(FirebaseKeys.EMAIL)
        .set(user.email);
  }

  Future<String> insertNote(String text, {String noteId}) async {
    await _auth.currentUser().then((user) => {_firebaseUser = user});
    String pushKey = (noteId == null)
        ? _databaseRoot
            .child(FirebaseKeys.USERS)
            .child(_firebaseUser.uid)
            .child(FirebaseKeys.NOTES)
            .push()
            .key
        : noteId;
    await _databaseRoot
        .child(FirebaseKeys.USERS)
        .child(_firebaseUser.uid)
        .child(FirebaseKeys.NOTES)
        .child(pushKey)
        .set(text);
    return Future.value(pushKey);
  }

  Future<DataSnapshot> getAllNotes() {
    return _databaseRoot
        .child(FirebaseKeys.USERS)
        .child(_firebaseUser.uid)
        .child(FirebaseKeys.NOTES)
        .once();
  }
}

class FirebaseKeys {
  static String USERS = "users";
  static String EMAIL = "email";
  static String NOTES = "notes";
  static String TEXT = "text";
}

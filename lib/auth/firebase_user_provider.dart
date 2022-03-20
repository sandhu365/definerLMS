import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class DefinerLmsFirebaseUser {
  DefinerLmsFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

DefinerLmsFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<DefinerLmsFirebaseUser> definerLmsFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<DefinerLmsFirebaseUser>(
            (user) => currentUser = DefinerLmsFirebaseUser(user));

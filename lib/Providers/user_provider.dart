import 'package:flutter/foundation.dart';
import 'package:untitled/src/domain/users.dart';

class UserProvider with ChangeNotifier {
  User _user = new User(token: '', type: '', renewalToken: '', name: '', phone: '', email: '', userId: '');

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
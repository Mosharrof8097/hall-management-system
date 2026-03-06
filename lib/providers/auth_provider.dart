import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../core/services/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _user;
  final AuthRepository _repo = AuthRepository();

  UserModel? get user => _user;
  bool get isLoggedIn => _user != null;

  void setUser(UserModel u) {
    _user = u;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }

  Future<void> logout() async {
    await _repo.logout();
    clearUser();
  }
}

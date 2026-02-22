import 'package:get/get.dart';
import '../models/user_model.dart';

class AuthController extends GetxController {
  final user = Rxn<UserModel>();

  bool get isLoggedIn => user.value != null;

  void setUser(UserModel u) {
    user.value = u;
  }

  void clearUser() {
    user.value = null;
  }
}
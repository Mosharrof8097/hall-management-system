
import 'package:get/get.dart';
import 'package:hall_management/models/role_model.dart';
class LoginController extends GetxController{
  var selectRole =UserRole.student.obs;
  void changeRole(UserRole role){
    selectRole.value=role;
  }
  String get roleName => selectRole.value.name;
}


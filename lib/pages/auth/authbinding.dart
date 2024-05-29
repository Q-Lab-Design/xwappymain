import 'package:get/get.dart';
import 'package:xwappy/pages/auth/authcontroller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
  }
}

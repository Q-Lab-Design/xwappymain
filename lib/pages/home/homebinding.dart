import 'package:get/get.dart';
import 'package:xwappy/pages/home/homecontroller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}

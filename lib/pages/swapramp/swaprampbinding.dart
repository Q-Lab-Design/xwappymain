import 'package:get/get.dart';
import 'package:xwappy/pages/swapramp/swaprampcontroller.dart';

class SwaprampBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SwapRampController>(
      () => SwapRampController(),
    );
  }
}

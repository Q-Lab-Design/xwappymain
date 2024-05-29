import 'package:get/get.dart';
import 'package:xwappy/pages/records/recordscontroller.dart';

class RecordsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecordsController>(
      () => RecordsController(),
    );
  }
}

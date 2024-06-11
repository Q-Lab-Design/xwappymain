import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum PageState { home, fiattocrypto, cryptotofiat }

class HomeController extends GetxController {
  Rx<PageState> pageState = PageState.home.obs;

  final nairaValueConvert = Rxn<String>();
  final cryptoValueConvert = Rxn<String>();

  final RxBool refreshh = false.obs;

  final amountController = TextEditingController();
}

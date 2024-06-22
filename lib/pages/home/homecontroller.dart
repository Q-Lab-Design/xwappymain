import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:httpi/httpi.dart';

import '../../constants.dart';
import '../../httpinterceptor.dart';

enum PageState { home, swap, cards, sends, refer, fiattocrypto, cryptotofiat }

class HomeController extends GetxController {
  Rx<PageState> pageState = PageState.home.obs;

  final nairaValueConvert = Rxn<String>();
  final cryptoValueConvert = Rxn<String>();

  final RxBool refreshh = false.obs;

  final amountController = TextEditingController();

  Future<bool> getUserData() async {
    try {
      final response = await httpi.get(
        Uri.parse(
            "${Constants.baseUrl}/XwapyMobile/UserData?domain=${Constants.domain}&sub_domain=${Constants.subdomain}"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Constants.store.read("TOKEN")}",
        },
      );

      var resData = jsonDecode(response.body);

      Constants.logger.d(resData);

      if (response.statusCode != 200) {
        return false;
      } else {
        await Constants.store.write('USERDATA', resData['data']);

        return true;
      }
    } catch (error) {
      Constants.logger.d(error);

      return false;
    }
  }
}

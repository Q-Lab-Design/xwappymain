import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xwappy/constants.dart';
import 'package:xwappy/pages/records/model.dart';

enum PageState { initiated, pending, completed }

enum ReceiptState { crypto, fiat }

class RecordsController extends GetxController {
  Rx<PageState> pageState = PageState.pending.obs;
  Rx<ReceiptState> receiptState = ReceiptState.crypto.obs;

  RxBool initiatedLoading = false.obs;
  RxBool pendingLoading = false.obs;
  RxBool completeLoading = false.obs;

  RxBool isLoading = false.obs;

  RxString typeDropDownValue = 'Buy'.obs;

  Future<bool> transactionRecords({filtrType}) async {
    try {
      final response = await http.get(
        Uri.parse(
            "${Constants.baseUrl}/XwapyMobile/TransactionRecords?type=${typeDropDownValue.toLowerCase()}&filter_type=${filtrType ?? 'pending'}&domain=${Constants.getDomain()['domain']}&sub_domain=${Constants.getDomain()['subdomain']}"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Constants.store.read("TOKEN")}",
        },
      );

      // Constants.logger.d(response.request?.url);
      var resData = jsonDecode(response.body);

      print(response.request?.url);

      if (response.request?.url.queryParameters['filter_type'] == "pending") {
        pendingLoading.value = false;
      }

      if (kDebugMode) {
        print(resData);
      }
      if (response.statusCode != 200) {
        Fluttertoast.showToast(
            msg: resData['data']['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            // backgroundColor: Colors.red,
            // textColor: Colors.white,
            fontSize: 16.0);
        return false;
      } else {
        if (response.request?.url.queryParameters['filter_type'] == "pending") {
          pendingList.clear();
          for (var e in resData['data']) {
            pendingList.add(TransactionSummary.fromJson(e));
          }
          pendingList.refresh();
        } else if (response.request?.url.queryParameters['filter_type'] ==
            "completed") {
          completeList.clear();
          for (var e in resData['data']) {
            completeList.add(TransactionSummary.fromJson(e));
          }
          completeList.refresh();
        } else {
          initiatedList.clear();
          for (var e in resData['data']) {
            initiatedList.add(TransactionSummary.fromJson(e));
          }
          initiatedList.refresh();
        }
        return true;
      }
    } catch (error) {
      Constants.logger.d(error);

      return false;
    }
  }

  @override
  void onInit() {
    pendingLoading.value = true;
    transactionRecords();
    super.onInit();
  }
}

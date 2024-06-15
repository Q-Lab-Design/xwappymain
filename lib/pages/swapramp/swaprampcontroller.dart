import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xwappy/constants.dart';
import 'package:xwappy/pages/records/model.dart';

class SwapRampController extends GetxController {
  RxBool paid = false.obs;
  RxBool retry = false.obs;

  RxBool timerstarted = false.obs;

  RxBool confirmCryptoaddress = false.obs;
  RxBool termsandcondition = false.obs;

  RxBool isLoading = false.obs;

  TextEditingController addressController = TextEditingController();
  TextEditingController confirmAddressController = TextEditingController();

  TextEditingController accountNumber = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController confirmAccountNumber = TextEditingController();
  final provider = Rxn<String>();

  RxInt remainingSeconds = 30.obs; // 3 minutes 50 seconds 230
  Timer? timer;

  Map createFiatToCryptoOrderRes = {};
  Map buyCallbackRes = {};
  Map sellCallbackRes = {};
  Map sellConfRes = {};

  Map fiatToCryptoTxnReceipt = {};

  TransactionCrypto? transactionCryptoData;

  TransactionFiat? transactionFiatData;

  String orderno = '';

  TextEditingController inputCryptoAddress = TextEditingController();

  TextEditingController confirminputCryptoAddress = TextEditingController();

  RxList bnkList = [].obs;
  RxMap accountvertifydata = {}.obs;
  RxString amountError = "".obs;
  RxBool isLoadingmain = false.obs;

  void startTimer() {
    timerstarted.value = true;
    remainingSeconds.value = 30;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        if (paid.value == true) {
          timer.cancel();
        }
        remainingSeconds.value = remainingSeconds.value - 1;
      } else {
        retry.value = true;

        if (kDebugMode) {
          print('Countdown finished!');
          timer.cancel();
        }
      }
    });
  } //IhavePaidWithFiat

  Future<bool> getOtp({email}) async {
    var body = json.encode({
      "email": email,
      "domain": Constants.getDomain()['domain'],
      "sub_domain": Constants.getDomain()['subdomain']
    });

    Constants.logger.d(body);

    try {
      final response =
          await http.post(Uri.parse("${Constants.baseUrl}/XwapyMobile/GetOTP"),
              headers: {
                "Content-Type": "application/json",
              },
              body: body);

      var resData = jsonDecode(response.body);

      Constants.logger.d(resData);
      if (response.statusCode != 200) {
        Fluttertoast.showToast(
            msg: 'Failed to send OTP',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            // backgroundColor: Colors.red,
            // textColor: Colors.white,
            fontSize: 16.0);
        return false;
      } else {
        Fluttertoast.showToast(
            msg: resData['data']['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            // backgroundColor: Colors.red,
            // textColor: Colors.white,
            fontSize: 16.0);

        return true;
      }
    } catch (error) {
      Fluttertoast.showToast(
          msg: error.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          // backgroundColor: Colors.red,
          // textColor: Colors.white,
          fontSize: 16.0);
      Constants.logger.d(error);

      return false;
    }
  }

  Future<bool> createFiatToCryptoOrder(
      {from, to, address, network, amount}) async {
    var body = json.encode({
      "from_fiat": from ?? "NGN",
      "to_crypto": to ?? "USDT",
      "buyer_crypto_address": address, //"xxxx",
      "network": network == null || network == "null"
          ? "USDT-TRC20".toLowerCase()
          : network,
      "intrapay_merchant_id": Constants.store.read('USERDATA')['user']
          ['intrapay_merchant_id'],
      "markup_fee": Constants.store.read('USERDATA')['user']['markup_fee'],
      "amount": amount.toString().split(",").join(),
      "fiat_amount": amount.toString().split(",").join(),
      "domain": Constants.getDomain()['domain'],
      "sub_domain": Constants.getDomain()['subdomain']
    });

    Constants.logger.d(body);

    try {
      final response = await http.post(
          Uri.parse("${Constants.baseUrl}/XwapyMobile/CreateFiatToCryptoOrder"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Constants.store.read("TOKEN")}",
          },
          body: body);

      var resData = jsonDecode(response.body);

      Constants.logger.d(resData);
      if (response.statusCode != 200) {
        Fluttertoast.showToast(
            msg: resData['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            // backgroundColor: Colors.red,
            // textColor: Colors.white,
            fontSize: 16.0);
        return false;
      } else {
        createFiatToCryptoOrderRes = resData;
        orderno = Uri.parse(resData['data']['buy_callback_url'])
            .queryParameters['order_no']
            .toString();
        return await buyCallbackUrl(
            orderno: Uri.parse(resData['data']['buy_callback_url'])
                .queryParameters['order_no']);
      }
    } catch (error) {
      Constants.logger.d(error);

      return false;
    }
  }

  Future<bool> buyCallbackUrl({orderno}) async {
    try {
      final response = await http.get(
        Uri.parse(
            "${Constants.baseUrl}/XwapyMobile/BuyCallbackUrl?order_no=$orderno&domain=${Constants.getDomain()['domain']}&sub_domain=${Constants.getDomain()['subdomain']}"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Constants.store.read("TOKEN")}",
        },
      );

      // Constants.logger.d(response.request?.url);
      var resData = jsonDecode(response.body);

      Constants.logger.d(resData);
      if (response.statusCode != 200) {
        Fluttertoast.showToast(
            msg: resData['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            // backgroundColor: Colors.red,
            // textColor: Colors.white,
            fontSize: 16.0);
        return false;
      } else {
        buyCallbackRes = resData;

        if (resData['data']['payment_link'] != null) {
          Get.toNamed('/makepaymentmobilem', arguments: Get.arguments);
          return false;

          // Constants.llaunchUrl(resData['data']['payment_link']);
        }

        return true;
      }
    } catch (error) {
      Constants.logger.d(error);

      return false;
    }
  }

  Future<bool> createCryptoToFiatOrder(
      {from,
      to,
      address,
      network,
      amount,
      accountcode,
      accountnumber,
      accountname}) async {
    var body = json.encode({
      "from_cryto": from == null || from == "null" ? "USDT" : from,
      "to_fiat": to == null || to == "null" ? "NGN" : to,
      "network": network == null || network == "null"
          ? "USDT-TRC20".toLowerCase()
          : network,
      "intrapay_merchant_id": Constants.store.read('USERDATA')['user']
          ['intrapay_merchant_id'],
      "markup_fee": Constants.store.read('USERDATA')['user']['markup_fee'],
      "crypto_amount": amount.toString().split(",").join(),
      "domain": Constants.getDomain()['domain'],
      "sub_domain": Constants.getDomain()['subdomain'],
      "account_code": accountcode,
      "account_number": accountnumber,
      "account_name": accountname,
    });

    Constants.logger.d(body);

    try {
      final response = await http.post(
          Uri.parse("${Constants.baseUrl}/XwapyMobile/CreateCryptoToFiatOrder"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Constants.store.read("TOKEN")}",
          },
          body: body);

      var resData = jsonDecode(response.body);

      Constants.logger.d(resData);
      if (response.statusCode != 200) {
        Fluttertoast.showToast(
            msg: resData['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            // backgroundColor: Colors.red,
            // textColor: Colors.white,
            fontSize: 16.0);
        return false;
      } else {
        createFiatToCryptoOrderRes = resData;
        orderno = resData['data']['order_no'];
        return await sellCallbackUrl(orderno: resData['data']['order_no']);
      }
    } catch (error) {
      Constants.logger.d(error);

      return false;
    }
  }

  Future<bool> sellCallbackUrl({orderno}) async {
    try {
      final response = await http.get(
        Uri.parse(
            "${Constants.baseUrl}/XwapyMobile/SellCallbackUrl?order_no=$orderno&domain=${Constants.getDomain()['domain']}&sub_domain=${Constants.getDomain()['subdomain']}"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Constants.store.read("TOKEN")}",
        },
      );

      // Constants.logger.d(response.request?.url);
      var resData = jsonDecode(response.body);

      Constants.logger.d(resData);
      if (response.statusCode != 200) {
        Fluttertoast.showToast(
            msg: resData['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            // backgroundColor: Colors.red,
            // textColor: Colors.white,
            fontSize: 16.0);
        return false;
      } else {
        sellCallbackRes = resData;

        // if (resData['data']['payment_link'] != null) {
        //   Constants.llaunchUrl(resData['data']['payment_link']);
        // }

        return true;
      }
    } catch (error) {
      Constants.logger.d(error);

      return false;
    }
  }

  Future<bool> sellConfirmationCallbackUrl({ordern, arguments}) async {
    try {
      final response = await http.get(
        Uri.parse(
            "${Constants.baseUrl}/XwapyMobile/SellConfirmationCallbackUrl?order_no=${ordern ?? orderno}&domain=${Constants.getDomain()['domain']}&sub_domain=${Constants.getDomain()['subdomain']}"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Constants.store.read("TOKEN")}",
        },
      );

      // Constants.logger.d(response.request?.url);
      var resData = jsonDecode(response.body);

      Constants.logger.d(resData);
      if (response.statusCode != 200) {
        Fluttertoast.showToast(
            msg: resData['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            // backgroundColor: Colors.red,
            // textColor: Colors.white,
            fontSize: 16.0);
        return false;
      } else {
        sellConfRes = resData;

        if (resData['data']['confirmed'] == true) {
          paid.value = true;
          Get.toNamed('/enterbankdetails', arguments: arguments);
        } else {
          if (retry.value == false) {
            Timer.periodic(const Duration(seconds: 15), (timer) {
              timer.cancel();
              sellConfirmationCallbackUrl(ordern: orderno);
            });
          }
        }

        return true;
      }
    } catch (error) {
      Constants.logger.d(error);

      return false;
    }
  }

  Future<bool> fiatCreditedCallbackURL({ordern, arguments}) async {
    try {
      final response = await http.get(
        Uri.parse(
            "${Constants.baseUrl}/XwapyMobile/FiatCreditedCallbackURL?order_no=${ordern ?? orderno}&domain=${Constants.getDomain()['domain']}&sub_domain=${Constants.getDomain()['subdomain']}"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Constants.store.read("TOKEN")}",
        },
      );

      // Constants.logger.d(response.request?.url);
      var resData = jsonDecode(response.body);

      Constants.logger.d(resData);
      if (response.statusCode != 200) {
        Fluttertoast.showToast(
            msg: resData['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            // backgroundColor: Colors.red,
            // textColor: Colors.white,
            fontSize: 16.0);
        return false;
      } else {
        if (resData['data']['credited'] == true) {
          if (kDebugMode) {
            print('credited!!');
            paid.value = true;
            Get.toNamed('/enterbankdetails', arguments: arguments);
          }
          return await cryptoToFiatTxnReceipt();
        } else {
          if (retry.value == false) {
            Timer.periodic(const Duration(seconds: 15), (timer) {
              timer.cancel();
              fiatCreditedCallbackURL(ordern: orderno);
            });
          }
        }

        return false;
      }
    } catch (error) {
      Constants.logger.d(error);

      return false;
    }
  }

  Future<bool> ihavePaidForCrypto(
      {accountName,
      accountNumber,
      accountcodenetwork,
      ordernu,
      arguments}) async {
    var body = json.encode({
      "account_name": accountName,
      "account_number": accountNumber,
      "account_code_network": accountcodenetwork,
      "order_no": ordernu ?? orderno,
      "domain": Constants.getDomain()['domain'],
      "sub_domain": Constants.getDomain()['subdomain']
    });

    Constants.logger.d(body);

    try {
      final response = await http.post(
          Uri.parse(
              "${Constants.baseUrl}/XwapyMobile/IhavePaidForCrypto?domain=${Constants.getDomain()['domain']}&sub_domain=${Constants.getDomain()['subdomain']}"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Constants.store.read("TOKEN")}",
          },
          body: body);

      var resData = jsonDecode(response.body);

      Constants.logger.d(resData);
      if (response.statusCode != 200) {
        Fluttertoast.showToast(
            msg: resData['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            // backgroundColor: Colors.red,
            // textColor: Colors.white,
            fontSize: 16.0);
        return false;
      } else {
        return await fiatCreditedCallbackURL(
            arguments: arguments); //sellConfirmationCallbackUrl();
      }
    } catch (error) {
      Constants.logger.d(error);

      return false;
    }
  }

  //
  Future<bool> ihavePaidWithFiat({ordern}) async {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
    try {
      final response = await http.get(
        Uri.parse(
            "${Constants.baseUrl}/XwapyMobile/IhavePaidWithFiat?order_no=${ordern ?? orderno}&domain=${Constants.getDomain()['domain']}&sub_domain=${Constants.getDomain()['subdomain']}"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Constants.store.read("TOKEN")}",
        },
      );

      // Constants.logger.d(response.request?.url);
      var resData = jsonDecode(response.body);

      Constants.logger.d(resData);
      if (response.statusCode != 200) {
        Fluttertoast.showToast(
            msg: resData['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            // backgroundColor: Colors.red,
            // textColor: Colors.white,
            fontSize: 16.0);
        return false;
      } else {
        if (resData['data']['confirmed'] == true) {
          if (kDebugMode) {
            print('confirmed!!');
          }
          paid.value = true;
        } else {
          if (retry.value == false) {
            timer = Timer.periodic(const Duration(seconds: 15), (timer) {
              timer.cancel();
              ihavePaidWithFiat(ordern: orderno);
            });
          }
        }

        return true;
      }
    } catch (error) {
      Constants.logger.d(error);

      return false;
    }
  }

  Future<bool> fiatToCryptoTxReceipt({ordern}) async {
    try {
      final response = await http.get(
        Uri.parse(
            "${Constants.baseUrl}/XwapyMobile/FiatToCryptoTxnReceipt?order_no=${ordern ?? orderno}&domain=${Constants.getDomain()['domain']}&sub_domain=${Constants.getDomain()['subdomain']}"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Constants.store.read("TOKEN")}",
        },
      );

      // Constants.logger.d(response.request?.url);
      var resData = jsonDecode(response.body);

      if (kDebugMode) {
        print(resData);
      }
      if (response.statusCode != 200) {
        Fluttertoast.showToast(
            msg: resData['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            // backgroundColor: Colors.red,
            // textColor: Colors.white,
            fontSize: 16.0);
        return false;
      } else {
        fiatToCryptoTxnReceipt = resData;

        transactionCryptoData = TransactionCrypto.fromJson(resData['data']);
        return true;
      }
    } catch (error) {
      Constants.logger.d(error);

      return false;
    }
  } //CryptoToFiatTxnReceipt

  Future<bool> cryptoToFiatTxnReceipt({ordern}) async {
    try {
      final response = await http.get(
        Uri.parse(
            "${Constants.baseUrl}/XwapyMobile/CryptoToFiatTxnReceipt?order_no=${ordern ?? orderno}&domain=${Constants.getDomain()['domain']}&sub_domain=${Constants.getDomain()['subdomain']}"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Constants.store.read("TOKEN")}",
        },
      );

      // Constants.logger.d(response.request?.url);
      var resData = jsonDecode(response.body);

      if (kDebugMode) {
        print(resData);
      }
      if (response.statusCode != 200) {
        Fluttertoast.showToast(
            msg: resData['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            // backgroundColor: Colors.red,
            // textColor: Colors.white,
            fontSize: 16.0);
        return false;
      } else {
        // fiatToCryptoTxnReceipt = resData;

        transactionFiatData = TransactionFiat.fromJson(resData['data']);
        return true;
      }
    } catch (error) {
      Constants.logger.d(error);

      return false;
    }
  } //CryptoToFiatTxnReceipt

  Future<bool> getKycLimitIssue({ordern}) async {
    try {
      final response = await http.get(
        Uri.parse(
            "${Constants.baseUrl}/XwapyMobile/GetKycLimitIssue?order_no=${ordern ?? orderno}&domain=${Constants.getDomain()['domain']}&sub_domain=${Constants.getDomain()['subdomain']}"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Constants.store.read("TOKEN")}",
        },
      );

      // Constants.logger.d(response.request?.url);
      var resData = jsonDecode(response.body);

      if (kDebugMode) {
        print(resData);
      }
      if (response.statusCode != 200) {
        Fluttertoast.showToast(
            msg: resData['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            // backgroundColor: Colors.red,
            // textColor: Colors.white,
            fontSize: 16.0);
        return false;
      } else {
        return true;
      }
    } catch (error) {
      Constants.logger.d(error);

      return false;
    }
  }

  Future<bool> fetchBanks({currency}) async {
    // errorMessage.value = '';
    Constants.logger.d(Constants.store.read('TOKEN'));
    // return true;
    try {
      final response = await http.get(
        Uri.parse(
            "${Constants.baseUrl}/api/v1/PartnerP2P_API/AllBanks?user_id=${Constants.store.read('USERID')}&currency=ngn&domain=${Constants.getDomain()['domain']}&sub_domain=${Constants.getDomain()['subdomain']}"),
        headers: {
          "content-type": "application/json",
          "x-app": "true",
          "Accept": "application/json",
          "x-api-token": Constants.store.read('TOKEN')
        },
      );

      var resData = jsonDecode(response.body);
      // Constants.logger.d(resData);

      Constants.logger.d(response.statusCode);

      if (!resData.containsKey("success")) {
        // Get.dialog(ErrorDialogs(
        //   description: resData['message'],
        //   showclose: true,
        //   showloader: false,
        // ));
        Constants.logger.d(resData);

        return false;
      } else {
        bnkList.value = resData['data'];
        // Constants.logger.d(bnkList);
        isLoadingmain.value = false;
        return true;
      }
    } catch (error) {
      Constants.logger.d(error);
      return false;
    }
  }

  Future<bool> verifyAccount({code, acctnumber}) async {
    // errorMessage.value = '';

    Constants.logger.d('working');

    accountvertifydata.value['account_name'] = "Fetching....";

    accountvertifydata.refresh();

    try {
      final response = await http.get(
        Uri.parse(
            "https://app.nuban.com.ng/api/NUBAN-ORVEVVJK2117-XWAPY?acc_no=$acctnumber&bank_code=$code"),
        headers: {
          "content-type": "application/json",
          "Accept": "application/json",
        },
      );

      var resData = jsonDecode(response.body);

      // Constants.logger.d(response.request!.url);
      Constants.logger.d(resData);
      Constants.logger.d(resData.runtimeType);

      if (response.statusCode != 200) {
        accountvertifydata.value['account_name'] = "Unable to verify";
        accountvertifydata.refresh();
        return false;
      } else {
        accountvertifydata.value = resData.first;
        accountvertifydata.refresh();
        return true;
      }
    } catch (error) {
      Constants.logger.d(error);
      return false;
    }
  }

  Future<bool> cashoutRefferal({accountnumber, bankCode, otp}) async {
    var body = jsonEncode({
      "account_number": accountnumber,
      "account_code": bankCode,
      "otp_code": otpController.text,
    });
    try {
      final response = await http.post(
        Uri.parse(
            "${Constants.baseUrl}/XwapyMobile/CashoutReferrals?domain=${Constants.getDomain()['domain']}&sub_domain=${Constants.getDomain()['subdomain']}"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Constants.store.read("TOKEN")}",
        },
        body: body,
      );

      // Constants.logger.d(response.request?.url);
      var resData = jsonDecode(response.body);

      Constants.logger.d(resData);

      if (response.statusCode != 200) {
        Fluttertoast.showToast(
            msg: resData['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            // backgroundColor: Colors.red,
            // textColor: Colors.white,
            fontSize: 16.0);
        return false;
      } else {
        // Get.back();
        Fluttertoast.showToast(
            msg: resData['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            // backgroundColor: Colors.red,
            // textColor: Colors.white,
            fontSize: 16.0);

        return true;
      }
    } catch (error) {
      Constants.logger.d(error);

      return false;
    }
  }

  @override
  void dispose() {
    timerstarted.value = false;
    timer?.cancel();
    super.dispose();
  }
}

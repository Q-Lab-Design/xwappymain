import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:xwappy/constants.dart';
import 'package:xwappy/pages/records/model.dart';

import '../../httpinterceptor.dart';
import '../records/recordscontroller.dart';

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

  RxInt remainingSeconds = 230.obs; // 3 minutes 50 seconds 230
  RxInt speed = 0.obs;

  Timer? timer;

  Timer? speedTimer;

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

  RxnDouble buyRate = RxnDouble();
  RxnDouble sellRate = RxnDouble();

  startSppedTimer() {
    speedTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      speed.value = speed.value + 1;
    });
  }

  void startTimer() {
    startSppedTimer();
    timerstarted.value = true;
    remainingSeconds.value = 230;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        if (paid.value == true) {
          timer.cancel();
        }
        remainingSeconds.value = remainingSeconds.value - 1;
      } else {
        retry.value = true;

        if (kDebugMode) {
          Constants.logger.d('Countdown finished!');
          timer.cancel();
        }
      }
    });
  } //IhavePaidWithFiat

  Future<bool> getOtp({email}) async {
    var body = json.encode({
      "email": email,
      "domain": Constants.domain,
      "sub_domain": Constants.subdomain
    });

    Constants.logger.d(body);

    try {
      final response =
          await httpi.post(Uri.parse("${Constants.baseUrl}/XwapyMobile/GetOTP"),
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
      "domain": Constants.domain,
      "sub_domain": Constants.subdomain
    });

    Constants.logger.d(body);

    try {
      final response = await httpi.post(
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
            ordern: Uri.parse(resData['data']['buy_callback_url'])
                .queryParameters['order_no']);
      }
    } catch (error) {
      Constants.logger.d(error);

      return false;
    }
  }

  Future<bool> buyCallbackUrl({ordern}) async {
    try {
      final response = await httpi.get(
        Uri.parse(
            "${Constants.baseUrl}/XwapyMobile/BuyCallbackUrl?order_no=${ordern ?? orderno}&domain=${Constants.domain}&sub_domain=${Constants.subdomain}"),
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
      "domain": Constants.domain,
      "sub_domain": Constants.subdomain,
      "account_code": accountcode,
      "account_number": accountnumber,
      "account_name": accountname,
    });

    Constants.logger.d(body);

    try {
      final response = await httpi.post(
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
        return await sellCallbackUrl(ordern: resData['data']['order_no']);
      }
    } catch (error) {
      Constants.logger.d(error);

      return false;
    }
  }

  Future<bool> exchangeRateSell({asset, baseSell}) async {
    sellRate.value = null;
    var body = json.encode({
      "asset": asset != null ? asset.toString().split('-').first : "USDT",

      ///USDC/EUSD
      "base": baseSell ?? "NGN", //GHS/KHS
      "markup_fee": Constants.store.read('USERDATA')['user']['markup_fee'],
      "trade_type": "SELL"
    });

    Constants.logger.d(body);

    try {
      final response = await httpi.post(
          Uri.parse("${Constants.baseUrl}/XwapyMobile/ExchangeRate"),
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
        // Constants.logger.d(resData['data']['amount']);
        sellRate.value = double.tryParse(resData['data']['amount'].toString());
        return true;
      }
    } catch (error) {
      Constants.logger.d(error);

      return false;
    }
  }

  Future<bool> exchangeRateBuy({asset, baseBuy}) async {
    buyRate.value = null;
    var body = json.encode({
      "asset": asset ?? "NGN", // USDT/USDC/EUSD if trade_type is SELL
      "base": baseBuy != null
          ? baseBuy.toString().split('-').first
          : "USDT", // NGN/GHS/KHS if trade_type is SELL
      "markup_fee": Constants.store.read('USERDATA')['user']['markup_fee'],
      "trade_type": "BUY"
    });

    Constants.logger.d(body);

    try {
      final response = await httpi.post(
          Uri.parse("${Constants.baseUrl}/XwapyMobile/ExchangeRate"),
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
        // Constants.logger.d(resData['data']['amount']);
        buyRate.value = double.tryParse(resData['data']['amount'].toString());
        return true;
      }
    } catch (error) {
      Constants.logger.d(error);

      return false;
    }
  }

  Future<bool> sellCallbackUrl({ordern}) async {
    try {
      final response = await httpi.get(
        Uri.parse(
            "${Constants.baseUrl}/XwapyMobile/SellCallbackUrl?order_no=${ordern ?? orderno}&domain=${Constants.domain}&sub_domain=${Constants.subdomain}"),
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
      final response = await httpi.get(
        Uri.parse(
            "${Constants.baseUrl}/XwapyMobile/SellConfirmationCallbackUrl?order_no=${ordern ?? orderno}&domain=${Constants.domain}&sub_domain=${Constants.subdomain}"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Constants.store.read("TOKEN")}",
        },
      );

      Constants.logger.d(response.request?.url);
      var resData = jsonDecode(response.body);

      Constants.logger.d(resData);
      if (response.statusCode != 200) {
        // Fluttertoast.showToast(
        //     msg: resData['message'],
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 3,
        //     // backgroundColor: Colors.red,
        //     // textColor: Colors.white,
        //     fontSize: 16.0);

        if (retry.value == false) {
          Timer.periodic(const Duration(seconds: 15), (timer) {
            timer.cancel();
            sellConfirmationCallbackUrl(ordern: orderno);
          });
        }
        return false;
      } else {
        sellConfRes = resData;

        if (resData['data']['confirmed'] == true) {
          paid.value = true;
          if (speedTimer != null && speedTimer!.isActive) {
            speedTimer!.cancel();
          }
          Future.delayed(const Duration(seconds: 2), () async {
            await cryptoToFiatTxnReceipt().then((onValue) {
              if (onValue) {
                Get.put(RecordsController()).receiptState.value =
                    ReceiptState.crypto;
                return Get.toNamed('/receipt');
              }
            });
          });
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
      final response = await httpi.get(
        Uri.parse(
            "${Constants.baseUrl}/XwapyMobile/FiatCreditedCallbackURL?order_no=${ordern ?? orderno}&domain=${Constants.domain}&sub_domain=${Constants.subdomain}"),
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
            Constants.logger.d('credited!!');
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
      "domain": Constants.domain,
      "sub_domain": Constants.subdomain
    });

    Constants.logger.d(body);

    try {
      final response = await httpi.post(
          Uri.parse(
              "${Constants.baseUrl}/XwapyMobile/IhavePaidForCrypto?domain=${Constants.domain}&sub_domain=${Constants.subdomain}"),
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
      final response = await httpi.get(
        Uri.parse(
            "${Constants.baseUrl}/XwapyMobile/IhavePaidWithFiat?order_no=${ordern ?? orderno}&domain=${Constants.domain}&sub_domain=${Constants.subdomain}"),
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
            Constants.logger.d('confirmed!!');
          }
          if (speedTimer != null && speedTimer!.isActive) {
            speedTimer!.cancel();
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
      final response = await httpi.get(
        Uri.parse(
            "${Constants.baseUrl}/XwapyMobile/FiatToCryptoTxnReceipt?order_no=${ordern ?? orderno}&domain=${Constants.domain}&sub_domain=${Constants.subdomain}"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Constants.store.read("TOKEN")}",
        },
      );

      // Constants.logger.d(response.request?.url);
      var resData = jsonDecode(response.body);

      if (kDebugMode) {
        Constants.logger.d(resData);
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
      final response = await httpi.get(
        Uri.parse(
            "${Constants.baseUrl}/XwapyMobile/CryptoToFiatTxnReceipt?order_no=${ordern ?? orderno}&domain=${Constants.domain}&sub_domain=${Constants.subdomain}"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Constants.store.read("TOKEN")}",
        },
      );

      // Constants.logger.d(response.request?.url);
      var resData = jsonDecode(response.body);

      if (kDebugMode) {
        Constants.logger.d(resData);
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
      final response = await httpi.get(
        Uri.parse(
            "${Constants.baseUrl}/XwapyMobile/GetKycLimitIssue?order_no=${ordern ?? orderno}&domain=${Constants.domain}&sub_domain=${Constants.subdomain}"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Constants.store.read("TOKEN")}",
        },
      );

      // Constants.logger.d(response.request?.url);
      var resData = jsonDecode(response.body);

      if (kDebugMode) {
        Constants.logger.d(resData);
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
      final response = await httpi.get(
        Uri.parse(
            "${Constants.baseUrl}/api/v1/PartnerP2P_API/AllBanks?user_id=${Constants.store.read('USERID')}&currency=ngn&domain=${Constants.domain}&sub_domain=${Constants.subdomain}"),
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
      final response = await httpi.get(
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
        try {
          accountvertifydata.value = resData.first;
          accountvertifydata.refresh();
        } catch (e) {
          accountvertifydata.value['account_name'] = "Unable to verify";
          accountvertifydata.refresh();
        }

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
      final response = await httpi.post(
        Uri.parse(
            "${Constants.baseUrl}/XwapyMobile/CashoutReferrals?domain=${Constants.domain}&sub_domain=${Constants.subdomain}"),
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

// 1.⁠ ⁠Grab the full domain name
// 2.⁠ ⁠⁠Remove httpis:// , www from it.
// 3.⁠ ⁠⁠check if the domain name contains “xwapy.com”. (note the url can be sub.domain.com. irrespective check if the domain name contain a key word “xwapy.com”
// 4.⁠ ⁠⁠if doesn’t that means its a customer domain.
// 5.⁠ ⁠⁠Send the domain to the api to fetch xwapy sub-domain url
// 6.⁠ ⁠⁠store the sub domain to make subsequent calls.
// 7.⁠ ⁠⁠If domain contains xwapy.com then it means it’s xwapy domain, grab the sub domain to it and use it to make your usual call

//   POST {{base_url}}/api/v1/no-auth/XwapyMobile/GetSubDomain
// content-type: application/json

// {
//     "domain_name": "txnemail.pro"
// }
//!++++++++++++++++++++++++++++++++++++++++++++
// | Response 200 { success: true, message, data: {sub_domain} }
//++++++++++++++++++++++++++++++++++++++++++++

  @override
  void dispose() {
    timerstarted.value = false;
    timer?.cancel();
    super.dispose();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
  }
}

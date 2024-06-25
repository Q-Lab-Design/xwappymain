import 'dart:async';
import 'dart:convert';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart' as html;
import 'package:xwappy/constants.dart';
import 'package:xwappy/pages/swapramp/swaprampcontroller.dart';

import '../../httpinterceptor.dart';

enum PageStatee { getstarted, ourstat, currencies }

class AuthController extends GetxController {
  Rx<PageStatee> pageStatee = PageStatee.ourstat.obs;

  TextEditingController fistnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController referralController = TextEditingController();

  final Rx<CountryCode> selContry = CountryCode(dialCode: "+234").obs;

  RxString errorMessage = ''.obs;

  Map serverResponse = {};

  RxBool isLoading = false.obs;
  RxBool resendOTPLoading = false.obs;

  RxMap supportedAssets = {}.obs;
  RxMap stats = {}.obs;
  RxBool supportedAssetsLoading = false.obs;
  RxBool statsLoading = false.obs;

  RxInt otpTime = 45.obs;

  Timer? timer;
  final swapcontroller = Get.put(SwapRampController());

  Future<bool> getSupportedAssets() async {
    supportedAssetsLoading.value = true;
    try {
      final response = await httpi.get(
        Uri.parse(
            "${Constants.baseUrl}/XwapyMobile/SupportedAssets?domain=${Constants.domain}&sub_domain=${Constants.subdomain}"),
        headers: {
          // "accept": "application/json",
          "Content-Type": "application/json",
        },
      );
      supportedAssetsLoading.value = false;

      // Constants.logger.d(response.body);
      var resData = jsonDecode(response.body);

      Constants.logger.d(resData);
      if (response.statusCode != 200) {
        Fluttertoast.showToast(
            msg: "Failed to get currencies",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            // backgroundColor: Colors.red,
            // textColor: Colors.white,
            fontSize: 16.0);
        return false;
      } else {
        supportedAssets.value = resData['data'];
        await Constants.store.write('SupportedAssets', resData['data']);

        return true;
      }
    } catch (error) {
      Constants.logger.d(error);
      Fluttertoast.showToast(
          msg: "Failed to get currencies",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          // backgroundColor: Colors.red,
          // textColor: Colors.white,
          fontSize: 16.0);
      return false;
    }
  }

  Future<bool> getStats() async {
    statsLoading.value = true;
    try {
      final response = await httpi.get(
        Uri.parse(
            "${Constants.baseUrl}/XwapyMobile/OurStats?domain=${Constants.domain}&sub_domain=${Constants.subdomain}"),
        headers: {
          // "accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      statsLoading.value = false;

      var resData = jsonDecode(response.body);

      Constants.logger.d(resData);

      if (response.statusCode != 200) {
        Fluttertoast.showToast(
            msg: "Failed to get stats",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            // backgroundColor: Colors.red,
            // textColor: Colors.white,
            fontSize: 16.0);
        return false;
      } else {
        stats.value = resData['data'];
        await Constants.store.write('ourstats', resData['data']);

        return true;
      }
    } catch (error) {
      Fluttertoast.showToast(
          msg: "Failed to get stats",
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

  Future<bool> getOtp({email}) async {
    if (timer != null) {
      timer!.cancel();
    }
    otpTime.value = 45;
    Timer.periodic(const Duration(seconds: 1), (callback) {
      timer = callback;
      otpTime.value = otpTime.value - 1;
      if (otpTime.value <= 0) {
        callback.cancel();
      }
    });

    var body = json.encode({
      "email": email.toString().trim(),
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
            msg: resData['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
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

  Future<bool> getStarted({firstname, lastname, email, phone, otp}) async {
    var body = json.encode({
      "first_name": fistnameController.text.trim(),
      "last_name": lastnameController.text.trim(),
      "email": emailController.text.trim(),
      "phone": selContry.value.dialCode!.split('+').join() +
          phoneController.text.trim(),
      "otp": otpController.text.trim(),
      "username": usernameController.text.trim(),
      "referral_username":
          referralController.text.isEmpty ? null : referralController.text,
      "domain": Constants.domain,
      "sub_domain": Constants.subdomain,
    });

    try {
      final response = await httpi.post(
          Uri.parse("${Constants.baseUrl}/XwapyMobile/GetStarted"),
          headers: {
            "Content-Type": "application/json",
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
        // await Constants.store.write('LOGINDETAIL', resData['data']);

        await Constants.store.write('TOKEN', resData['data']['token']);
        return await getUserData();
      }
    } catch (error) {
      Constants.logger.d(error);

      return false;
    }
  }

  Future<bool> login({email}) async {
    var body = json.encode({
      "email": emailController.text.trim(),
      "phone": phoneController.text.trim(),
      "otp_code": otpController.text.trim(),
      "domain": Constants.domain,
      "sub_domain": Constants.subdomain
    });

    try {
      final response =
          await httpi.post(Uri.parse("${Constants.baseUrl}/XwapyMobile/Login"),
              headers: {
                "Content-Type": "application/json",
              },
              body: body);

      Constants.logger.d(response.body);
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
        await Constants.store.write('TOKEN', resData['data']['token']);
        return await getUserData();
      }
    } catch (error) {
      Constants.logger.d(error);

      return false;
    }
  }

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
        serverResponse = resData['data'];

        await Constants.store.write('USERDATA', resData['data']);

        if (Constants.store.read('SupportedAssets') == null) {
          return await getSupportedAssets();
        }

        return true;
      }
    } catch (error) {
      Constants.logger.d(error);

      return false;
    }
  }

  Future<bool> getDesign() async {
    try {
      final response = await httpi.get(
        Uri.parse(
            "${Constants.baseUrl}/XwapyAdmin/GetDataStore?key_name=${Constants.subdomain}_branding&type=reseller"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Constants.store.read("TOKEN")}",
        },
      );

      isgetDomainLogicCalled = true;
      isDesingSchemeCalled = true;

      // Constants.logger.d(response.request?.url);
      var resData = jsonDecode(response.body);

      Constants.logger.d(resData);
      Constants.logger.d(jsonDecode(resData['data']['meta_data']));
      if (response.statusCode != 200) {
        return false;
      } else {
        await Constants.store
            .write("ACCOUNTDESIGN", jsonDecode(resData['data']['meta_data']));
        return true;
      }
    } catch (error) {
      Constants.logger.d(error);

      return false;
    }
  }

  Future<bool> getSubDomain({domainname}) async {
    String url = html.window.location.href.toString();

    Uri uri = Uri.parse(url);

    var body = jsonEncode({"domain_name": uri.host});
    try {
      final response = await httpi.post(
        Uri.parse("${Constants.baseUrl}/XwapyMobile/GetSubDomain"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Constants.store.read("TOKEN")}",
        },
        body: body,
      );

      isgetDomainLogicCalled = true;

      // Constants.logger.d(response.request?.url);
      var resData = jsonDecode(response.body);

      Constants.logger.d(resData);
      if (response.statusCode != 200) {
        return false;
      } else {
        Constants.subdomain = resData['data']['sub_domain'];
        return true;
      }
    } catch (error) {
      Constants.logger.d(error);

      return false;
    }
  }

  @override
  void onInit() {
    getStats();
    referralController.text = Constants.getUsernameformUrl();
    if (referralController.text.isNotEmpty) {
      Constants.store.write('refferal', referralController.text);
    }

    if (Constants.store.read('refferal') != null) {
      referralController.text = Constants.store.read('refferal');
    }

    super.onInit();
  }
}

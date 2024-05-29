import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xwappy/constants.dart';

enum PageState { getstarted, ourstat, currencies }

class AuthController extends GetxController {
  Rx<PageState> pageState = PageState.getstarted.obs;

  TextEditingController fistnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  RxString errorMessage = ''.obs;

  Map serverResponse = {};

  RxBool isLoading = false.obs;
  RxBool resendOTPLoading = false.obs;

  RxMap supportedAssets = {}.obs;
  RxMap stats = {}.obs;
  RxBool supportedAssetsLoading = false.obs;
  RxBool statsLoading = false.obs;

  Future<bool> getSupportedAssets() async {
    supportedAssetsLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse("${Constants.baseUrl}/XwapyMobile/SupportedAssets"),
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
      final response = await http.get(
        Uri.parse("${Constants.baseUrl}/XwapyMobile/OurStats"),
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
    var body = json.encode({
      "email": email,
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

  Future<bool> getStarted({firstname, lastname, email, phone, otp}) async {
    var body = json.encode({
      "first_name": fistnameController.text,
      "last_name": lastnameController.text,
      "email": emailController.text,
      "phone": phoneController.text,
      "otp": otpController.text,
    });

    try {
      final response = await http.post(
          Uri.parse("${Constants.baseUrl}/XwapyMobile/GetStarted"),
          headers: {
            "Content-Type": "application/json",
          },
          body: body);

      var resData = jsonDecode(response.body);

      Constants.logger.d(resData);
      if (response.statusCode != 200) {
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
      "email": emailController.text,
      "phone": phoneController.text,
      "otp": otpController.text,
    });

    try {
      final response =
          await http.post(Uri.parse("${Constants.baseUrl}/XwapyMobile/Login"),
              headers: {
                "Content-Type": "application/json",
              },
              body: body);

      Constants.logger.d(response.body);
      var resData = jsonDecode(response.body);

      Constants.logger.d(resData);
      if (response.statusCode != 200) {
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
      final response = await http.get(
        Uri.parse("${Constants.baseUrl}/XwapyMobile/UserData"),
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
}

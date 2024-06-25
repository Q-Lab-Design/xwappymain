import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shimmer/shimmer.dart';
import 'package:universal_html/html.dart' as html;
import 'package:xwappy/banklist.dart';

bool isgetDomainLogicCalled = false;
bool isDesingSchemeCalled = false;

class Constants {
  static Logger logger = Logger();
  static String baseUrl =
      'https://staging-exchanger-api.fuspay.finance/api/v1/no-auth';
  static String stripeKey =
      'pk_test_51O05pmHKmfLerB61nPONa6Pr9rAlYDTklSjTGT64wzGTlzbVeZ5E1L5l4qO5u3Io37WHk00aD08Uz7FyI1PIZENG0066D1Q54L';
  static final store = GetStorage();

  static final oCcyy = NumberFormat("#,##0.00", "en_US"); //"#,##0.00"
  static String moneyFormat(dynamic money) {
    return oCcyy.format(money);
  }

  static String subdomain = "";
  static String domain = "";

  static StreamSubscription? sub;

  static String getImage({image}) {
    return "${Constants.baseUrl}user/getimage?imageName=$image";
  }

  static RxDouble usersLatitude = 0.0.obs;
  static RxDouble usersLongitude = 0.0.obs;

  static Future<void> llaunchUrl(url) async {
    try {
      html.window.open(url, 'newWindow');
      // js.context.callMethod('open', [url]);
    } catch (e) {
      logger.d(e.toString());
    }

    // if (!await launchUrl(Uri.parse(url))) {
    //   throw Exception('Could not launch $url');
    // }
  }

  static String capitalizeText({required String inputText}) {
    String capitalizedText = inputText.toLowerCase().split(' ').map((word) {
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
    return capitalizedText;
  }

  static Future<String> croptoDesired({required String imageFile}) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: const Color(0xFF6117B2),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: Get.context!,
        ),
      ],
    );
    return croppedFile!.path;
  }

  static shimmer(
      {required Widget child, Color? baseColor, Color? highlightColor}) {
    return SizedBox(
      child: Shimmer.fromColors(
        baseColor: baseColor ?? Colors.red,
        highlightColor: highlightColor ?? Colors.yellow,
        child: child,
      ),
    );
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Password is required';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    } else if (!RegExp(r'\d').hasMatch(value)) {
      return 'Password must contain at least one number';
    } else if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special symbol';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'@.').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static List<Map<String, dynamic>> getUniqueelementavailableTime(serverList) {
    // List<Map<String, dynamic>> listOfMaps = [
    //   {'id': 1, 'name': 'John'},
    //   {'id': 2, 'name': 'Alice'},
    //   {'id': 1, 'name': 'John'}, // Duplicate based on 'id' key
    //   {'id': 3, 'name': 'Bob'},
    // ];

    List<Map<String, dynamic>> uniqueList = [];

    Set<dynamic> seen = <dynamic>{};

    for (var map in serverList) {
      if (!seen.contains(map['start'])) {
        uniqueList.add(map);
        seen.add(map['start']);
      }
    }

    return uniqueList;
  }

  static var paystackkey = 'sk_test_2a86860ef312be9e1be1e5b59384f9b9c498266b';

  static Map<String, dynamic> sortByUsdStart(start) {
    final sortedData =
        Map<String, dynamic>.from(store.read('USERDATA')['rates']);

    // Use the `sorted` method from the collection library.
    sortedData.updateAll((key, value) => [key, value]); // This is a workaround

    // Create a new map to store filtered entries.
    final filteredData = <String, dynamic>{};

    // Loop through sorted entries and filter.
    for (var entry in sortedData.entries) {
      if (entry.key.startsWith(start)) {
        filteredData[entry.key] = entry.value;
      }
    }

    print(filteredData);

    return filteredData;
  }

  static Map<String, dynamic> sortByUsdEnd(end) {
    final sortedData =
        Map<String, dynamic>.from(store.read('USERDATA')['rates']);

    // Use the `sorted` method from the collection library.
    sortedData.updateAll((key, value) => [key, value]); // This is a workaround

    // Create a new map to store filtered entries.
    final filteredData = <String, dynamic>{};

    // Loop through sorted entries and filter.
    for (var entry in sortedData.entries) {
      if (entry.key.endsWith(end)) {
        filteredData[entry.key] = entry.value;
      }
    }

    print(filteredData);

    return filteredData;
  }

  static getDomain() {
    Uri uri = Uri.parse(html.window.location.href.toString());

    String host = uri.host;

    String subdomain = host.split('.').first.toString();

    String domain = host.split('.').last.toString();

    if (host.split('.').length > 1) {
      domain = host.split('.')[1];
    }

    Constants.logger.d(host.split('.'));

    return {
      "domain": domain,
      "subdomain": subdomain,
    };
  }

  static String getUrl() {
    // Uri uri = Uri.parse(html.window.location.orihgin.toString());

    // String host = uri.host;

    return html.window.location.href.toString();
  }

  static bnklist() {
    if (Get.arguments == null) {
      return BankList.nigeria;
    }
    return Get.arguments['to'].toString().toUpperCase() == "KHS"
        ? BankList.kenya
        : Get.arguments['to'].toString().toUpperCase() == "GHS"
            ? BankList.ghana
            : BankList.nigeria;
  }

  static getUsernameformUrl() {
    Uri uri = Uri.parse(html.window.location.href.toString());

    logger.d(uri.queryParameters['ref']);

    String? usernamegotten = uri.queryParameters['ref'];
    logger.d("Link gooten: $usernamegotten");
    return usernamegotten ?? '';
  }

  static restoreSetArgs() {
    if (Get.arguments != null) {
      Constants.store.write('getarguments', Get.arguments);
    } else {
      // Get.arguments = st
    }
  }

  static String replaceFirstChar(String text, String replacement) {
    if (text.isEmpty) {
      return text;
    }
    return replacement + text.substring(1);
  }

  static Color btnColor() {
    // if (subdomain == "zapit") {
    //   return const Color(0xffEAE322);
    // }
    return store.read("ACCOUNTDESIGN") == null
        ? const Color(0xffF1D643)
        : Color(int.tryParse(replaceFirstChar(
                store.read("ACCOUNTDESIGN")['button_color'].toString(),
                "0xff")) ??
            0xffEAE322);
  }

  static String splashLogo() {
    // if (subdomain == "zapit") {
    //   return 'assets/images/zapitlogo.png';
    // }
    return store.read("ACCOUNTDESIGN")['splash_screen'] ??
        "https://workspace-management.s3.amazonaws.com/iPhone"; //contactsupport.png
  }

  static String supportImge() {
    // if (subdomain == "zapit") {
    //   return 'assets/images/zapitsupport.png';
    // }
    return store.read("ACCOUNTDESIGN")['support_icon'] ??
        "https://workspace-management.s3.amazonaws.com/image";
  }

  static String appLogo() {
    // if (subdomain == "zapit") {
    //   return 'assets/images/zapitlogo.png';
    // }
    return store.read("ACCOUNTDESIGN")['app_logo'] ??
        'https://workspace-management.s3.amazonaws.com/logo.png'; //
  }

  static String appFavicon() {
    // if (subdomain == "zapit") {
    //   return 'assets/images/zapitlogo.png';
    // }
    return store.read("ACCOUNTDESIGN")['favicon'] ??
        'https://workspace-management.s3.amazonaws.com/logo.png'; //
  }

  static Color? bkgColor() {
    // if (subdomain == "zapit") {
    //   return const Color(0xff040F0B);
    // }
    return store.read("ACCOUNTDESIGN") == null
        ? Colors.black
        : Color(int.tryParse(replaceFirstChar(
                store.read("ACCOUNTDESIGN")['background_color'].toString(),
                "0xff")) ??
            0xff040F0B);
  }

  static Color? txtColor() {
    // if (subdomain == "zapit") {
    //   return const Color(0xffffffff);
    // }
    return store.read("ACCOUNTDESIGN") == null
        ? Colors.white
        : Color(int.tryParse(replaceFirstChar(
                store.read("ACCOUNTDESIGN")['text_color'].toString(),
                "0xff")) ??
            0xffffffff);
  }

  static Color? headerColor() {
    // if (subdomain == "zapit") {
    //   return const Color(0xffF5F5F5);
    // }
    return store.read("ACCOUNTDESIGN") == null
        ? Colors.white
        : Color(int.tryParse(replaceFirstChar(
                store.read("ACCOUNTDESIGN")['header_color'].toString(),
                "0xff")) ??
            0xffF5F5F5);
  }

  static Color? activeHeaderColor() {
    // if (subdomain == "zapit") {
    //   return const Color(0xffEAE322);
    // }
    return store.read("ACCOUNTDESIGN") == null
        ? const Color(0xffF1D643)
        : Color(int.tryParse(replaceFirstChar(
                store.read("ACCOUNTDESIGN")['header_active_color'].toString(),
                "0xff")) ??
            0xffEAE322);
  }

  static Color? btnTxtColor() {
    // if (subdomain == "zapit") {
    //   return const Color(0xff1C2926);
    // }
    return store.read("ACCOUNTDESIGN") == null
        ? Colors.black
        : Color(int.tryParse(replaceFirstChar(
                store.read("ACCOUNTDESIGN")['button_text_color'].toString(),
                "0xff")) ??
            0xff1C2926);
  }

  static Color? boxColor1() {
    // if (subdomain == "zapit") {
    //   return const Color(0xff040F0B);
    // }
    return store.read("ACCOUNTDESIGN") == null
        ? Colors.black
        : Color(int.tryParse(replaceFirstChar(
                store.read("ACCOUNTDESIGN")['box_color'].toString(), "0xff")) ??
            0xff040F0B);
  }

  static Color? boxColor2() {
    // if (subdomain == "zapit") {
    //   return const Color(0xffC8D34A);
    // }
    return store.read("ACCOUNTDESIGN") == null
        ? const Color(0xffffffff)
        : Color(int.tryParse(replaceFirstChar(
                store.read("ACCOUNTDESIGN")['box_bg_color'].toString(),
                "0xff")) ??
            0xffC8D34A);
  }
}

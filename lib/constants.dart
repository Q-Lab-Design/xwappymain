import 'dart:async';
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class Constants {
  static Logger logger = Logger();
  static String baseUrl =
      'https://staging-exchanger-api.fuspay.finance/api/v1/no-auth';
  static String stripeKey =
      'pk_test_51O05pmHKmfLerB61nPONa6Pr9rAlYDTklSjTGT64wzGTlzbVeZ5E1L5l4qO5u3Io37WHk00aD08Uz7FyI1PIZENG0066D1Q54L';
  static final store = GetStorage();

  static final oCcyy = NumberFormat("#,##0.0", "en_US"); //"#,##0.00"
  static String moneyFormat(dynamic money) {
    return oCcyy.format(money);
  }

  static StreamSubscription? sub;

  //https://fade-api-1675dad1197c.herokuapp.com/api/v1/user/getimage?imageName=images/9fd589fa-6ac4-42d6-9f7d-93793f91ce2ddownload.jpg

  static String getImage({image}) {
    return "${Constants.baseUrl}user/getimage?imageName=$image";
  }

  static RxDouble usersLatitude = 0.0.obs;
  static RxDouble usersLongitude = 0.0.obs;

  static Future<void> llaunchUrl(url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
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
    Uri uri = Uri.parse(html.window.location.origin);

    String host = uri.host;

    String subdomain = host.split('.').first.toString();

    String domain = host.split('.').last.toString();

    return {
      "domain": domain,
      "subdomain": subdomain,
    };
  }
}

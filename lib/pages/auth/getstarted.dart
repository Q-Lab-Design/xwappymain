import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:xwappy/constants.dart';
import 'package:xwappy/widgets/button.dart';

import '../../widgets/inputfield.dart';
import 'authcontroller.dart';

class GetStarted extends GetView<AuthController> {
  GetStarted({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AuthController());
    return Scaffold(
      backgroundColor: Constants.bkgColor(),
      body: SafeArea(
        top: true,
        bottom: false,
        left: false,
        right: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Image.asset(Constants.appLogo()),
                      const Spacer(),
                      Button(
                        height: 40,
                        buttonWidth: 98,
                        buttonText: "Login",
                        onTap: () {
                          return Get.toNamed('/login');
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),

                  Text(
                    "Get started",
                    style: TextStyle(
                      color: Constants.txtColor(),
                      fontWeight: FontWeight.w700,
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Username",
                    style: TextStyle(
                      color: Constants.txtColor(),
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextInputField(
                    hintText: "e.g John122",
                    controller: controller.usernameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "First name",
                    style: TextStyle(
                      color: Constants.txtColor(),
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextInputField(
                    hintText: "e.g John",
                    controller: controller.fistnameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your First name';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Last name",
                    style: TextStyle(
                      color: Constants.txtColor(),
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextInputField(
                    hintText: "e.g Doe",
                    controller: controller.lastnameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Last name';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Enter Email",
                    style: TextStyle(
                      color: Constants.txtColor(),
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextInputField(
                    hintText: "Example@gmail.com",
                    controller: controller.emailController,
                    validator: Constants.validateEmail,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Enter Phone",
                    style: TextStyle(
                      color: Constants.txtColor(),
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  TextInputField(
                    prefixIcon: SizedBox(
                      width: 135,
                      child: CountryCodePicker(
                        alignLeft: true,
                        countryList: const [
                          {
                            "name": "Nigeria",
                            "code": "NG",
                            'dial_code': "+234",
                          },
                          {
                            "name": "Ghana",
                            "code": "GH",
                            'dial_code': "+233",
                          },
                          {
                            "name": "Kenya",
                            "code": "KE",
                            'dial_code': "+254",
                          }
                        ],
                        textStyle: TextStyle(color: Constants.txtColor()),
                        initialSelection: 'NG',
                        onChanged: (v) {
                          controller.selContry.value = v;
                        },
                      ),
                    ),
                    hintText: "7045353334",
                    keyboardType: TextInputType.phone,
                    controller: controller.phoneController,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'[+]')),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // const Text(
                  //   "Refferal",
                  //   style: TextStyle(
                  //     color: Color(0xffffffff),
                  //     fontWeight: FontWeight.w500,
                  //     fontSize: 15,
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // TextInputField(
                  //   hintText: "No Refferal",
                  //   readonly: true,
                  //   controller: controller.referralController,
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Obx(
                    () => Button(
                      buttonWidth: MediaQuery.sizeOf(context).width,
                      buttonText: "Continue",
                      isLoading: controller.isLoading.value,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          controller.isLoading.value = true;
                          controller
                              .getOtp(email: controller.emailController.text)
                              .then((value) {
                            controller.isLoading.value = false;
                            if (value) {
                              return Get.toNamed('/otp',
                                  arguments: "getstarted");
                            }
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xwappy/pages/auth/authcontroller.dart';
import 'package:xwappy/widgets/button.dart';
import 'package:xwappy/widgets/inputfield.dart';

class OtpScreen extends GetView<AuthController> {
  OtpScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000000),
      body: SafeArea(
          top: true,
          bottom: false,
          left: false,
          right: true,
          child: Form(
            key: formKey,
            child: Obx(
              () => BlurryModalProgressHUD(
                inAsyncCall: controller.resendOTPLoading.value,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/Group 2608876.png'),
                          const Spacer(),
                          const Text(
                            "Contact\nSupport",
                            style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontWeight: FontWeight.w500,
                              fontSize: 14.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Spacer(),
                      const Text(
                        "Enter OTP",
                        style: TextStyle(
                          color: Color(0xffC5C5C5),
                          fontWeight: FontWeight.w700,
                          fontSize: 28,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Check your email for OTP",
                        style: TextStyle(
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      const Text(
                        "Enter OTP",
                        style: TextStyle(
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextInputField(
                        hintText: "e.g 012345",
                        keyboardType: TextInputType.number,
                        controller: controller.otpController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter otp';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ), //controller.resendOTPLoading.value
                      Row(
                        children: [
                          RichText(
                              text: TextSpan(
                                  text: "Didn’t get OTP? ",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                  children: [
                                if (controller.otpTime.value == 0)
                                  TextSpan(
                                    text: "Resend",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        controller.resendOTPLoading.value =
                                            true;
                                        controller
                                            .getOtp(
                                                email: controller
                                                    .emailController.text)
                                            .then((value) {
                                          controller.resendOTPLoading.value =
                                              false;

                                          return null;
                                        });
                                      },
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                              ])),
                          const Spacer(),
                          if (controller.otpTime.value != 0)
                            Text(
                              "${controller.otpTime.value}s",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                        ],
                      ),

                      const SizedBox(
                        height: 50,
                      ),
                      const Spacer(),
                      Button(
                        buttonWidth: MediaQuery.sizeOf(context).width,
                        buttonText: "Continue",
                        isLoading: controller.isLoading.value,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            controller.isLoading.value = true;

                            if (Get.arguments.toString() == "getstarted") {
                              controller.getStarted().then((value) {
                                controller.isLoading.value = false;
                                if (value) {
                                  return Get.toNamed('/home');
                                }
                                return null;
                              });
                            } else {
                              controller.login().then((value) {
                                controller.isLoading.value = false;
                                if (value) {
                                  return Get.toNamed('/home');
                                }
                                return null;
                              });
                              // return Get.toNamed('/home');
                            }
                          }
                        },
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}

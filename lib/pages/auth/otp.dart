import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:xwappy/constants.dart';
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
                          Image.network(Constants.appLogo(),
                              width: 92,
                      height: 41,
                      fit: BoxFit.fill,),
                          const Spacer(),
                          Text(
                            "Contact\nSupport",
                            style: TextStyle(
                              color: Constants.txtColor(),
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
                      Text(
                        "Enter OTP",
                        style: TextStyle(
                          color: Constants.txtColor(),
                          fontWeight: FontWeight.w700,
                          fontSize: 28,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Check your email ${controller.emailController.text} for OTP",
                        style: TextStyle(
                          color: Constants.txtColor(),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Text(
                        "Enter OTP",
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
                        hintText: "e.g 012345",
                        keyboardType: TextInputType.number,
                        controller: controller.otpController,
                        suffixIcon: GestureDetector(
                          onTap: () async {
                            ClipboardData? clipBoardData =
                                await Clipboard.getData(Clipboard.kTextPlain);

                            if (clipBoardData != null) {
                              controller.otpController.text =
                                  clipBoardData.text.toString();

                              Fluttertoast.showToast(
                                  msg: "Pasted!!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 3,
                                  fontSize: 16.0);
                            }
                          },
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Center(
                              child: Text(
                                "Paste  ",
                                style: TextStyle(
                                  color: Constants.txtColor(),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
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
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Constants.txtColor(),
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
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Constants.txtColor(),
                                    ),
                                  ),
                              ])),
                          const Spacer(),
                          if (controller.otpTime.value != 0)
                            Text(
                              "${controller.otpTime.value}s",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Constants.txtColor(),
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

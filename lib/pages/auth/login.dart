import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xwappy/constants.dart';
import 'package:xwappy/pages/auth/authcontroller.dart';
import 'package:xwappy/widgets/button.dart';
import 'package:xwappy/widgets/inputfield.dart';

class LoginScreen extends GetView<AuthController> {
  LoginScreen({super.key});

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
              () => Padding(
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
                        Image.network(
                          Constants.appLogo(),
                          width: 92,
                          height: 41,
                          fit: BoxFit.fill,
                        ),
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
                      "Welcome\nback!",
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
                          controller
                              .getOtp(email: controller.emailController.text)
                              .then((value) {
                            controller.isLoading.value = false;
                            if (value) {
                              return Get.toNamed(
                                '/otp',
                              );
                            }
                          });
                        }
                      },
                    ),
                    const Spacer(),
                    Center(
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: "Don’t have account? ",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Constants.txtColor(),
                              ),
                              children: [
                                TextSpan(
                                  text: "Register",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.offAllNamed('/getstarted');
                                    },
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Constants.txtColor(),
                                  ),
                                )
                              ])),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

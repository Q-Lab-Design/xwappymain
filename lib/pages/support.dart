import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xwappy/constants.dart';
import 'package:xwappy/widgets/button.dart';

class Support extends StatelessWidget {
  const Support({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000000),
      body: SafeArea(
          top: true,
          bottom: false,
          left: false,
          right: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () => Get.offAllNamed('/home'),
                      child: const Icon(
                        Icons.close,
                        color: Color(0xffFCF9F9),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      Text(
                        "Contact\nSupport", //$10,023.43
                        style: TextStyle(
                          color: Color(0xffC5C5C5),
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Image.asset(Constants.supportImge()),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Need help with your transactions, KYC?\nContact our 247 Customer Support Team.",
                    style: TextStyle(
                      color: Color(0xffD8D8D8),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Button(
                    buttonText: "Live Chat",
                    radius: 16,
                    buttonWidth: 210,
                    onTap: () {
                      Constants.llaunchUrl('https://t.me/+Jp_QvZX5z4c5Yjk0');
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    "Note: Live Chat will take you to our Telegram Support Channel.",
                    style: TextStyle(
                      color: Color(0xffD8D8D8),
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

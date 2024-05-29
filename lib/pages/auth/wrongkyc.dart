import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xwappy/widgets/button.dart';

class WrongKyc extends GetView {
  const WrongKyc({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: SafeArea(
          top: true,
          bottom: false,
          left: false,
          right: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: GestureDetector(
                    onTap: () => Get.offAllNamed('/home'),
                    child: const Icon(
                      Icons.close,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Image.asset(
                'assets/images/kyc.png',
                width: MediaQuery.sizeOf(context).width,
                fit: BoxFit.fitWidth,
              ),
              const Text(
                "KYC\nRequired!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff312B2B),
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 35,
              ),

              RichText(
                  text: const TextSpan(
                      text: 'Take 3 min to complete a ',
                      style: TextStyle(
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        height: 1.6,
                      ),
                      children: [
                    TextSpan(
                      text: 'one-time\nKYC ',
                      style: TextStyle(
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    TextSpan(
                      text: 'to complete your transaction.',
                      style: TextStyle(
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    )
                  ])),
              // const Text(
              //   "The KYC of this of this email is attached to a separate phone number. If you have access to the phone number, kindly enter the phone and continue your transaction.",
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     color: Color(0xff000000),
              //     fontWeight: FontWeight.w500,
              //     fontSize: 12,
              //   ),
              // ),
              const Spacer(),
              Button(
                buttonWidth: 300,
                buttonText: "Start KYC",
                onTap: () => Get.offAllNamed('/'),
              ),
              const Spacer(),
            ],
          )),
    );
  }
}

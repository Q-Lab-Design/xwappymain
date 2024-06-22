import 'package:clipboard/clipboard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:xwappy/constants.dart';
import 'package:xwappy/pages/records/recordscontroller.dart';
import 'package:xwappy/pages/swapramp/swaprampcontroller.dart';
import 'package:xwappy/widgets/button.dart';

class MakePaymentMobileM extends GetView<SwapRampController> {
  const MakePaymentMobileM({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000000),
      body: SafeArea(
          top: true,
          left: false,
          right: false,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Obx(
              () {
                controller.remainingSeconds;
                controller.speed.value;
                final minutes = (controller.remainingSeconds ~/ 60)
                    .toString()
                    .padLeft(2, '0');
                final seconds = (controller.remainingSeconds % 60)
                    .toString()
                    .padLeft(2, '0');
                final speedminute =
                    (controller.speed ~/ 60).toString().padLeft(2, '0');
                final speedseconds =
                    (controller.speed % 60).toString().padLeft(2, '0');
                return Column(children: [
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
                  Row(
                    children: [
                      Container(
                        height: 51,
                        width: 51,
                        decoration: const BoxDecoration(
                          color: Color(0xffF1D643),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            "02",
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        "Make\nPayment", //$10,023.43
                        style: TextStyle(
                          color: Color(0xffC5C5C5),
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        (Get.arguments['from'] ?? "NGN") +
                            Get.arguments['amount'].toString(),
                        style: const TextStyle(
                          color: Color(0xffC5C5C5),
                          fontWeight: FontWeight.w700,
                          fontSize: 28,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          FlutterClipboard.copy(Get.arguments['amount']
                                  .toString()
                                  .split(',')
                                  .join())
                              .then((value) {
                            if (kDebugMode) {
                              print('copied');
                            }
                          });
                          Fluttertoast.showToast(
                              msg: "Copied!!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 3,
                              // backgroundColor: Colors.red,
                              // textColor: Colors.white,
                              fontSize: 16.0);
                        },
                        child: const Icon(
                          Octicons.copy,
                          color: Color(0xffC5C5C5),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Stack(
                    alignment: AlignmentDirectional.center,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 171,
                        padding: const EdgeInsets.only(
                            top: 25, bottom: 30, left: 20, right: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Continue to Payment", //
                                style: TextStyle(
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "You will be redirected to a payment page to use your Mobile money to make payment.", //
                                style: TextStyle(
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (controller.paid.value == false)
                        Positioned(
                          bottom: -40,
                          width: MediaQuery.sizeOf(context).width - 100,
                          child: Container(
                            // height: 71,
                            padding: const EdgeInsets.only(
                                top: 15, bottom: 15, left: 15, right: 15),
                            decoration: BoxDecoration(
                              color: const Color(0xff9F0303),
                              borderRadius: BorderRadius.circular(17),
                            ),
                            child: const Text(
                              '3rd Party Payment is not allowed. Bank name must match with your registered name.',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xffffffff)),
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(
                    height: 50,
                  ),
                  if (controller.timerstarted.value)
                    Container(
                      height: controller.paid.value == true
                          ? 140
                          : controller.retry.value &&
                                  controller.paid.value == false
                              ? 180
                              : 100,
                      width: MediaQuery.sizeOf(context).width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(17)),
                      child: Column(
                        children: [
                          controller.retry.value &&
                                  controller.paid.value == false
                              ? const Text(
                                  "Unable to Verify Payment", //
                                  style: TextStyle(
                                    color: Color(0xffF10910),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                )
                              : const Text(
                                  "We are checking your payment", //
                                  style: TextStyle(
                                    color: Color(0xff827E7E),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                  ),
                                ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Pay",
                                style: TextStyle(
                                  color: Color(0xff5D5757),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                "Speed: $speedminute:${speedseconds}s",
                                style: const TextStyle(
                                  color: Color(0xff5D5757),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                "Confirmation", //
                                style: TextStyle(
                                  color: Color(0xff5D5757),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            alignment: AlignmentDirectional.centerEnd,
                            children: [
                              LinearProgressIndicator(
                                borderRadius: BorderRadius.circular(5),
                                value: controller.paid.value == true ? 1 : null,
                                minHeight: 3,
                                color: const Color(0xff0785FA),
                                backgroundColor: const Color(0xff68B326),
                              ),
                              controller.paid.value == true
                                  ? Container(
                                      height: 40,
                                      width: 40,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  'assets/images/done.gif'))),
                                    )
                                  : Container(
                                      height: 37,
                                      width: 37,
                                      decoration: BoxDecoration(
                                        color: controller.paid.value == true
                                            ? const Color(0xff0785FA)
                                            : controller.retry.value
                                                ? const Color(0xffF10910)
                                                : const Color(0xff68B326),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                          child: Text(
                                        '$minutes:$seconds',
                                        style: const TextStyle(
                                          color: Color(0xffF8F7F4),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                        ),
                                      )),
                                    ),
                              Positioned(
                                left: 0,
                                child: Container(
                                  height: 15,
                                  width: 15,
                                  decoration: const BoxDecoration(
                                    color: Color(0xff0785FA),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          controller.retry.value &&
                                  controller.paid.value == false
                              ? const SizedBox(
                                  height: 10,
                                )
                              : const SizedBox(),
                          controller.retry.value &&
                                  controller.paid.value == false
                              ? const Text(
                                  "Unable to Confirm your payment, click retry to check if your payment has been received",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xffFA3307),
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              : const SizedBox(),
                          controller.paid.value == true
                              ? Text(
                                  "We have Confirmed your transfer of ${(Get.arguments['from'] ?? "NGN") + Get.arguments['amount'].toString()}. You can now proceed ",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11,
                                  ),
                                )
                              : const SizedBox(),
                          controller.retry.value &&
                                  controller.paid.value == false
                              ? const SizedBox(
                                  height: 10,
                                )
                              : const SizedBox(),
                          controller.retry.value &&
                                  controller.paid.value == false
                              ? RichText(
                                  text: TextSpan(
                                      text: 'Payment Issue? ',
                                      style: const TextStyle(
                                        color: Color(0xff5D5757),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'Contact Support',
                                          style: const TextStyle(
                                            color: Color(0xff5D5757),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 11,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () => Constants.llaunchUrl(
                                                'https://t.me/+Jp_QvZX5z4c5Yjk0'),
                                        )
                                      ]),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  controller.paid.value == true
                      ? Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed('/records');
                            },
                            child: const Text(
                              'Continue transaction later.',
                              style: TextStyle(
                                color: Color(0xffD8D8D8),
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 20,
                  ),
                  if (controller.paid.value == true)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Button(
                          buttonWidth: MediaQuery.sizeOf(context).width / 3,
                          buttonText: "I’ve Paid ",
                          color: const Color(0xffC4D0F0).withOpacity(0.22),
                          textColor: const Color(0xffffffff).withOpacity(0.24),
                          onTap: () {
                            // controller.startTimer();
                            if (controller.retry.value == false) {
                              controller.retry.value = false;
                            }
                          },
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Obx(
                          () => Button(
                            buttonWidth: MediaQuery.sizeOf(context).width / 3,
                            buttonText: "Continue",
                            isLoading: controller.isLoading.value,
                            onTap: () {
                              controller.isLoading.value = true;
                              controller
                                  .fiatToCryptoTxReceipt()
                                  .then((onValue) {
                                controller.isLoading.value = false;

                                if (onValue) {
                                  Get.put(RecordsController())
                                      .receiptState
                                      .value = ReceiptState.crypto;
                                  return Get.toNamed('/receipt');
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    )
                  else
                    Button(
                      buttonWidth: MediaQuery.sizeOf(context).width,
                      buttonText:
                          controller.retry.value ? "Retry" : "Initiate Payment",
                      color: controller.retry.value == true
                          ? const Color(0xffF1D643)
                          : controller.timerstarted.value
                              ? const Color(0xffC4D0F0).withOpacity(0.22)
                              : const Color(0xffF1D643),
                      onTap: () {
                        if (controller.retry.value == true) {
                          controller.ihavePaidWithFiat().then((onValue) {});
                          controller.retry.value = false;
                          controller.paid.value = false;
                          controller.startTimer();
                        } else {
                          if (controller.timerstarted.value == false) {
                            Constants.llaunchUrl(Constants.llaunchUrl(controller
                                .buyCallbackRes['data']['payment_link']));

                            controller.ihavePaidWithFiat().then((onValue) {});

                            controller.startTimer();
                          }
                        }
                      },
                    ),
                  const SizedBox(
                    height: 30,
                  ),
                  // Button(
                  //   buttonText: "Initiate Payment",
                  //   buttonWidth: MediaQuery.sizeOf(context).width,
                  //   onTap: () {
                  //     Constants.llaunchUrl(Constants.llaunchUrl(
                  //         controller.buyCallbackRes['data']['payment_link']));
                  //   },
                  // )
                ]);
              },
            ),
          )),
    );
  }
}

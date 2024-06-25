import 'package:clipboard/clipboard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:xwappy/constants.dart';
import 'package:xwappy/pages/swapramp/swaprampcontroller.dart';
import 'package:xwappy/widgets/button.dart';

import '../records/recordscontroller.dart';

class MakePaymentFiat extends GetView<SwapRampController> {
  const MakePaymentFiat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.bkgColor(),
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
                return SingleChildScrollView(
                  child: Column(children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () => Get.offAllNamed('/home'),
                        child: Icon(
                          Icons.close,
                          color: Constants.txtColor(),
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
                          decoration: BoxDecoration(
                            color: Constants.btnColor(),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              "02",
                              style: TextStyle(
                                color: Constants.bkgColor(),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Make\nPayment", //$10,023.43
                          style: TextStyle(
                            color: Constants.txtColor(),
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
                          style: TextStyle(
                            color: Constants.txtColor(),
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
                          child: Icon(
                            Octicons.copy,
                            size: 15,
                            color: Constants.txtColor(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Stack(
                      alignment: AlignmentDirectional.center,
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: controller.paid.value == true ? 300 : 400,
                          width: MediaQuery.sizeOf(context).width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Pay in the Account below", //
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              RichText(
                                  text: const TextSpan(
                                      text:
                                          'Copy & transfer money into the account details below. Click ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                      children: [
                                    TextSpan(
                                      text: '“I have Paid” ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                      ),
                                    ),
                                    TextSpan(
                                        text: 'when complete.',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                        ))
                                  ])),
                              const Spacer(),
                              Row(
                                children: [
                                  const Text(
                                    "Bank", //
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    controller.buyCallbackRes['data']
                                        ['bank_name'], //
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Opacity(
                                    opacity: 0,
                                    child: Icon(
                                      Octicons.copy,
                                      color: Color(0xffC5C5C5),
                                      size: 15,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Acc. Number", //
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    controller.buyCallbackRes['data']
                                            ['account_number']
                                        .toString(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      FlutterClipboard.copy(
                                        controller.buyCallbackRes['data']
                                                ['account_number']
                                            .toString(),
                                      ).then((value) {
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
                                      color: Colors.black,
                                      size: 15,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Name", //
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    controller.buyCallbackRes['data']
                                            ['account_name']
                                        .toString(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Opacity(
                                    opacity: 0,
                                    child: Icon(
                                      Octicons.copy,
                                      color: Color(0xffC5C5C5),
                                      size: 15,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Reference", //
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    controller.buyCallbackRes['data']
                                            ['reference']
                                        .toString(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      FlutterClipboard.copy(
                                        controller.buyCallbackRes['data']
                                                ['reference']
                                            .toString(),
                                      ).then((value) {
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
                                      color: Colors.black,
                                      size: 15,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              controller.paid.value == true
                                  ? Container()
                                  : Row(
                                      children: [
                                        Container(
                                          height: 86,
                                          width: 3,
                                          decoration: const BoxDecoration(
                                              color: Color(0xffFA7C07),
                                              borderRadius:
                                                  BorderRadius.horizontal(
                                                      left:
                                                          Radius.circular(7))),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        const Expanded(
                                          child: Text(
                                            "1. Please ensure you transfer the exact amount to avoid failed transaction. \n\n2. Do not save this account number. It is a one-time account number for this payment.",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                              const SizedBox(
                                height: 25,
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
                              child: Text(
                                "only pay from a bank account with the same name registered on ${Constants.store.read('USERDATA')['user']['full_name'] != null ? Constants.store.read('USERDATA')['user']['full_name'].toString() : ''}. Want to correct account name? Contact Support.",
                                // '3rd Party Payment is not allowed. Bank name must match with your registered name.',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xffffffff)),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 60,
                    ),

                    // const SizedBox(
                    //   height: 20,
                    // ),
                    if (controller.timerstarted.value)
                      Container(
                        height: controller.paid.value == true
                            ? 142
                            : controller.retry.value &&
                                    controller.paid.value == false
                                ? 182
                                : 100,
                        width: MediaQuery.sizeOf(context).width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
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
                                      color: Colors.black,
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
                                  "Pay", //
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  "Speed: $speedminute:${speedseconds}s", //
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11,
                                  ),
                                ),
                                const Spacer(),
                                const Text(
                                  "Confirmation", //
                                  style: TextStyle(
                                    color: Colors.black,
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
                                  value:
                                      controller.paid.value == true ? 1 : null,
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
                                      color: Colors.black,
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
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Contact Support',
                                            style: const TextStyle(
                                              color: Colors.black,
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
                              child: Text(
                                'Continue transaction later.',
                                style: TextStyle(
                                  color: Constants.txtColor(),
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
                            textColor:
                                const Color(0xffffffff).withOpacity(0.24),
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
                                ReceiptState.fiat;
                                controller
                                    .fiatToCryptoTxReceipt()
                                    .then((onValue) {
                                  controller.isLoading.value = false;

                                  if (onValue) {
                                    Get.put(RecordsController())
                                        .receiptState
                                        .value = ReceiptState.fiat;
                                    Get.put(RecordsController())
                                        .receiptState
                                        .value = ReceiptState.fiat;
                                    return Get.toNamed('/receipt');
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      )
                    else
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Button(
                            buttonWidth: MediaQuery.sizeOf(context).width / 3,
                            buttonText:
                                controller.retry.value ? "Retry" : "I’ve Paid ",
                            color: controller.retry.value == true
                                ? null
                                : controller.timerstarted.value
                                    ? const Color(0xffC4D0F0).withOpacity(0.22)
                                    : null,
                            onTap: () {
                              if (controller.retry.value == true) {
                                controller
                                    .ihavePaidWithFiat()
                                    .then((onValue) {});
                                controller.retry.value = false;
                                controller.paid.value = false;
                                controller.startTimer();
                              } else {
                                if (controller.timerstarted.value == false) {
                                  controller
                                      .ihavePaidWithFiat()
                                      .then((onValue) {});
                                  controller.startTimer();
                                }
                              }
                            },
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Button(
                            buttonWidth: MediaQuery.sizeOf(context).width / 3,
                            buttonText: "Continue",
                            border: Border.all(
                              color: const Color(0xffffffff).withOpacity(0.3),
                            ),
                            color: const Color(0xffffffff).withOpacity(0.3),
                            outline: true,
                            onTap: () {},
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                  ]),
                );
              },
            ),
          )),
    );
  }
}

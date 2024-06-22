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

class MakePaymentCrypto extends GetView<SwapRampController> {
  const MakePaymentCrypto({super.key});

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
                            "\$${Constants.moneyFormat(double.parse(Get.arguments['amount'].toString().split(',').join()))}",
                            // "\$10,023.43", //
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
                              color: Constants.txtColor(),
                              size: 15,
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
                            height: controller.paid.value == true ? 231 : 350,
                            width: MediaQuery.sizeOf(context).width,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 15),
                            decoration: BoxDecoration(
                                color: Constants.boxColor2(),
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Pay in the Account below", //
                                  style: TextStyle(
                                    color: Constants.boxColor1(),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                RichText(
                                    text: TextSpan(
                                        text:
                                            'Copy & transfer asset into the crypto address details below. Click ',
                                        style: TextStyle(
                                          color: Constants.boxColor1(),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                        ),
                                        children: [
                                      TextSpan(
                                        text: '“I have Paid” ',
                                        style: TextStyle(
                                          color: Constants.boxColor1(),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12,
                                        ),
                                      ),
                                      TextSpan(
                                          text: 'when complete.',
                                          style: TextStyle(
                                            color: Constants.boxColor1(),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                          ))
                                    ])),
                                const Spacer(),
                                Row(
                                  children: [
                                    Text(
                                      "Network", //
                                      style: TextStyle(
                                        color: Constants.boxColor1(),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      controller.sellCallbackRes['data']
                                          ['network'], //
                                      style: TextStyle(
                                        color: Constants.boxColor1(),
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
                                    Text(
                                      "Crypto Address", //
                                      style: TextStyle(
                                        color: Constants.boxColor1(),
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      width: MediaQuery.sizeOf(context).width /
                                          2.5,
                                      child: Text(
                                        controller.sellCallbackRes['data']
                                            ['pay_to_address'], //
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Constants.boxColor1(),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        FlutterClipboard.copy(controller
                                                    .sellCallbackRes['data']
                                                ['pay_to_address'])
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
                                        color: Constants.boxColor1(),
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
                                    Text(
                                      "Asset ", //
                                      style: TextStyle(
                                        color: Constants.boxColor1(),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      Get.arguments['from'] ?? "USDT", //
                                      style: TextStyle(
                                        color: Constants.boxColor1(),
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
                                                        left: Radius.circular(
                                                            7))),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "1. Please ensure you transfer the exact amount to avoid failed transaction. \n\n2. Do not save this address . It is a one-time address for this payment.",
                                              style: TextStyle(
                                                color: Constants.boxColor1(),
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
                          // if (controller.paid.value == false)
                          //   Positioned(
                          //     bottom: -40,
                          //     width: MediaQuery.sizeOf(context).width - 100,
                          //     child: Container(
                          //       // height: 71,
                          //       padding: const EdgeInsets.only(
                          //           top: 15, bottom: 15, left: 15, right: 15),
                          //       decoration: BoxDecoration(
                          //         color: const Color(0xff9F0303),
                          //         borderRadius: BorderRadius.circular(17),
                          //       ),
                          //       child: const Text(
                          //         '3rd Party Payment is not allowed. Bank name must match with your registered name.',
                          //         style: TextStyle(
                          //             fontSize: 12,
                          //             fontWeight: FontWeight.w700,
                          //             color: Color(0xffffffff)),
                          //       ),
                          //     ),
                          //   ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      // const Spacer(),

                      // const SizedBox(
                      //   height: 20,
                      // ),
                      if (controller.timerstarted.value)
                        Container(
                          height: controller.paid.value == true
                              ? 140
                              : controller.retry.value &&
                                      controller.paid.value == false
                                  ? 170
                                  : 100,
                          width: MediaQuery.sizeOf(context).width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          decoration: BoxDecoration(
                              color: Constants.boxColor2(),
                              borderRadius: BorderRadius.circular(17)),
                          child: Column(
                            children: [
                              Text(
                                "We are checking your payment", //
                                style: TextStyle(
                                  color: Constants.boxColor1(),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Pay", //
                                    style: TextStyle(
                                      color: Constants.boxColor1(),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    "Speed: $speedminute:${speedseconds}s", //
                                    style: TextStyle(
                                      color: Constants.boxColor1(),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    "Confirmation", //
                                    style: TextStyle(
                                      color: Constants.boxColor1(),
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
                                    value: controller.paid.value == true
                                        ? 3
                                        : null,
                                    minHeight: 2,
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
                                        fontSize: 11,
                                      ),
                                    )
                                  : const SizedBox(),
                              controller.paid.value == true
                                  ? Text(
                                      "We have Confirmed your transfer of \$${Get.arguments['amount'].toString()}. You can now proceed ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Constants.boxColor1(),
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
                                          style: TextStyle(
                                            color: Constants.boxColor1(),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: 'Contact Support',
                                              style: TextStyle(
                                                color: Constants.boxColor1(),
                                                fontWeight: FontWeight.w700,
                                                fontSize: 11,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () =>
                                                    Constants.llaunchUrl(
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
                              isLoading: controller.isLoading.value,
                              textColor:
                                  const Color(0xffffffff).withOpacity(0.24),
                              onTap: () async {
                                //
                                Constants.logger.d('af');
                              },
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            Button(
                              buttonWidth: MediaQuery.sizeOf(context).width / 3,
                              buttonText: "Continue",

                              // color: const Color(0xffffffff).withOpacity(0.3),
                              isLoading: controller.isLoading.value,
                              onTap: () {
                                Constants.logger.d(Get.arguments);
                                controller.isLoading.value = true;
                                controller
                                    .sellConfirmationCallbackUrl(
                                  arguments: Get.arguments,
                                )
                                    .then((onValue) {
                                  controller.isLoading.value = false;
                                });
                              },
                            ),
                          ],
                        )
                      else
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Button(
                              buttonWidth: MediaQuery.sizeOf(context).width / 3,
                              buttonText: controller.retry.value
                                  ? "Retry"
                                  : "I’ve Paid ",
                              color: controller.retry.value == true
                                  ? null
                                  : controller.timerstarted.value
                                      ? const Color(0xffC4D0F0)
                                          .withOpacity(0.22)
                                      : null,
                              onTap: () {
                                if (controller.retry.value == true) {
                                  controller
                                      .sellConfirmationCallbackUrl(
                                        arguments: Get.arguments,
                                      )
                                      .then((onValue) {});
                                  controller.retry.value = false;
                                  controller.paid.value = false;
                                  controller.startTimer();
                                } else {
                                  if (controller.timerstarted.value == false) {
                                    controller.isLoading.value = true;

                                    controller
                                        .sellConfirmationCallbackUrl(
                                      arguments: Get.arguments,
                                    )
                                        .then((value) {
                                      controller.isLoading.value = false;
                                    });

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
                              // onTap: () => Get.toNamed('/enterbankdetails',
                              //     arguments: Get.arguments),
                            ),
                          ],
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                    ]),
                  );
                },
              ))),
    );
  }
}

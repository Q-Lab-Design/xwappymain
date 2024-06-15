import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:xwappy/pages/swapramp/swaprampcontroller.dart';
import 'package:xwappy/widgets/button.dart';
import 'package:xwappy/widgets/inputfield.dart';

class EnterAddressCrypto extends GetView<SwapRampController> {
  EnterAddressCrypto({super.key});

  final formKay = GlobalKey<FormState>();

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
              child: Form(
                key: formKay,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Color(0xffFCF9F9),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => Get.offAllNamed('/home'),
                          child: const Icon(
                            Icons.close,
                            color: Color(0xffFCF9F9),
                          ),
                        ),
                      ],
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
                              "01",
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
                        Text(
                          "Enter ${Get.arguments['to'] ?? "USDT-TRC20"}\nAddress", //$10,023.43
                          style: const TextStyle(
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
                    const Text(
                      "We have confirmed your payment . Enter your\ncrypto address",
                      style: TextStyle(
                        color: Color(0xffD8D8D8),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextInputField(
                      hintText:
                          "${Get.arguments['to'] ?? "USDT-TRC20"} Address",
                      filledColor: const Color(0xff2A2A2A),
                      radius: 8.21,
                      // keyboardType: TextInputType.phone,
                      readonly: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an amount';
                        }

                        return null;
                      },
                      textStyle: const TextStyle(
                        color: Color(0xFFfcfcfc),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w400,
                      ),
                      controller: controller.addressController,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Image.asset(
                          'assets/images/image 219.png',
                          width: 25,
                          height: 25,
                        ),
                      ),
                      maxLines: 1,
                      suffixIcon: GestureDetector(
                        onTap: () async {
                          ClipboardData? clipBoardData =
                              await Clipboard.getData(Clipboard.kTextPlain);

                          if (clipBoardData != null) {
                            controller.addressController.text =
                                clipBoardData.text.toString();

                            Fluttertoast.showToast(
                                msg: "Pasted!!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 3,
                                fontSize: 16.0);
                          }
                        },
                        child: const SizedBox(
                          width: 60,
                          height: 50,
                          child: Center(
                            child: Text(
                              "Paste  ",
                              style: TextStyle(
                                color: Color(0xffA7A7A7),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // const Text(
                    //   "You can only paste address",
                    //   style: TextStyle(
                    //     color: Color(0xffFA7C07),
                    //     fontWeight: FontWeight.w400,
                    //     fontSize: 14,
                    //   ),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextInputField(
                      hintText:
                          "Confirm ${Get.arguments['to'] ?? "USDT-TRC20"} Address",
                      filledColor: const Color(0xff2A2A2A),
                      radius: 8.21,
                      controller: controller.confirmAddressController,
                      textStyle: const TextStyle(
                        color: Color(0xFFfcfcfc),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w400,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an amount';
                        }

                        if (value.toString() !=
                            controller.addressController.text) {
                          return 'Value must be the same';
                        }

                        return null;
                      },
                      maxLines: 1,
                      readonly: false,
                      suffixIcon: GestureDetector(
                        onTap: () async {
                          ClipboardData? clipBoardData =
                              await Clipboard.getData(Clipboard.kTextPlain);

                          if (clipBoardData != null) {
                            controller.confirmAddressController.text =
                                clipBoardData.text.toString();

                            Fluttertoast.showToast(
                                msg: "Pasted!!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 3,
                                // // backgroundColor: const Color(0xffF1D643),
                                // webBgColor: const Color(0xffF1D643),
                                // // textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        child: const SizedBox(
                          width: 60,
                          height: 50,
                          child: Center(
                            child: Text(
                              "Paste  ",
                              style: TextStyle(
                                color: Color(0xffA7A7A7),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // const Text(
                    //   "You can only paste address",
                    //   style: TextStyle(
                    //     color: Color(0xffFA7C07),
                    //     fontWeight: FontWeight.w400,
                    //     fontSize: 14,
                    //   ),
                    // ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      "Network", //Select
                      style: TextStyle(
                        color: Color(0xffD8D8D8),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xff2A2A2A),
                        border: Border.all(
                            width: 0.5, color: const Color(0xFfC3C7E5)),
                        borderRadius: BorderRadius.circular(8.1),
                      ),
                      child: DropdownButton(
                          isExpanded: true,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            // color: Color(0xff6F6F6F),
                            color: Colors.transparent,
                          ),
                          hint: Text(
                            Get.arguments['to'] == null
                                ? "TRC20"
                                : Get.arguments['to']
                                    .toString()
                                    .split('-')
                                    .last,
                            style: const TextStyle(
                              color: Color(0xffA7A7A7),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          underline: const SizedBox(),
                          onChanged: (v) {},
                          items: const []),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Transform.scale(
                            scale: 0.5,
                            child: Obx(
                              () => CupertinoSwitch(
                                  trackColor: Colors.grey,
                                  activeColor: const Color(0xffF1D643),
                                  value: controller.confirmCryptoaddress.value,
                                  onChanged: (v) {
                                    controller.confirmCryptoaddress.value = v;
                                  }),
                            )),
                        const Text(
                          "I have confirm crypto address is correct",
                          style: TextStyle(
                            color: Color(0xffF8F7F4),
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Transform.scale(
                            scale: 0.5,
                            child: Obx(
                              () => CupertinoSwitch(
                                  trackColor: Colors.grey,
                                  activeColor: const Color(0xffF1D643),
                                  value: controller.termsandcondition.value,
                                  onChanged: (v) {
                                    controller.termsandcondition.value = v;
                                  }),
                            )),
                        const Text(
                          "I accept Terms & Conditions",
                          style: TextStyle(
                            color: Color(0xffF8F7F4),
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Obx(
                      () => Button(
                        buttonWidth: MediaQuery.sizeOf(context).width,
                        color: !controller.confirmCryptoaddress.value ||
                                !controller.termsandcondition.value
                            ? Colors.grey
                            : null,
                        buttonText: "Continue",
                        isLoading: controller.isLoading.value,
                        onTap: () {
                          if (formKay.currentState!.validate()) {
                            if (controller.confirmCryptoaddress.value &&
                                controller.termsandcondition.value) {
                              controller.isLoading.value = true;
                              controller
                                  .createFiatToCryptoOrder(
                                      address: controller
                                          .confirmAddressController.text,
                                      from: Get.arguments['from'],
                                      to: Get.arguments['to']
                                          ?.toString()
                                          .split('-')
                                          .first,
                                      network: Get.arguments['to']
                                          ?.toString()
                                          .toLowerCase(),
                                      amount: Get.arguments['amount'])
                                  .then((value) {
                                controller.isLoading.value = false;
                                if (value == true) {
                                  return Get.toNamed('/makepaymentfiat',
                                      arguments: Get.arguments);
                                }
                              });
                            }
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
          )),
    );
  }
}

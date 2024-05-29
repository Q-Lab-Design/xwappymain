import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:xwappy/pages/swapramp/swaprampcontroller.dart';
import 'package:xwappy/widgets/button.dart';
import 'package:xwappy/widgets/inputfield.dart';

import '../records/recordscontroller.dart';

class CashoutScreen extends GetView<SwapRampController> {
  CashoutScreen({super.key});

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
                          "Withdraw\nBonus", //$10,023.43
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Referral Balance",
                          style: TextStyle(
                            color: Color(0xffD8D8D8),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "NGN12,000",
                          style: TextStyle(
                            color: Color(0xffD8D8D8),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextInputField(
                      hintText: "Account Number",
                      filledColor: const Color(0xff2A2A2A),
                      radius: 8.21,
                      keyboardType: TextInputType.phone,
                      controller: controller.accountNumber,
                      suffixIcon: GestureDetector(
                        onTap: () async {
                          ClipboardData? clipBoardData =
                              await Clipboard.getData(Clipboard.kTextPlain);

                          if (clipBoardData != null) {
                            controller.accountNumber.text =
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
                          width: 50,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an amount';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextInputField(
                      hintText: "Confirm Account Number",
                      filledColor: const Color(0xff2A2A2A),
                      controller: controller.confirmAccountNumber,
                      radius: 8.21,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an amount';
                        }

                        if (value.toString() != controller.accountNumber.text) {
                          return 'Value must be the same';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xff2A2A2A),
                        border: Border.all(
                            width: 0.5, color: const Color(0xFfC3C7E5)),
                        borderRadius: BorderRadius.circular(8.1),
                      ),
                      child: Center(
                        child: DropdownButtonFormField(
                            isExpanded: true,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Color(0xff6F6F6F),
                            ),
                            value: controller.provider.value,
                            hint: const Text(
                              "Select Provider",
                              style: TextStyle(
                                color: Color(0xffA7A7A7),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            // underline: const SizedBox(),
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                            validator: (value) {
                              if (value == null) {
                                return 'Select Provider';
                              }

                              return null;
                            },
                            onChanged: (v) {
                              controller.provider.value = v;
                            },
                            items: const [
                              DropdownMenuItem(
                                value: "035",
                                child: Text(
                                  "035",
                                  style: TextStyle(
                                    color: Color(0xffA7A7A7),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            ]),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Charles Avis",
                      style: TextStyle(
                        color: Color(0xff83BF4F),
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 35,
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
                          "I have confirm Account details is correct",
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
                        buttonWidth: 210,
                        buttonText: "Cashout",
                        isLoading: controller.isLoading.value,
                        color: controller.confirmCryptoaddress.value == false
                            ? Colors.grey
                            : null,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            if (controller.confirmCryptoaddress.value) {
                              controller.isLoading.value = true;
                              // controller
                              //     .fiatCreditedCallbackURL()
                              //     .then((value) {
                              //   controller.isLoading.value = false;
                              // }
                              Get.put(RecordsController()).receiptState.value =
                                  ReceiptState.fiat;
                              controller
                                  .ihavePaidForCrypto(
                                accountName: '',
                                accountNumber:
                                    controller.confirmAccountNumber.text,
                                accountcodenetwork: '',
                              )
                                  .then((value) {
                                controller.isLoading.value = false;
                                return Get.toNamed('/receipt');
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

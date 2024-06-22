import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:xwappy/pages/swapramp/swaprampcontroller.dart';
import 'package:xwappy/widgets/button.dart';
import 'package:xwappy/widgets/inputfield.dart';

import '../../constants.dart';
import '../records/recordscontroller.dart';

class CashoutScreen extends GetView<SwapRampController> {
  CashoutScreen({super.key}) {
    controller.accountvertifydata['account_name'] = "";
    controller.amountError.value = "";
    // fetchBank();
    if (controller.bnkList.isEmpty) {
      controller.isLoadingmain.value = true;
    }

    // Get.reload()

    // controller
    //     .fetchBanks(currency: Get.arguments['to'] ?? 'ngn')
    //     .then((value) => setBank());

    setBank();
  }

  RxList bankList = [...Constants.bnklist()].obs;
  final selectedBank = Rxn<Map>();

  Future<void> setBank() async {
    try {
      bankList.value = List.from(Constants.bnklist());
      if (bankList.last['bank_name'] == null) {
        bankList.sort((a, b) => a['name'].compareTo(b['name']));
      } else {
        bankList.sort((a, b) => a['bank_name'].compareTo(b['bank_name']));
      }

      selectedBank.value = bankList[0];

      controller.provider.value = bankList[0]['code'];

      // print(bankList);
    } catch (error) {
      Constants.logger.d('Error reading JSON file: $error');
    }
  }

  Timer? _timer;

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
                        Text(
                          "Withdraw\nBonus", //$10,023.43
                          style: TextStyle(
                            color: Constants.txtColor(),
                            fontWeight: FontWeight.w700,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Referral Balance",
                          style: TextStyle(
                            color: Constants.txtColor(),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "NGN0",
                          style: TextStyle(
                            color: Constants.txtColor(),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xff2A2A2A),
                        border: Border.all(
                          width: 0.5,
                          color: Constants.txtColor()!,
                        ),
                        borderRadius: BorderRadius.circular(8.1),
                      ),
                      child: DropdownSearch<Map>(
                        popupProps: PopupProps.dialog(
                          showSelectedItems: false,
                          dialogProps: DialogProps(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              contentPadding: const EdgeInsets.only(top: 10)),
                          showSearchBox: true,
                          searchFieldProps: TextFieldProps(
                            style: const TextStyle(
                              height: 1,
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      BorderSide(color: Constants.txtColor()!)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: Constants.txtColor()!,
                                  )),
                            ),
                          ),
                          itemBuilder: (context, e, condition) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Text(
                                e['bank_name'] ?? e['name'],
                              ),
                            );
                          },
                        ),
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                        dropdownBuilder: (context, e) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              e != null
                                  ? e['bank_name'] ?? e['name']
                                  : "Select Provider",
                              style: TextStyle(
                                color: Constants.txtColor(),
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          );
                        },
                        items: List<Map<dynamic, dynamic>>.from(
                            Constants.bnklist()),
                        onChanged: (sel) {
                          Constants.logger.d(sel);
                          selectedBank.value = sel;
                          controller.provider.value = sel!['code'];

                          _timer?.cancel();
                          _timer = Timer(const Duration(seconds: 2), () {
                            if (Get.arguments == null) {
                              controller.verifyAccount(
                                  acctnumber: controller.accountNumber.text,
                                  code: selectedBank.value!['code']);
                              return;
                            }
                            if (Get.arguments['to'] != null &&
                                Get.arguments['to'] == "NGN") {
                              if (controller.accountNumber.text.isNotEmpty) {
                                controller.verifyAccount(
                                    acctnumber: controller.accountNumber.text,
                                    code: selectedBank.value!['code']);
                              } else {
                                controller.accountvertifydata['account_name'] =
                                    null;

                                controller.accountvertifydata.refresh();
                              }
                            }
                          });
                        },
                        selectedItem: selectedBank.value,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextInputField(
                      hintText: "Account Number",
                      filledColor: const Color(0xff2A2A2A),
                      radius: 8.21,
                      keyboardType: TextInputType.phone,
                      controller: controller.accountNumber,
                      onChanged: (v) {
                        _timer?.cancel();
                        _timer = Timer(const Duration(seconds: 2), () {
                          if (Get.arguments == null) {
                            controller.verifyAccount(
                                acctnumber: controller.accountNumber.text,
                                code: selectedBank.value!['code']);
                            return;
                          }
                          if (Get.arguments['to'] != null &&
                              Get.arguments['to'] == "NGN") {
                            if (v.isNotEmpty) {
                              controller.verifyAccount(
                                  acctnumber: controller.accountNumber.text,
                                  code: selectedBank.value!['code']);
                            } else {
                              controller.accountvertifydata['account_name'] =
                                  null;

                              controller.accountvertifydata.refresh();
                            }
                          }
                        });
                      },
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
                          return 'Please enter an amount';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Obx(
                          () => Text(
                            controller.accountvertifydata
                                        .value['account_name'] !=
                                    null
                                ? controller
                                    .accountvertifydata.value['account_name']
                                    .toString()
                                    .toUpperCase()
                                : '',
                            style: const TextStyle(
                                fontSize: 13, color: Color(0xffF1D643)),
                          ),
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    TextInputField(
                      hintText: "OTP",
                      filledColor: const Color(0xff2A2A2A),
                      radius: 8.21,
                      keyboardType: TextInputType.phone,
                      controller: controller.otpController,
                      onChanged: (v) {
                        controller.isLoading.refresh();
                      },
                      suffixIcon: GestureDetector(
                        onTap: () async {
                          controller.isLoading.value = true;
                          controller
                              .getOtp(
                                  email: Constants.store
                                      .read('USERDATA')['user']['email'])
                              .then((onValue) {
                            controller.isLoading.value = false;
                          });
                        },
                        child: SizedBox(
                          width: 70,
                          height: 50,
                          child: Center(
                            child: Text(
                              "Get OTP",
                              style: TextStyle(
                                color: Constants.txtColor(),
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter OTP';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 35,
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
                        Text(
                          "I have confirm Account details is correct",
                          style: TextStyle(
                            color: Constants.txtColor(),
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
                      () {
                        controller.isLoading.value;
                        return Button(
                          buttonWidth: 210,
                          buttonText: "Cashout",
                          isLoading: controller.isLoading.value,
                          color:
                              controller.confirmCryptoaddress.value == false ||
                                      controller.otpController.text.isEmpty
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
                                Get.put(RecordsController())
                                    .receiptState
                                    .value = ReceiptState.fiat;
                                controller
                                    .cashoutRefferal(
                                  accountnumber: controller.accountNumber.text,
                                  bankCode: controller.provider.value,
                                )
                                    .then((value) {
                                  controller.isLoading.value = false;
                                  if (value == true) {
                                    return Get.toNamed('/referralreceipt');
                                  }
                                });
                              }
                            }
                          },
                        );
                      },
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

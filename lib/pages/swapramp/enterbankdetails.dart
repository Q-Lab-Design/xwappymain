import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:xwappy/constants.dart';
import 'package:xwappy/pages/swapramp/swaprampcontroller.dart';
import 'package:xwappy/widgets/button.dart';
import 'package:xwappy/widgets/inputfield.dart';

import '../records/recordscontroller.dart';

class EnterBankDetails extends GetView<SwapRampController> {
  EnterBankDetails({super.key}) {
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

  final formKey = GlobalKey<FormState>();
  // List bnk = Constants.bnklist();
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

      // print(bankList);
    } catch (error) {
      Constants.logger.d('Error reading JSON file: $error');
    }
  }

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
                          "Enter Bank\ndetails", //$10,023.43
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
                    const Text(
                      "We have confirmed your crypto deposit. Enter your bank account details",
                      style: TextStyle(
                        color: Color(0xffD8D8D8),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
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
                                  borderSide: const BorderSide(
                                      color: Color(0xffAEACAC))),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color: Color(0xffAEACAC))),
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
                              style: const TextStyle(
                                color: Color(0xffD8D8D8),
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
                        },
                        selectedItem: selectedBank.value,
                      ),
                    ),
                    // Container(
                    //   height: 50,
                    //   padding: const EdgeInsets.only(
                    //       left: 10, right: 10, top: 10, bottom: 8),
                    //   decoration: BoxDecoration(
                    //       border: Border.all(
                    //         color: const Color(0xffAEACAC),
                    //         width: 0.5,
                    //       ),
                    //       borderRadius: BorderRadius.circular(15)),
                    //   child: DropdownButtonHideUnderline(
                    //     child: DropdownSearch<Map>(
                    //       popupProps: PopupProps.dialog(
                    //         showSelectedItems: false,
                    //         // constraints: const BoxConstraints(maxHeight: 300),
                    //         dialogProps: DialogProps(
                    //             shape: RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(20)),
                    //             contentPadding: const EdgeInsets.only(top: 10)),
                    //         // searchFieldProps: TextFieldProps(

                    //         // ), 0505523521
                    //         // disabledItemFn: (String s) => s.startsWith('I'),
                    //         showSearchBox: true,

                    //         searchFieldProps: TextFieldProps(
                    //           style: const TextStyle(
                    //             height: 1,
                    //           ),
                    //           decoration: InputDecoration(
                    //             isDense: true,
                    //             focusedBorder: OutlineInputBorder(
                    //                 borderRadius: BorderRadius.circular(20),
                    //                 borderSide: const BorderSide(
                    //                     color: Color(0xffAEACAC))),
                    //             border: OutlineInputBorder(
                    //                 borderRadius: BorderRadius.circular(20),
                    //                 borderSide: const BorderSide(
                    //                     color: Color(0xffAEACAC))),
                    //           ),
                    //         ),
                    //         itemBuilder: (context, e, condition) {
                    //           return Padding(
                    //             padding: const EdgeInsets.symmetric(
                    //                 horizontal: 15, vertical: 10),
                    //             child: Text(
                    //               e['bank_name'] ?? e['name'],
                    //             ),
                    //           );
                    //         },
                    //       ),

                    //       // dropdownSearchDecoration: const InputDecoration(
                    //       //   border: InputBorder.none,
                    //       //   contentPadding: EdgeInsets.zero,
                    //       // ),
                    //       dropdownDecoratorProps: const DropDownDecoratorProps(
                    //         dropdownSearchDecoration: InputDecoration(
                    //           border: InputBorder.none,
                    //           contentPadding: EdgeInsets.zero,
                    //         ),
                    //       ),
                    //       dropdownBuilder: (context, e) {
                    //         return Text(
                    //           e != null
                    //               ? e['bank_name'] ?? e['name']
                    //               : "Loading.....",
                    //         );
                    //       },

                    //       items:
                    //           List<Map<dynamic, dynamic>>.from(bankList.value),

                    //       // dropdownDecoratorProps: DropDownDecoratorProps(
                    //       //   dropdownSearchDecoration: InputDecoration(
                    //       //     labelText: "Menu mode",
                    //       //     hintText: "country in menu mode",
                    //       //   ),
                    //       // ),
                    //       onChanged: (sel) {
                    //         Constants.logger.d(sel);
                    //         selectedBank.value = sel;
                    //       },
                    //       selectedItem: selectedBank.value,
                    //     ),
                    //   ),
                    // ),
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
                        buttonWidth: MediaQuery.sizeOf(context).width,
                        buttonText: "Continue",
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
                                accountcodenetwork: controller.provider.value,
                              )
                                  .then((value) {
                                controller.isLoading.value = false;
                                return Get.toNamed('/receipt',
                                    arguments: Get.arguments);
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

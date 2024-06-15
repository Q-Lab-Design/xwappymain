import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xwappy/pages/records/recordscontroller.dart';

import '../../widgets/button.dart';
import '../swapramp/swaprampcontroller.dart';

class ReceiptScreen extends GetView<RecordsController> {
  const ReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final swapController = Get.put(SwapRampController());
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
              () => SingleChildScrollView(
                child: Column(children: [
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
                            "03",
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
                        "Transactions\nReceipt", //$10,023.43
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
                  // Center(
                  //   child: Container(
                  //     height: 40,
                  //     width: 303,
                  //     decoration: BoxDecoration(
                  //         color: const Color(0xffffffff),
                  //         borderRadius: BorderRadius.circular(22)),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         GestureDetector(
                  //           onTap: () {
                  //             // controller.receiptState.value =
                  //             //     ReceiptState.crypto;
                  //           },
                  //           child: Container(
                  //             height: 50,
                  //             width: 152,
                  //             padding: const EdgeInsets.symmetric(
                  //                 horizontal: 15, vertical: 5),
                  //             decoration: BoxDecoration(
                  //                 color: controller.receiptState.value ==
                  //                         ReceiptState.crypto
                  //                     ? const Color(0xffF1D643)
                  //                     : const Color(0xffffffff),
                  //                 borderRadius: BorderRadius.circular(22)),
                  //             child: const Center(
                  //               child: Text(
                  //                 "Crypto Receipt",
                  //                 style: TextStyle(
                  //                   color: Color(0xff000000),
                  //                   fontWeight: FontWeight.w600,
                  //                   fontSize: 14,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         GestureDetector(
                  //           onTap: () {
                  //             // controller.receiptState.value = ReceiptState.fiat;
                  //           },
                  //           child: Container(
                  //             height: 50,
                  //             width: 150,
                  //             padding: const EdgeInsets.symmetric(
                  //                 horizontal: 25, vertical: 5),
                  //             decoration: BoxDecoration(
                  //                 color: controller.receiptState.value ==
                  //                         ReceiptState.fiat
                  //                     ? const Color(0xffF1D643)
                  //                     : const Color(0xffffffff),
                  //                 borderRadius: BorderRadius.circular(22)),
                  //             child: const Center(
                  //               child: Text(
                  //                 "Fiat Receipt",
                  //                 style: TextStyle(
                  //                   color: Color(0xff000000),
                  //                   fontWeight: FontWeight.w600,
                  //                   fontSize: 14,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (controller.receiptState.value == ReceiptState.crypto) ...[
                    const SizedBox(
                      height: 7,
                    ),
                    const Text(
                      "Funds is on the way",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xffffffff),
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Your crypto swap to the below address is on it’s way. Check your wallet for confirmation.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xffffffff),
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(children: [
                      const Text(
                        "Crypto Address",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff8F8F8F),
                          // decoration: TextDecoration.,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        swapController.transactionCryptoData?.cryptoAddress ??
                            '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xffFFFFFF),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      const Text(
                        "Crypto Network",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff8F8F8F),
                          // decoration: TextDecoration.,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        swapController.transactionCryptoData?.cryptoNetwork ??
                            '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xffFFFFFF),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      const Text(
                        "Payment Reference",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff8F8F8F),
                          // decoration: TextDecoration.,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        swapController.transactionCryptoData?.paymentRef ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xffFFFFFF),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      const Text(
                        "Order Number",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff8F8F8F),
                          // decoration: TextDecoration.,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        swapController.transactionCryptoData?.orderNo ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xffFFFFFF),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      const Text(
                        "Payment Provider",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff8F8F8F),
                          // decoration: TextDecoration.,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        swapController.transactionCryptoData?.paymentProvider ??
                            '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xffFFFFFF),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      const Text(
                        "From ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff8F8F8F),
                          // decoration: TextDecoration.,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        swapController.transactionCryptoData?.fromCurrencyAmt ??
                            '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xffFFFFFF),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      const Text(
                        "To Currency",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff8F8F8F),
                          // decoration: TextDecoration.,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        swapController.transactionCryptoData?.toCurrencyAmt ??
                            '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xffFFFFFF),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      const Text(
                        "Rate",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff8F8F8F),
                          // decoration: TextDecoration.,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        swapController.transactionCryptoData?.rate ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xffFFFFFF),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      const Text(
                        "Timestamp",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff8F8F8F),
                          // decoration: TextDecoration.,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        swapController.transactionCryptoData?.timestamp ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xffFFFFFF),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      const Text(
                        "Transaction Hash",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff8F8F8F),
                          // decoration: TextDecoration.,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        swapController.transactionCryptoData?.txnHash ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xffFFFFFF),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      const Text(
                        "Fee",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff8F8F8F),
                          // decoration: TextDecoration.,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        swapController.transactionCryptoData?.fee ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xffFFFFFF),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 50,
                    ),
                    Button(
                      buttonText: "Close",
                      onTap: () {
                        Get.toNamed('/home');
                      },
                    )
                  ],
                  if (controller.receiptState.value == ReceiptState.fiat) ...[
                    const SizedBox(
                      height: 7,
                    ),
                    const Text(
                      "Funds is on the way",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xffffffff),
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Your fiat transfer was received and\nimmediately processed to USDT",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xffffffff),
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(children: [
                      const Text(
                        "Payment Reference",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff8F8F8F),
                          // decoration: TextDecoration.,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        swapController.transactionFiatData?.paymentRef ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xffFFFFFF),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      const Text(
                        "Order Number",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff8F8F8F),
                          // decoration: TextDecoration.,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        swapController.transactionFiatData?.orderNo ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xffFFFFFF),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      const Text(
                        "Sender’s Bank",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff8F8F8F),
                          // decoration: TextDecoration.,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        swapController.transactionFiatData?.senderBank ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xffFFFFFF),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      const Text(
                        "Amount Paid ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff8F8F8F),
                          // decoration: TextDecoration.,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        swapController.transactionFiatData?.amountPaid ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xffFFFFFF),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      const Text(
                        "Sender Name",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff8F8F8F),
                          // decoration: TextDecoration.,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        swapController.transactionFiatData?.senderName ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xffFFFFFF),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      const Text(
                        "Account number",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff8F8F8F),
                          // decoration: TextDecoration.,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        swapController.transactionFiatData?.accountNumber ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xffFFFFFF),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      const Text(
                        "Timestamp",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff8F8F8F),
                          // decoration: TextDecoration.,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        swapController.transactionFiatData?.timestamp ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xffFFFFFF),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      const Text(
                        "Rate",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff8F8F8F),
                          // decoration: TextDecoration.,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        swapController.transactionFiatData?.rate ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xffFFFFFF),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 50,
                    ),
                    Button(
                      buttonText: "Close",
                      onTap: () => Get.offAllNamed('/home'),
                    )
                  ],
                  const SizedBox(
                    height: 20,
                  ),
                ]),
              ),
            ),
          )),
    );
  }
}

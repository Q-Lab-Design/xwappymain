import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xwappy/constants.dart';
import 'package:xwappy/pages/records/model.dart';
import 'package:xwappy/pages/records/recordscontroller.dart';
import 'package:xwappy/pages/swapramp/swaprampcontroller.dart';

import '../../widgets/button.dart';

class RecordsCard extends StatelessWidget {
  RecordsCard({super.key, required this.type, required this.state, this.data});

  String type;
  String state;
  TransactionSummary? data;

  RxBool isLoading = false.obs;

  final swapRampController = Get.put(SwapRampController());

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 140,
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      decoration: BoxDecoration(
          color: const Color(0xff1C1C1C),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  (data?.type == "buy"
                          ? data!.fromCurrency
                          : data!.fromCurrency) +
                      data!.fiatamount,
                  overflow: TextOverflow.ellipsis,
                  // "\$10,023.43", //
                  style: TextStyle(
                    color: Constants.txtColor(),
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              const Icon(
                Icons.keyboard_arrow_right_outlined,
                color: Color(0xff6F6F6F),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  (data!.toCurrency).split('-').first.toUpperCase() +
                      data!.dollaramount,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Constants.txtColor(),
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                data?.date != null
                    ? DateFormat('d \'th\' MMMM yyyy')
                        .format(DateTime.parse(data!.date))
                    : '',
                style: TextStyle(
                  color: Constants.txtColor(),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Ref: ${data?.reference ?? ''}", //
            style: TextStyle(
              color: Constants.txtColor(),
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                //
                type == "complete"
                    ? "Complete"
                    : type == "initiated"
                        ? 'Initiated'
                        : state == "Start KYC"
                            ? 'Pending - No KYC'
                            : state == "Contact Support"
                                ? 'Pending - 3rd Party Payment'
                                : state == "Continue"
                                    ? 'Pending - Abandoned'
                                    : "Pending - Processing",
                style: TextStyle(
                  color: type == "complete"
                      ? const Color(0xff83BF4F)
                      : type == "initiated"
                          ? const Color(0xffBF854F)
                          : const Color(0xffFA7C07),
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              Obx(
                () => Button(
                  radius: 9,
                  buttonText:
                      state == "PENDING_KYC_ISSUE" ? "Start KYC" : state,
                  padding: EdgeInsets.zero,
                  textSize: 10.5,
                  height: 28,
                  isLoading: isLoading.value,
                  onTap: () {
                    if (state == "Continue to Pay") {
                      if (data?.type == "buy") {
                        isLoading.value = true;
                        swapRampController.orderno = data!.orderNo;
                        swapRampController.buyCallbackUrl().then((onValue) {
                          isLoading.value = false;
                          if (onValue) {
                            Get.toNamed('/makepaymentfiat', arguments: {
                              "to": data!.toCurrency.isEmpty
                                  ? "USDT"
                                  : data?.toCurrency,
                              "from": data!.fromCurrency.isEmpty
                                  ? "NGN"
                                  : data!.fromCurrency,
                              "amount": data?.amount
                            });
                          }
                        });
                      } else {
                        isLoading.value = true;
                        swapRampController.orderno = data!.orderNo;
                        swapRampController
                            .sellCallbackUrl(ordern: data!.orderNo)
                            .then((onValue) {
                          isLoading.value = false;
                          if (onValue) {
                            Get.toNamed('/makepaymentcrypto', arguments: {
                              "to": data!.toCurrency.isEmpty
                                  ? "NGN"
                                  : data?.toCurrency,
                              "from": data!.fromCurrency.isEmpty
                                  ? "USDT"
                                  : data!.fromCurrency,
                              "amount": data?.amount
                            });
                          }
                        });
                      }
                      return;
                    }
                    if (data!.kycurl.isNotEmpty) {
                      Constants.llaunchUrl(data!.kycurl);
                      return;
                    }
                    if (type == "complete" ||
                        data?.status.toUpperCase() == "PENDING") {
                      if (data?.type == "sell") {
                        Get.put(RecordsController()).receiptState.value =
                            ReceiptState.crypto;
                        isLoading.value = true;
                        Get.put(SwapRampController())
                            .cryptoToFiatTxnReceipt()
                            .then((onValue) {
                          isLoading.value = false;
                          if (onValue) {
                            return Get.toNamed('/receipt');
                          }
                        });
                      } else {
                        Get.put(RecordsController()).receiptState.value =
                            ReceiptState.fiat;

                        isLoading.value = true;
                        Get.put(SwapRampController())
                            .fiatToCryptoTxReceipt(ordern: data?.orderNo)
                            .then((onValue) {
                          isLoading.value = false;
                          if (onValue) {
                            Get.toNamed('/receipt');
                          }
                        });
                      }
                    } else if (type == "test-data") {
                      isLoading.value = true;

                      Get.put(SwapRampController())
                          .buyCallbackUrl(ordern: data?.orderNo)
                          .then((onValue) {
                        isLoading.value = false;
                        if (onValue) {
                          Get.toNamed('/makepaymentfiat', arguments: {
                            "to": "NGN",
                            "from": "NGN",
                            "amount": data?.amount
                          });
                        }
                      });
                    }
                  },
                  color: data!.kycurl.isNotEmpty
                      ? const Color(0xff83BF4F)
                      : state == "Start KYC"
                          ? const Color(0xff83BF4F)
                          : state == "Contact Support"
                              ? const Color(0xffFA7C07)
                              : state == "Continue"
                                  ? Constants.txtColor()
                                  : state == "Continue to Pay"
                                      ? const Color(0xff83BF4F)
                                      : null,
                  buttonWidth: 91,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

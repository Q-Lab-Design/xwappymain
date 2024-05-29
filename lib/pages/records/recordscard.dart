import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
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
              Text(
                data?.amount ?? '',
                // "\$10,023.43", //
                style: const TextStyle(
                  color: Color(0xffC5C5C5),
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              Text(
                data?.date ?? '',
                // "12th May 2024", //
                style: const TextStyle(
                  color: Color(0xffffffff),
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
            style: const TextStyle(
              color: Color(0xffffffff),
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
                  buttonText: state,
                  padding: EdgeInsets.zero,
                  textSize: 10.5,
                  height: 28,
                  isLoading: isLoading.value,
                  onTap: () {
                    if (type == "complete") {
                      Get.put(RecordsController()).receiptState.value =
                          ReceiptState.crypto;

                      isLoading.value = true;
                      Get.put(SwapRampController())
                          .fiatToCryptoTxReceipt(ordern: data?.orderNo)
                          .then((onValue) {
                        isLoading.value = false;
                        if (onValue) {
                          Get.toNamed('/receipt');
                        }
                      });
                    } else if (type == "test-data") {
                      isLoading.value = true;

                      Get.put(SwapRampController())
                          .buyCallbackUrl(orderno: data?.orderNo)
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
                  color: state == "Start KYC"
                      ? const Color(0xff83BF4F)
                      : state == "Contact Support"
                          ? const Color(0xffFA7C07)
                          : state == "Continue"
                              ? const Color(0xffFFFFFF)
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

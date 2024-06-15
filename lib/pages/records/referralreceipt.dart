import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xwappy/pages/records/recordscontroller.dart';

import '../../widgets/button.dart';
import '../swapramp/swaprampcontroller.dart';

class ReferralReceipt extends GetView<RecordsController> {
  const ReferralReceipt({super.key});

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
              height: 60,
            ),
            const Spacer(),
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
              height: 50,
            ),
            const Text(
              "Your Referral Bonus Withdraw is on it's Check your wallet for confirmation.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xffffffff),
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 50,
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
                swapController.transactionCryptoData?.cryptoAddress ??
                    'PAID-9934G3OWEXKU923',
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
                "Bank",
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
                    'MoniePoint',
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
                "Amount",
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
                swapController.transactionCryptoData?.paymentRef ??
                    'NGN 20,000',
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
                " Name",
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
                swapController.transactionCryptoData?.orderNo ?? 'Charles Avis',
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
                swapController.transactionCryptoData?.paymentProvider ??
                    '7045274781',
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
                "Timestamp ",
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
                    '1st Mar 2024 10:23am',
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
                swapController.transactionCryptoData?.toCurrencyAmt ?? r'$3.0',
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
            const SizedBox(
              height: 50,
            ),
            Button(
              buttonText: "Close",
              onTap: () {
                Get.toNamed('/home');
              },
            ),
            const Spacer(),
            const SizedBox(
              height: 20,
            ),
          ]),
        ),
      ),
    );
  }
}

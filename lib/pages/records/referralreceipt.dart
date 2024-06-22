import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xwappy/constants.dart';
import 'package:xwappy/pages/records/recordscontroller.dart';

import '../../widgets/button.dart';
import '../swapramp/swaprampcontroller.dart';

class ReferralReceipt extends GetView<RecordsController> {
  const ReferralReceipt({super.key});

  @override
  Widget build(BuildContext context) {
    final swapController = Get.put(SwapRampController());
    return Scaffold(
      backgroundColor: Constants.bkgColor(),
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
            Text(
              "Funds is on the way",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Constants.txtColor(),
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              "Your Referral Bonus Withdraw is on it's Check your wallet for confirmation.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Constants.txtColor(),
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(children: [
              Text(
                "Payment Reference",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Constants.txtColor(),
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
                style: TextStyle(
                  color: Constants.txtColor(),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            Row(children: [
              Text(
                "Bank",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Constants.txtColor(),
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
                style: TextStyle(
                  color: Constants.txtColor(),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            Row(children: [
              Text(
                "Amount",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Constants.txtColor(),
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
                style: TextStyle(
                  color: Constants.txtColor(),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            Row(children: [
              Text(
                "Name",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Constants.txtColor(),
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              Text(
                swapController.transactionCryptoData?.orderNo ?? 'Charles Avis',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Constants.txtColor(),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            Row(children: [
              Text(
                "Account number",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Constants.txtColor(),
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
                style: TextStyle(
                  color: Constants.txtColor(),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            Row(children: [
              Text(
                "Timestamp ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Constants.txtColor(),
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
                style: TextStyle(
                  color: Constants.txtColor(),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            Row(children: [
              Text(
                "Fee",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Constants.txtColor(),
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
                style: TextStyle(
                  color: Constants.txtColor(),
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

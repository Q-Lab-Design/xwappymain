import 'package:clipboard/clipboard.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
// import 'package:xwappy/pages/auth/authcontroller.dart';
import 'package:xwappy/pages/home/homecontroller.dart';
import 'package:xwappy/pages/swapramp/swaprampcontroller.dart';
import 'package:xwappy/widgets/button.dart';
import 'package:xwappy/widgets/inputfield.dart';

import '../../constants.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final swappController = Get.put<SwapRampController>(
    SwapRampController(),
  );

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
            child: Obx(
              () {
                controller.refreshh.value;
                return SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/Group 2608876.png'),
                            const Spacer(),
                            // Button(
                            //   height: 40,
                            //   buttonWidth: 98,
                            //   padding: const EdgeInsets.symmetric(horizontal: 15),
                            //   textColor: const Color(0xffffffff),
                            //   color: const Color(0xffFE1531),
                            //   buttonText: "Logout",
                            //   onTap: () {
                            //     Navigator.of(context).pushNamedAndRemoveUntil(
                            //         '/', (route) => false);
                            //   },
                            // ),

                            DropdownButton(
                                underline: const SizedBox(),
                                borderRadius: BorderRadius.circular(13.6),
                                dropdownColor: const Color(0xffEEEEEE),
                                icon: const Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Color(0xff8A8A8A),
                                ),
                                items: const [
                                  // DropdownMenuItem(
                                  //   value: 'PR',
                                  //   child: Text(
                                  //     'Password Reset',
                                  //     style: TextStyle(
                                  //         color: Color(0xff626262),
                                  //         fontSize: 12.3),
                                  //   ),
                                  // ), //Logout
                                  DropdownMenuItem(
                                    value: 'Logout',
                                    child: Text(
                                      'Logout',
                                      style: TextStyle(
                                          color: Color(0xff626262),
                                          fontSize: 12.3),
                                    ),
                                  ), //Logout
                                ],
                                onChanged: (onChanged) {
                                  Constants.logger.d(onChanged);
                                  if (onChanged == "Logout") {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            '/', (route) => false);
                                  }
                                })
                          ],
                        ),
                        // const SizedBox(
                        //   height: 30,
                        // ),
                        // controller.pageState.value == PageState.home
                        //     ? const SizedBox()
                        //     : Text(
                        //         Constants.store.read('USERDATA')['user']
                        //             ['full_name'],
                        //         style: const TextStyle(
                        //           color: Color(0xffFFD600),
                        //           fontWeight: FontWeight.w700,
                        //           fontSize: 19,
                        //         ),
                        //       ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                Constants.store.read('USERDATA')['user']
                                        ['username'] ??
                                    "username",
                                style: const TextStyle(
                                  color: Color(0xffFFD600),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 19,
                                ),
                              ),
                            ),
                            // :
                            // Expanded(
                            //     child: RichText(
                            //         text: const TextSpan(
                            //             text: 'What do you\nwant to ',
                            //             style: TextStyle(
                            //               color: Color(0xffC5C5C5),
                            //               fontSize: 30,
                            //               fontWeight: FontWeight.w700,
                            //             ),
                            //             children: [
                            //           TextSpan(
                            //               text: 'swap?',
                            //               style: TextStyle(
                            //                 color: Color(0xffF1D643),
                            //                 fontSize: 30,
                            //                 fontWeight: FontWeight.w700,
                            //               ))
                            //         ])),
                            //   ),
                            const SizedBox(
                              width: 50,
                            ),
                            // GestureDetector(
                            //   behavior: HitTestBehavior.opaque,
                            //   onTap: () {
                            //     Get.toNamed('/records');
                            //   },
                            //   child: Column(
                            //     children: [
                            //       Image.asset('assets/images/Group 2608817.png'),
                            //       const SizedBox(
                            //         height: 5,
                            //       ),
                            //       const Text(
                            //         "Records",
                            //         style: TextStyle(
                            //           color: Color(0xffD8D8D8),
                            //           fontWeight: FontWeight.w600,
                            //           fontSize: 14,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ), //Ionicons.md_document_text_outline
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.pageState.value = PageState.home;
                              },
                              child: Container(
                                height: 53,
                                width: 53,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: controller.pageState.value ==
                                          PageState.home
                                      ? const Color(0xffF1D643)
                                      : const Color(0xffD9D9D9),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.home,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed('/records');
                              },
                              child: Container(
                                height: 53,
                                width: 53,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffD9D9D9),
                                ),
                                child: const Center(
                                  child:
                                      Icon(Ionicons.md_document_text_outline),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  controller.pageState.value =
                                      PageState.fiattocrypto;
                                },
                                child: Container(
                                  height: 50,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: controller.pageState.value ==
                                                  PageState.fiattocrypto ||
                                              controller.pageState.value ==
                                                  PageState.cryptotofiat
                                          ? const Color(0xffF1D643)
                                          : const Color(0xffD9D9D9),
                                      borderRadius: BorderRadius.circular(22)),
                                  child: const Center(
                                    child: Text(
                                      "Buy & Sell Crypto",
                                      style: TextStyle(
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed('/support');
                              },
                              child: Container(
                                height: 53,
                                width: 53,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffD9D9D9),
                                ),
                                child: const Center(
                                  child: Icon(MaterialIcons.support_agent),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (controller.pageState.value == PageState.home) ...[
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Overview",
                                style: TextStyle(
                                  color: Color(0xffC5C5C5),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                ),
                              ),
                              Button(
                                buttonWidth: 63,
                                height: 30,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                buttonText: 'Swap',
                                onTap: () {
                                  controller.pageState.value =
                                      PageState.fiattocrypto;
                                },
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 147,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: const Color(0xffffffff),
                                      borderRadius: BorderRadius.circular(22)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(2),
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xff000000),
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.arrow_upward,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                          const Icon(Icons.keyboard_arrow_right)
                                        ],
                                      ),
                                      const Spacer(),
                                      const Text(
                                        "Buy",
                                        style: TextStyle(
                                          color: Color(0xff000000),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
                                        ),
                                      ),
                                      const Spacer(),
                                      const Text(
                                        r"$2,000.32",
                                        style: TextStyle(
                                          color: Color(0xff000000),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17,
                                        ),
                                      ),
                                      const Spacer(),
                                      const Text(
                                        "203 txns",
                                        style: TextStyle(
                                          color: Color(0xff000000),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Container(
                                  height: 147,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: const Color(0xffffffff),
                                      borderRadius: BorderRadius.circular(22)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(2),
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xff000000),
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.arrow_downward,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                          const Icon(Icons.keyboard_arrow_right)
                                        ],
                                      ),
                                      const Spacer(),
                                      const Text(
                                        "Sell",
                                        style: TextStyle(
                                          color: Color(0xff000000),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
                                        ),
                                      ),
                                      const Spacer(),
                                      const Text(
                                        r"$2,000.32",
                                        style: TextStyle(
                                          color: Color(0xff000000),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17,
                                        ),
                                      ),
                                      const Spacer(),
                                      const Text(
                                        "2.403 txns",
                                        style: TextStyle(
                                          color: Color(0xff000000),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          const Text(
                            "Referral",
                            style: TextStyle(
                              color: Color(0xffC5C5C5),
                              fontWeight: FontWeight.w700,
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 160,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: const Color(0xffffffff),
                                      borderRadius: BorderRadius.circular(22)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Referral
                                      Row(
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(2),
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xff000000),
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.people,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const Text(
                                            "Referral",
                                            style: TextStyle(
                                              color: Color(0xff000000),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                            ),
                                          ),
                                          const Spacer(),
                                          const Text(
                                            "2,000",
                                            style: TextStyle(
                                              color: Color(0xff000000),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      const Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Total txns",
                                                style: TextStyle(
                                                  color: Color(0xff000000),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                r"$23,430.34",
                                                style: TextStyle(
                                                  color: Color(0xff000000),
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 17,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Active",
                                                style: TextStyle(
                                                  color: Color(0xff000000),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                "183",
                                                style: TextStyle(
                                                  color: Color(0xff000000),
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 17,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                      const Spacer(),

                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 160,
                                width: 100,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                decoration: BoxDecoration(
                                    color: const Color(0xffffffff),
                                    borderRadius: BorderRadius.circular(22)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        padding: const EdgeInsets.all(3),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff000000),
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.wallet,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    const Text(
                                      "Referral\nBalance",
                                      style: TextStyle(
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                      ),
                                    ),
                                    const Spacer(),
                                    const Text(
                                      r"$20.32  ",
                                      style: TextStyle(
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17,
                                      ),
                                    ),
                                    const Spacer(),
                                    Button(
                                      buttonWidth: 50,
                                      height: 30,
                                      radius: 10.2,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 1, vertical: 1),
                                      buttonText: "Cashout",
                                      textSize: 10,
                                      onTap: () => Get.toNamed("/cashout"),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text(
                            "Referral Link",
                            style: TextStyle(
                              color: Color(0xffC5C5C5),
                              fontWeight: FontWeight.w700,
                              fontSize: 13.24,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  // width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: const Color(0xffC5C5C5),
                                      )),
                                  child: Text(
                                    'https://${Constants.subDomain()}.xwapy.com/${Constants.store.read('USERDATA')['user']['username']}',
                                    style: const TextStyle(
                                      color: Color(0xffC5C5C5),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  FlutterClipboard.copy(
                                          'https://${Constants.subDomain()}.xwapy.com/${Constants.store.read('USERDATA')['user']['username']}'
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
                                      fontSize: 16.0);
                                },
                                icon: const Icon(
                                  Icons.copy,
                                  color: Color(0xffC5C5C5),
                                ),
                              ),
                            ],
                          )
                        ],
                        if (controller.pageState.value ==
                            PageState.fiattocrypto) ...[
                          Row(
                            children: [
                              const Text(
                                "Buy",
                                style: TextStyle(
                                  color: Color(0xffC5C5C5),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  controller.pageState.value =
                                      PageState.cryptotofiat;
                                },
                                child: Container(
                                  height: 32,
                                  width: 86,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 13, vertical: 2),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xffffffff),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: const Row(
                                    children: [
                                      Icon(
                                        MaterialIcons.swap_horiz,
                                        color: Color(0xffffffff),
                                      ),
                                      Spacer(),
                                      Text(
                                        "Sell",
                                        style: TextStyle(
                                          color: Color(0xffffffff),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "From Fiat",
                                      style: TextStyle(
                                        color: Color(0xffD8D8D8),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      width: MediaQuery.of(context).size.width /
                                          2.6,
                                      decoration: BoxDecoration(
                                        color: const Color(0xff2A2A2A),
                                        border: Border.all(
                                            width: 0.5,
                                            color: const Color(0xFfC3C7E5)),
                                        borderRadius:
                                            BorderRadius.circular(8.1),
                                      ),
                                      child: DropdownButton(
                                          underline: const SizedBox(),
                                          isExpanded: true,
                                          icon: const Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Color(0xff6F6F6F),
                                            ),
                                          ),
                                          hint: Row(
                                            children: [
                                              Image.asset(
                                                'assets/images/image 186.png',
                                                width: 23,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              const Text(
                                                "NGN",
                                                style: TextStyle(
                                                  color: Color(0xffA7A7A7),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                          value: controller
                                              .nairaValueConvert.value,
                                          onChanged: (v) {
                                            controller.nairaValueConvert.value =
                                                v;
                                          },
                                          items: Constants.store.read(
                                                      'SupportedAssets') ==
                                                  null
                                              ? null
                                              : Constants.store
                                                  .read('SupportedAssets')[
                                                      'countries']
                                                  .map<
                                                      DropdownMenuItem<
                                                          String>>((e) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: e['currency'],
                                                    child: Text(
                                                      e['currency'],
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xffA7A7A7),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  );
                                                }).toList()),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "To stablecoin",
                                      style: TextStyle(
                                        color: Color(0xffD8D8D8),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: const Color(0xff2A2A2A),
                                        border: Border.all(
                                            width: 0.5,
                                            color: const Color(0xFfC3C7E5)),
                                        borderRadius:
                                            BorderRadius.circular(8.1),
                                      ),
                                      child: DropdownButton(
                                          icon: const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Color(0xff6F6F6F),
                                          ),
                                          isExpanded: true,
                                          hint: Row(
                                            children: [
                                              Image.asset(
                                                'assets/images/image 219.png',
                                                // 'assets/images/emojione_flag-for-nigeria.png',
                                                width: 23,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                "USDT - TRC20",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Color(0xffA7A7A7),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          underline: const SizedBox(),
                                          onChanged: (v) {
                                            controller
                                                .cryptoValueConvert.value = v;
                                          },
                                          value: controller
                                              .cryptoValueConvert.value,
                                          items: Constants.store
                                              .read('SupportedAssets')['coins']
                                              ?.map<DropdownMenuItem<String>>(
                                                  (e) {
                                            return DropdownMenuItem<String>(
                                              value: e.toString(),
                                              child: Text(
                                                e.toString(),
                                                style: const TextStyle(
                                                  color: Color(0xffA7A7A7),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            );
                                          }).toList()),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Amount",
                            style: TextStyle(
                              color: Color(0xffD8D8D8),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextInputField(
                            hintText: "amount",
                            filledColor: const Color(0xff2A2A2A),
                            controller: controller.amountController,
                            onChanged: (v) {
                              controller.refreshh.toggle();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an amount';
                              }

                              return null;
                            },
                            inputFormatters: [
                              CurrencyTextInputFormatter.currency(
                                  symbol: '', decimalDigits: 0)
                            ],
                            prefixIcon: SizedBox(
                              height: 50,
                              width: 55,
                              child: Center(
                                child: Text(
                                  controller.nairaValueConvert.value ?? "NGN",
                                  style: const TextStyle(
                                    color: Color(0xffA7A7A7),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            radius: 8.21,
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          if (controller.amountController.text.isNotEmpty) ...[
                            Row(
                              children: [
                                Container(
                                    width: 18,
                                    height: 18,
                                    // padding: const EdgeInsets.only(bottom: 10),
                                    decoration: const BoxDecoration(
                                        color: Color(0xff6F6F6F),
                                        shape: BoxShape.circle),
                                    child: Center(
                                      child: Container(
                                        height: 2,
                                        width: 10,
                                        color: const Color(0xffD8D8D8),
                                      ),
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "Our Fee",
                                  style: TextStyle(
                                    color: Color(0xffD8D8D8),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  "\$ ${Constants.store.read('USERDATA')['fee']} (${controller.nairaValueConvert.value == null ? 'NGN 0' : '${controller.nairaValueConvert.value!}0'})",
                                  style: const TextStyle(
                                    color: Color(0xffFA7C07),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "We charge a flat fee of \$${Constants.store.read('USERDATA')['fee']} irrespective of the amount you are sending",
                              style: const TextStyle(
                                color: Color(0xffD8D8D8),
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  AntDesign.swap,
                                  color: Color(0xffD8D8D8),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "Exchange Rate",
                                  style: TextStyle(
                                    color: Color(0xffD8D8D8),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  "${controller.nairaValueConvert.value == null ? 'NGN ${Constants.sortByUsdStart('ngn').entries.first.value[1]}' : '${controller.nairaValueConvert.value} ${Constants.sortByUsdStart(controller.nairaValueConvert.value.toString().toLowerCase()).entries.first.value[1]}'} = 1 USDT",
                                  style: const TextStyle(
                                    color: Color(0xffD8D8D8),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Rate varies depending on exchange rate at time of transaction.",
                              style: TextStyle(
                                color: Color(0xffD8D8D8),
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            const Center(
                              child: Text(
                                "You’ll get",
                                style: TextStyle(
                                  color: Color(0xffD8D8D8),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: Text(
                                controller.amountController.text.isEmpty
                                    ? "\$0"
                                    : controller.nairaValueConvert.value == null
                                        ? r'$'
                                            '${Constants.moneyFormat(double.parse(controller.amountController.text.split(',').join()) / double.parse(Constants.sortByUsdStart('ngn').entries.first.value[1].toString()))}'
                                        : '\$${Constants.moneyFormat(double.parse(controller.amountController.text.split(',').join()) / double.parse(Constants.sortByUsdStart(controller.nairaValueConvert.value.toString().toLowerCase()).entries.first.value[1].toString()))}',
                                style: const TextStyle(
                                  color: Color(0xffC5C5C5),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 28,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Button(
                              buttonWidth: MediaQuery.sizeOf(context).width,
                              buttonText: "Buy",
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  return Get.toNamed('/enteraddresscrypto',
                                      arguments: {
                                        "from":
                                            controller.nairaValueConvert.value,
                                        "to":
                                            controller.cryptoValueConvert.value,
                                        "amount":
                                            controller.amountController.text,
                                      });
                                }
                              },
                            ),
                          ],
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                        if (controller.pageState.value ==
                            PageState.cryptotofiat) ...[
                          Row(
                            children: [
                              const Text(
                                "Sell",
                                style: TextStyle(
                                  color: Color(0xffC5C5C5),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  controller.pageState.value =
                                      PageState.fiattocrypto;
                                },
                                child: Container(
                                  height: 32,
                                  width: 86,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 13, vertical: 2),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xffffffff),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: const Row(
                                    children: [
                                      Icon(
                                        MaterialIcons.swap_horiz,
                                        color: Color(0xffffffff),
                                      ),
                                      Spacer(),
                                      Text(
                                        "Buy",
                                        style: TextStyle(
                                          color: Color(0xffffffff),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "From stablecoin",
                                      style: TextStyle(
                                        color: Color(0xffD8D8D8),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 48,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      width: MediaQuery.of(context).size.width /
                                          2.4,
                                      decoration: BoxDecoration(
                                        color: const Color(0xff2A2A2A),
                                        border: Border.all(
                                            width: 0.5,
                                            color: const Color(0xFfC3C7E5)),
                                        borderRadius:
                                            BorderRadius.circular(8.1),
                                      ),
                                      child: DropdownButton(
                                          isExpanded: true,
                                          icon: const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Color(0xff6F6F6F),
                                          ),
                                          hint: Row(
                                            children: [
                                              Image.asset(
                                                'assets/images/image 219.png',
                                                // 'assets/images/emojione_flag-for-nigeria.png',
                                                width: 23,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                "USDT - TRC20",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Color(0xffA7A7A7),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          underline: const SizedBox(),
                                          onChanged: (v) {
                                            controller
                                                .cryptoValueConvert.value = v;
                                          },
                                          value: controller
                                              .cryptoValueConvert.value,
                                          items: Constants.store
                                              .read('SupportedAssets')['coins']
                                              ?.map<DropdownMenuItem<String>>(
                                                  (e) {
                                            return DropdownMenuItem<String>(
                                              value: e.toString(),
                                              child: Text(
                                                e.toString(),
                                                style: const TextStyle(
                                                  color: Color(0xffA7A7A7),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            );
                                          }).toList()),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "To Fiat",
                                      style: TextStyle(
                                        color: Color(0xffD8D8D8),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      width: MediaQuery.of(context).size.width /
                                          2.6,
                                      decoration: BoxDecoration(
                                        color: const Color(0xff2A2A2A),
                                        border: Border.all(
                                            width: 0.5,
                                            color: const Color(0xFfC3C7E5)),
                                        borderRadius:
                                            BorderRadius.circular(8.1),
                                      ),
                                      child: DropdownButton(
                                          isExpanded: true,
                                          underline: const SizedBox(),
                                          icon: const Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Color(0xff6F6F6F),
                                            ),
                                          ),
                                          hint: Row(
                                            children: [
                                              Image.asset(
                                                'assets/images/image 186.png',
                                                width: 23,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              const Text(
                                                "NGN",
                                                style: TextStyle(
                                                  color: Color(0xffA7A7A7),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                          value: controller
                                              .nairaValueConvert.value,
                                          onChanged: (v) {
                                            controller.nairaValueConvert.value =
                                                v;
                                          },
                                          items: Constants.store.read(
                                                      'SupportedAssets') ==
                                                  null
                                              ? null
                                              : Constants.store
                                                  .read('SupportedAssets')[
                                                      'countries']
                                                  .map<
                                                      DropdownMenuItem<
                                                          String>>((e) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: e['currency'],
                                                    child: Text(
                                                      e['currency'],
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xffA7A7A7),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  );
                                                }).toList()),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Amount",
                            style: TextStyle(
                              color: Color(0xffD8D8D8),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextInputField(
                            hintText: "amount",
                            filledColor: const Color(0xff2A2A2A),
                            controller: controller.amountController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an amount';
                              }

                              return null;
                            },
                            inputFormatters: [
                              CurrencyTextInputFormatter.currency(
                                  symbol: '', decimalDigits: 0)
                            ],
                            onChanged: (v) {
                              controller.refreshh.toggle();
                            },
                            prefixIcon: const SizedBox(
                              height: 50,
                              width: 40,
                              child: Center(
                                child: Text(
                                  "\$",
                                  style: TextStyle(
                                    color: Color(0xffA7A7A7),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            radius: 8.21,
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          if (controller.amountController.text.isNotEmpty) ...[
                            Row(
                              children: [
                                Container(
                                    width: 18,
                                    height: 18,
                                    // padding: const EdgeInsets.only(bottom: 10),
                                    decoration: const BoxDecoration(
                                        color: Color(0xff6F6F6F),
                                        shape: BoxShape.circle),
                                    child: Center(
                                      child: Container(
                                        height: 2,
                                        width: 10,
                                        color: const Color(0xffD8D8D8),
                                      ),
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "Our Fee",
                                  style: TextStyle(
                                    color: Color(0xffD8D8D8),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  "\$ ${Constants.store.read('USERDATA')['fee']} (${controller.nairaValueConvert.value == null ? 'NGN 0' : '${controller.nairaValueConvert.value!}0'})",
                                  style: const TextStyle(
                                    color: Color(0xffFA7C07),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "We charge a flat fee of \$${Constants.store.read('USERDATA')['fee']} irrespective of the amount you are sending",
                              style: const TextStyle(
                                color: Color(0xffD8D8D8),
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  AntDesign.swap,
                                  color: Color(0xffD8D8D8),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "Exchange Rate",
                                  style: TextStyle(
                                    color: Color(0xffD8D8D8),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  "${controller.nairaValueConvert.value == null ? 'NGN ${Constants.sortByUsdEnd('ngn').entries.first.value[1]}' : '${controller.nairaValueConvert.value} ${Constants.sortByUsdEnd(controller.nairaValueConvert.value.toString().toLowerCase()).entries.first.value[1]}'} = 1 USDT",
                                  style: const TextStyle(
                                    color: Color(0xffD8D8D8),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Rate varies depending on exchange rate at time of transaction.",
                              style: TextStyle(
                                color: Color(0xffD8D8D8),
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            const Center(
                              child: Text(
                                "You’ll get",
                                style: TextStyle(
                                  color: Color(0xffD8D8D8),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: Text(
                                controller.amountController.text.isEmpty
                                    ? controller.nairaValueConvert.value == null
                                        ? 'NGN0'
                                        : '${controller.nairaValueConvert.value}0'
                                    : controller.nairaValueConvert.value == null
                                        ? 'NGN'
                                            '${Constants.moneyFormat(double.parse(controller.amountController.text.split(',').join()) * Constants.sortByUsdEnd('ngn').entries.first.value[1])}'
                                        : '${controller.nairaValueConvert.value!} ${Constants.moneyFormat(double.parse(controller.amountController.text.split(',').join()) * Constants.sortByUsdEnd(controller.nairaValueConvert.value.toString().toLowerCase()).entries.first.value[1])}',
                                style: const TextStyle(
                                  color: Color(0xffC5C5C5),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 28,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Obx(
                              () => Button(
                                buttonWidth: MediaQuery.sizeOf(context).width,
                                buttonText: "Sell",
                                isLoading: swappController.isLoading.value,
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    swappController.isLoading.value = true;
                                    swappController
                                        .createCryptoToFiatOrder(
                                            from: controller
                                                .cryptoValueConvert.value
                                                .toString()
                                                .split('-')
                                                .first, 
                                            to: controller
                                                .nairaValueConvert.value
                                                .toString(),
                                            network: controller
                                                .cryptoValueConvert.value
                                                .toString()
                                                .toLowerCase(),
                                            amount: controller
                                                .amountController.text)
                                        .then((value) {
                                      swappController.isLoading.value = false;
                                      if (value == true) {
                                        return Get.toNamed('/makepaymentcrypto',
                                            arguments: {
                                              "from": controller
                                                  .cryptoValueConvert.value,
                                              "to": controller.nairaValueConvert
                                                      .value ??
                                                  "NGN",
                                              "amount": controller
                                                  .amountController.text,
                                            });
                                      }
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          )),
    );
  }
}

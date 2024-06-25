import 'package:clipboard/clipboard.dart';
import 'package:country_data/country_data.dart';
import 'package:country_flags/country_flags.dart';
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
import '../auth/authcontroller.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({super.key}) {
    Get.lazyPut(() => HomeController());
    controller.getUserData();
    // authController.getDesign();
  }

  final formKey = GlobalKey<FormState>();
  final swappController = Get.put<SwapRampController>(
    SwapRampController(),
  );

  final authController = Get.put<AuthController>(
    AuthController(),
  );

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeController());
    return Scaffold(
      backgroundColor: Constants.bkgColor(),
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
                            Image.network(
                              Constants.appLogo(),
                              width: 92,
                              height: 41,
                              fit: BoxFit.fill,
                            ), //Group 2608876
                            const Spacer(),
                            DropdownButton(
                                underline: const SizedBox(),
                                borderRadius: BorderRadius.circular(13.6),
                                dropdownColor: const Color(0xffEEEEEE),
                                icon: Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Constants.txtColor(),
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
                                onChanged: (onChanged) async {
                                  Constants.logger.d(onChanged);
                                  if (onChanged == "Logout") {
                                    Get.dialog(const LogOutClass());
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
                                            ['full_name'] !=
                                        null
                                    ? "Hi, ${Constants.capitalizeText(inputText: Constants.store.read('USERDATA')['user']['full_name'].toString().split(' ').first)}"
                                    : "Firstname",
                                style: TextStyle(
                                  color: Constants.txtColor(),
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
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.pageState.value = PageState.home;
                                },
                                child: Container(
                                  height: 44,
                                  width: 44,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: controller.pageState.value ==
                                            PageState.home
                                        ? Constants.activeHeaderColor()
                                        : Constants.headerColor(),
                                  ),
                                  child: Center(
                                      child: Image.asset(
                                    'assets/images/homee.png',
                                    color: Constants.bkgColor(),
                                    height: 17,
                                    width: 17,
                                  )),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.pageState.value =
                                      PageState.fiattocrypto;
                                },
                                child: Container(
                                  height: 41,
                                  width: 82,
                                  decoration: BoxDecoration(
                                      color: controller.pageState.value ==
                                                  PageState.fiattocrypto ||
                                              controller.pageState.value ==
                                                  PageState.cryptotofiat
                                          ? Constants.activeHeaderColor()
                                          : Constants.headerColor(),
                                      borderRadius: BorderRadius.circular(22)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/swap.png',
                                        height: 16,
                                        width: 16,
                                        fit: BoxFit.fill,
                                        color: Constants.bkgColor(),
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        'Swap',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Constants.bkgColor(),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.pageState.value = PageState.cards;
                                },
                                child: Container(
                                  height: 41,
                                  width: 92,
                                  decoration: BoxDecoration(
                                    // shape: BoxShape.circle,
                                    borderRadius: BorderRadius.circular(22),
                                    color: controller.pageState.value ==
                                            PageState.cards
                                        ? Constants.activeHeaderColor()
                                        : Constants.headerColor(),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/card.png',
                                        height: 16,
                                        width: 16,
                                        fit: BoxFit.fill,
                                        color: Constants.bkgColor(),
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        'Card',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Constants.bkgColor(),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.pageState.value = PageState.sends;
                                },
                                child: Container(
                                  height: 41,
                                  width: 82,
                                  decoration: BoxDecoration(
                                      color: controller.pageState.value ==
                                              PageState.sends
                                          ? Constants.activeHeaderColor()
                                          : Constants.headerColor(),
                                      borderRadius: BorderRadius.circular(22)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/export.png',
                                        height: 16,
                                        width: 16,
                                        fit: BoxFit.fill,
                                        color: Constants.bkgColor(),
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        'Sends',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Constants.bkgColor(),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.pageState.value = PageState.refer;
                                },
                                child: Container(
                                  height: 41,
                                  width: 92,
                                  decoration: BoxDecoration(
                                    // shape: BoxShape.circle,
                                    borderRadius: BorderRadius.circular(22),
                                    color: controller.pageState.value ==
                                            PageState.refer
                                        ? Constants.activeHeaderColor()
                                        : Constants.headerColor(),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/people.png',
                                        height: 16,
                                        width: 16,
                                        fit: BoxFit.fill,
                                        color: Constants.bkgColor(),
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        'Refer',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Constants.bkgColor(),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (controller.pageState.value == PageState.home) ...[
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.sizeOf(context).width,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 7),
                            decoration: BoxDecoration(
                                color: Constants.boxColor2(),
                                borderRadius: BorderRadius.circular(23)),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 15,
                                  child: Image.asset(
                                    'assets/images/user.png',
                                    height: 30,
                                    width: 30,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Registered Name",
                                      style: TextStyle(
                                        color: Constants.boxColor1(),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 1.5,
                                    ),
                                    Text(
                                      Constants.store.read('USERDATA')['user']
                                                  ['full_name'] !=
                                              null
                                          ? Constants.store
                                              .read('USERDATA')['user']
                                                  ['full_name']
                                              .toString()
                                          : '',
                                      style: TextStyle(
                                        color: Constants.boxColor1(),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Text(
                                  "KYC",
                                  style: TextStyle(
                                    color: Constants.boxColor1(),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 7),
                                  decoration: BoxDecoration(
                                      color: const Color(0xffE3F5D3),
                                      borderRadius: BorderRadius.circular(23)),
                                  child: const Text('Active'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'On “Buy Order”, only pay from a bank account with the same name registered (${Constants.store.read('USERDATA')['user']['full_name'] != null ? Constants.store.read('USERDATA')['user']['full_name'].toString() : ''}). Want to correct account name? Contact Support.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Constants.txtColor(),
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Quicklinks",
                                style: TextStyle(
                                  color: Constants.txtColor(),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    controller.pageState.value =
                                        PageState.fiattocrypto;
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/swapwhite.png',
                                        height: 31,
                                        width: 31,
                                        fit: BoxFit.fill,
                                        color: Constants.txtColor(),
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        "Swap",
                                        style: TextStyle(
                                          color: Constants.txtColor(),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    controller.pageState.value =
                                        PageState.cards;
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/cardwhite.png',
                                        height: 31,
                                        width: 31,
                                        fit: BoxFit.fill,
                                        color: Constants.txtColor(),
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        "Card",
                                        style: TextStyle(
                                          color: Constants.txtColor(),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    controller.pageState.value =
                                        PageState.sends;
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/sendwhite.png',
                                        height: 31,
                                        width: 31,
                                        fit: BoxFit.fill,
                                        color: Constants.txtColor(),
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        "Send",
                                        style: TextStyle(
                                          color: Constants.txtColor(),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed('/records');
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/recordswhite.png',
                                        height: 31,
                                        width: 31,
                                        fit: BoxFit.fill,
                                        color: Constants.txtColor(),
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        "Records",
                                        style: TextStyle(
                                          color: Constants.txtColor(),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed('/support');
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/chatwhite.png',
                                        height: 31,
                                        width: 31,
                                        fit: BoxFit.fill,
                                        color: Constants.txtColor(),
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        "Support",
                                        style: TextStyle(
                                          color: Constants.txtColor(),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    controller.pageState.value =
                                        PageState.refer;
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/peoplewhite.png',
                                        height: 31,
                                        width: 31,
                                        fit: BoxFit.fill,
                                        color: Constants.txtColor(),
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        "Referral",
                                        style: TextStyle(
                                          color: Constants.txtColor(),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Overview",
                                style: TextStyle(
                                  color: Constants.txtColor(),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                ),
                              ),
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
                                      color: Constants.boxColor2(),
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
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Constants.boxColor1(),
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.arrow_upward,
                                                color: Constants.boxColor2(),
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                Get.toNamed('/records',
                                                    arguments: 'Buy');
                                              },
                                              child: Icon(
                                                Icons.keyboard_arrow_right,
                                                color: Constants.boxColor1(),
                                              ))
                                        ],
                                      ),
                                      const Spacer(),
                                      Text(
                                        "Buy",
                                        style: TextStyle(
                                          color: Constants.boxColor1(),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "\$${Constants.store.read('USERDATA')['buy']['total_amount'].toString()}",
                                        style: TextStyle(
                                          color: Constants.boxColor1(),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "${Constants.store.read('USERDATA')['buy']['total_txn'].toString()} txns",
                                        style: TextStyle(
                                          color: Constants.boxColor1(),
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
                                      color: Constants.boxColor2(),
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
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Constants.boxColor1(),
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.arrow_downward,
                                                color: Constants.boxColor2(),
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                Get.toNamed('/records',
                                                    arguments: 'Sell');
                                              },
                                              child: Icon(
                                                Icons.keyboard_arrow_right,
                                                color: Constants.boxColor1(),
                                              ))
                                        ],
                                      ),
                                      const Spacer(),
                                      Text(
                                        "Sell",
                                        style: TextStyle(
                                          color: Constants.boxColor1(),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "\$${Constants.store.read('USERDATA')['sell']['total_amount'].toString()}",
                                        style: TextStyle(
                                          color: Constants.boxColor1(),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "${Constants.store.read('USERDATA')['sell']['total_txn'].toString()} txns",
                                        style: TextStyle(
                                          color: Constants.boxColor1(),
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
                        ],

                        if (controller.pageState.value == PageState.cards) ...[
                          Row(
                            children: [
                              Text(
                                "Virtual Card",
                                style: TextStyle(
                                  color: Constants.txtColor(),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(children: [
                            Expanded(
                              child: Container(
                                height: 180,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 15),
                                decoration: BoxDecoration(
                                    color: const Color(0xffffffff),
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                          Constants.subdomain == "zapit"
                                              ? 'assets/images/zapitcard.png'
                                              : 'assets/images/debitcard.png',
                                        )),
                                    borderRadius: BorderRadius.circular(22)),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      Constants.subdomain == "zapit"
                                          ? "assets/images/favicon.png"
                                          : "assets/images/logo.png",
                                      height: 23,
                                      width: 23,
                                    ),
                                    // Spacer(),
                                    Text(
                                      "VIRTUAL **** CARD",
                                      style: TextStyle(
                                        color: Constants.boxColor1(),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 22,
                                      ),
                                    ),
                                    // Spacer(),
                                    Row(
                                      children: [
                                        Text(
                                          "\$0.0",
                                          style: TextStyle(
                                            color: Constants.boxColor1(),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 17,
                                          ),
                                        ),
                                        const Spacer(),
                                        Image.asset(
                                            "assets/images/mastercard.png")
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                          const SizedBox(
                            height: 50,
                          ),
                          Center(
                            child: Container(
                              width: 82,
                              height: 41,
                              decoration: BoxDecoration(
                                  color: const Color(0xffFF0000),
                                  borderRadius: BorderRadius.circular(22)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/arrowdown.png'),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text(
                                    "Soon!",
                                    style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: Text(
                              "Virtual cards for online and ecommerce\npayment coming soon!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Constants.txtColor(),
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                        if (controller.pageState.value == PageState.sends) ...[
                          const SizedBox(
                            height: 50,
                          ),
                          Center(
                            child: Image.asset(
                              'assets/images/globesend.png',
                              // height: 220.22,
                              // width: 273,
                              fit: BoxFit.fill,
                              // color: const Color(0xffffffff),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Center(
                            child: Container(
                              width: 82,
                              height: 41,
                              decoration: BoxDecoration(
                                  color: const Color(0xffFF0000),
                                  borderRadius: BorderRadius.circular(22)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/export.png',
                                    height: 15,
                                    width: 15,
                                    color: const Color(0xffffffff),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text(
                                    "Soon!",
                                    style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: Text(
                              "Send money to different countries in real-time.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Constants.txtColor(),
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],

                        if (controller.pageState.value == PageState.refer) ...[
                          Text(
                            "Referral Link",
                            style: TextStyle(
                              color: Constants.txtColor(),
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
                                          color: const Color(0xff1B1B1B))),
                                  child: Text(
                                    '${Constants.getUrl()}?ref=${Constants.store.read('USERDATA')['user']['username']}'
                                        .toString()
                                        .split('#/home')
                                        .join(),
                                    style: TextStyle(
                                      color: Constants.txtColor(),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  FlutterClipboard.copy(
                                          '${Constants.getUrl()}/?ref=${Constants.store.read('USERDATA')['user']['username']}'
                                              .toString()
                                              .split('#/home')
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
                                icon: Icon(
                                  Icons.copy,
                                  color: Constants.txtColor(),
                                  size: 15,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Text(
                            "Referral",
                            style: TextStyle(
                              color: Constants.txtColor(),
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
                                      color: Constants.boxColor2(),
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
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Constants.boxColor1(),
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
                                          Text(
                                            "Referral",
                                            style: TextStyle(
                                              color: Constants.boxColor1(),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            Constants.store
                                                .read('USERDATA')['referral']
                                                    ['total']
                                                .toString(),
                                            style: TextStyle(
                                              color: Constants.boxColor1(),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Total txns",
                                                style: TextStyle(
                                                  color: Constants.boxColor1(),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                Constants.store
                                                    .read('USERDATA')[
                                                        'referral']
                                                        ['total_txn_amount']
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Constants.boxColor1(),
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 17,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Active",
                                                style: TextStyle(
                                                  color: Constants.boxColor1(),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                Constants.store
                                                    .read('USERDATA')[
                                                        'referral']['active']
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Constants.boxColor1(),
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 17,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
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
                                    color: Constants.boxColor2(),
                                    borderRadius: BorderRadius.circular(22)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        padding: const EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Constants.boxColor1(),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.wallet,
                                            color: Constants.boxColor2(),
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      "Referral\nBalance",
                                      style: TextStyle(
                                        color: Constants.boxColor1(),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '\$0',
                                      style: TextStyle(
                                        color: Constants.boxColor1(),
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
                        ],
                        if (controller.pageState.value ==
                            PageState.fiattocrypto) ...[
                          Row(
                            children: [
                              Text(
                                "Buy",
                                style: TextStyle(
                                  color: Constants.txtColor(),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  if (swappController.sellRate.value == null) {
                                    swappController.exchangeRateSell(
                                        baseSell:
                                            controller.cryptoValueConvert.value,
                                        asset:
                                            controller.nairaValueConvert.value);
                                  }
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
                                        color: Constants.txtColor()!,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(22)),
                                  child: Row(
                                    children: [
                                      Icon(
                                        MaterialIcons.swap_horiz,
                                        color: Constants.txtColor()!,
                                      ),
                                      const Spacer(),
                                      Text(
                                        "Sell",
                                        style: TextStyle(
                                          color: Constants.txtColor(),
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
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "From Fiat",
                                      style: TextStyle(
                                        color: Constants.txtColor(),
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
                                              Text(
                                                "NGN",
                                                style: TextStyle(
                                                  color: Constants.txtColor(),
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

                                            swappController.exchangeRateBuy(
                                                baseBuy: controller
                                                    .cryptoValueConvert.value,
                                                asset: v);
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
                                                  List<Country> countries =
                                                      CountryData()
                                                          .getCountries();
                                                  final Country country =
                                                      countries.firstWhere(
                                                    (country) =>
                                                        country.name
                                                                .toLowerCase() ==
                                                            e['name']
                                                                .toString()
                                                                .toLowerCase() ||
                                                        country.currencyCode
                                                                .toLowerCase() ==
                                                            e['currency']
                                                                .toString()
                                                                .toLowerCase(),
                                                  );

                                                  // return country.countryCode;

                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: e['currency'],
                                                    child: Row(
                                                      children: [
                                                        CountryFlag
                                                            .fromCountryCode(
                                                          country.id,
                                                          height: 30,
                                                          width: 30,
                                                          borderRadius: 30,
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          e['currency'],
                                                          style:
                                                              const TextStyle(
                                                            color: Color(
                                                                0xffA7A7A7),
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }).toList()),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "To stablecoin",
                                      style: TextStyle(
                                        color: Constants.txtColor(),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 50,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: const Color(0xff2A2A2A),
                                        border: Border.all(
                                          width: 0.5,
                                          color: Constants.txtColor()!,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.1),
                                      ),
                                      child: DropdownButton(
                                          icon: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Constants.txtColor(),
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
                                              Text(
                                                "USDT - TRC20",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Constants.txtColor(),
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

                                            swappController.exchangeRateBuy(
                                                baseBuy: v,
                                                asset: controller
                                                    .nairaValueConvert.value);
                                          },
                                          value: controller
                                              .cryptoValueConvert.value,
                                          items: Constants.store
                                              .read('SupportedAssets')['coins']
                                              ?.map<DropdownMenuItem<String>>(
                                                  (e) {
                                            return DropdownMenuItem<String>(
                                              value: e.toString(),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    e.toString() == "USDT-TRC20"
                                                        ? 'assets/images/image 219.png'
                                                        : 'assets/images/emojione_flag-for-nigeria.png',
                                                    width: 23,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    e.toString(),
                                                    style: const TextStyle(
                                                      color: Color(0xffA7A7A7),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
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
                          Text(
                            "Amount",
                            style: TextStyle(
                              color: Constants.txtColor(),
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
                              if (swappController.buyRate.value == null) {
                                swappController.exchangeRateBuy(
                                    baseBuy:
                                        controller.cryptoValueConvert.value,
                                    asset: controller.nairaValueConvert.value);
                              }
                              controller.refreshh.toggle();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an amount';
                              } else if (swappController.buyRate.value ==
                                  null) {
                                return 'Please wait till the amount is calculated';
                              } else if (double.parse(value.split(',').join()) /
                                      double.parse(swappController.buyRate.value
                                          .toString()) <
                                  10) {
                                return 'Minimum buy is \$10';
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
                                  style: TextStyle(
                                    color: Constants.txtColor(),
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
                                Text(
                                  "Our Fee",
                                  style: TextStyle(
                                    color: Constants.txtColor(),
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
                              style: TextStyle(
                                color: Constants.txtColor(),
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            Row(
                              children: [
                                Icon(
                                  AntDesign.swap,
                                  color: Constants.txtColor(),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Exchange Rate",
                                  style: TextStyle(
                                    color: Constants.txtColor(),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                const Spacer(),
                                swappController.buyRate.value == null
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator())
                                    : Text(
                                        '${controller.nairaValueConvert.value == null ? "NGN ${swappController.buyRate.value ?? "calculating"}" : "${controller.nairaValueConvert.value} ${swappController.buyRate.value ?? "calculating"}"} = 1 USDT',
                                        // "${controller.nairaValueConvert.value == null ? 'NGN ${Constants.sortByUsdStart('ngn').entries.first.value[1]}' : '${controller.nairaValueConvert.value} ${Constants.sortByUsdStart(controller.nairaValueConvert.value.toString().toLowerCase()).entries.first.value[1]}'} = 1 USDT",
                                        style: TextStyle(
                                          color: Constants.txtColor(),
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
                              "Rate varies depending on exchange rate at time of transaction.",
                              style: TextStyle(
                                color: Constants.txtColor(),
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Center(
                              child: Text(
                                "You’ll get",
                                style: TextStyle(
                                  color: Constants.txtColor(),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: swappController.buyRate.value == null
                                  ? const CircularProgressIndicator()
                                  : Text(
                                      controller.amountController.text.isEmpty
                                          ? "\$0"
                                          : controller.nairaValueConvert
                                                      .value ==
                                                  null
                                              ? r'$'
                                                  '${Constants.moneyFormat(double.parse(controller.amountController.text.split(',').join()) / double.parse(swappController.buyRate.value.toString()))}'
                                              : '\$${Constants.moneyFormat(double.parse(controller.amountController.text.split(',').join()) / double.parse(swappController.buyRate.value.toString()))}',
                                      style: TextStyle(
                                        color: Constants.txtColor(),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 28,
                                      ),
                                    ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            //  if (swappController.buyRate.value ==
                            //       null) {
                            //     return 'Please wait till the amount is calculated';
                            //   } else if (double.parse(value.split(',').join()) /
                            //           double.parse(swappController.buyRate.value
                            //               .toString()) <
                            //       10) {
                            //     return 'Minimum buy is \$10';
                            //   }
                            Button(
                              buttonWidth: MediaQuery.sizeOf(context).width,
                              buttonText: "Buy",
                              color: swappController.buyRate.value == null ||
                                      (double.parse(controller
                                                  .amountController.text
                                                  .split(',')
                                                  .join()) /
                                              double.parse(swappController
                                                  .buyRate.value
                                                  .toString())) <
                                          10
                                  ? Colors.grey
                                  : null,
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
                              Text(
                                "Sell",
                                style: TextStyle(
                                  color: Constants.txtColor(),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  if (swappController.buyRate.value == null) {
                                    swappController.exchangeRateBuy(
                                        baseBuy:
                                            controller.cryptoValueConvert.value,
                                        asset:
                                            controller.nairaValueConvert.value);
                                  }

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
                                        color: Constants.txtColor()!,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(22)),
                                  child: Row(
                                    children: [
                                      Icon(
                                        MaterialIcons.swap_horiz,
                                        color: Constants.txtColor(),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "Buy",
                                        style: TextStyle(
                                          color: Constants.txtColor(),
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
                                    Text(
                                      "From stablecoin",
                                      style: TextStyle(
                                        color: Constants.txtColor(),
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
                                          icon: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Constants.txtColor(),
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
                                              Text(
                                                "USDT - TRC20",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Constants.txtColor(),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          underline: const SizedBox(),
                                          onChanged: (v) {
                                            swappController.exchangeRateSell(
                                                baseSell: controller
                                                    .cryptoValueConvert.value,
                                                asset: v);
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
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    e.toString() == "USDT-TRC20"
                                                        ? 'assets/images/image 219.png'
                                                        : 'assets/images/emojione_flag-for-nigeria.png',
                                                    width: 23,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    e.toString(),
                                                    style: const TextStyle(
                                                      color: Color(0xffA7A7A7),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }).toList()),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "To Fiat",
                                      style: TextStyle(
                                        color: Constants.txtColor(),
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
                                      decoration: BoxDecoration(
                                        color: const Color(0xff2A2A2A),
                                        border: Border.all(
                                            width: 0.5,
                                            color: Constants.txtColor()!),
                                        borderRadius:
                                            BorderRadius.circular(8.1),
                                      ),
                                      child: DropdownButton(
                                          isExpanded: true,
                                          underline: const SizedBox(),
                                          icon: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Constants.txtColor(),
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
                                              Text(
                                                "NGN",
                                                style: TextStyle(
                                                  color: Constants.txtColor(),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                          value: controller
                                              .nairaValueConvert.value,
                                          onChanged: (v) {
                                            swappController.exchangeRateSell(
                                                baseSell: v,
                                                asset: controller
                                                    .cryptoValueConvert.value);
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
                                                  List<Country> countries =
                                                      CountryData()
                                                          .getCountries();
                                                  final Country country =
                                                      countries.firstWhere(
                                                    (country) =>
                                                        country.name
                                                                .toLowerCase() ==
                                                            e['name']
                                                                .toString()
                                                                .toLowerCase() ||
                                                        country.currencyCode
                                                                .toLowerCase() ==
                                                            e['currency']
                                                                .toString()
                                                                .toLowerCase(),
                                                  );

                                                  // return country.countryCode;

                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: e['currency'],
                                                    child: Row(
                                                      children: [
                                                        CountryFlag
                                                            .fromCountryCode(
                                                          country.id,
                                                          height: 30,
                                                          width: 30,
                                                          borderRadius: 30,
                                                        ),
                                                        // Image.asset(
                                                        //   'assets/images/image 186.png',
                                                        //   width: 23,
                                                        // ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          e['currency'],
                                                          style:
                                                              const TextStyle(
                                                            color: Color(
                                                                0xffA7A7A7),
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ],
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
                          Text(
                            "Amount",
                            style: TextStyle(
                              color: Constants.txtColor(),
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
                              } else {
                                if (double.parse(value) < 10) {
                                  return 'Minimum sell is \$10';
                                }
                              }

                              return null;
                            },
                            inputFormatters: [
                              CurrencyTextInputFormatter.currency(
                                  symbol: '', decimalDigits: 0)
                            ],
                            onChanged: (v) {
                              if (swappController.sellRate.value == null) {
                                swappController.exchangeRateSell(
                                    baseSell:
                                        controller.cryptoValueConvert.value,
                                    asset: controller.nairaValueConvert.value);
                              }
                              controller.refreshh.toggle();
                            },
                            prefixIcon: SizedBox(
                              height: 50,
                              width: 40,
                              child: Center(
                                child: Text(
                                  "\$",
                                  style: TextStyle(
                                    color: Constants.txtColor(),
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
                                Text(
                                  "Our Fee",
                                  style: TextStyle(
                                    color: Constants.txtColor(),
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
                              style: TextStyle(
                                color: Constants.txtColor(),
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            Row(
                              children: [
                                Icon(
                                  AntDesign.swap,
                                  color: Constants.txtColor(),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Exchange Rate",
                                  style: TextStyle(
                                    color: Constants.txtColor(),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                const Spacer(),
                                swappController.sellRate.value == null
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator())
                                    : Text(
                                        '${controller.nairaValueConvert.value == null ? "NGN ${swappController.sellRate.value ?? "calculating"}" : "${controller.nairaValueConvert.value} ${swappController.sellRate.value ?? "calculating"}"} = 1 USDT',
                                        // "${controller.nairaValueConvert.value == null ? 'NGN ${Constants.sortByUsdStart('ngn').entries.first.value[1]}' : '${controller.nairaValueConvert.value} ${Constants.sortByUsdStart(controller.nairaValueConvert.value.toString().toLowerCase()).entries.first.value[1]}'} = 1 USDT",
                                        style: TextStyle(
                                          color: Constants.txtColor(),
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
                              "Rate varies depending on exchange rate at time of transaction.",
                              style: TextStyle(
                                color: Constants.txtColor(),
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Center(
                              child: Text(
                                "You’ll get",
                                style: TextStyle(
                                  color: Constants.txtColor(),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: swappController.sellRate.value == null
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator())
                                  : Text(
                                      controller.amountController.text.isEmpty
                                          ? controller.nairaValueConvert
                                                      .value ==
                                                  null
                                              ? 'NGN0'
                                              : '${controller.nairaValueConvert.value}0'
                                          : controller.nairaValueConvert
                                                      .value ==
                                                  null
                                              ? 'NGN'
                                                  '${Constants.moneyFormat(double.parse(controller.amountController.text.split(',').join()) * swappController.sellRate.value!)}'
                                              : '${controller.nairaValueConvert.value!} ${Constants.moneyFormat(double.parse(controller.amountController.text.split(',').join()) * swappController.sellRate.value!)}',
                                      style: TextStyle(
                                        color: Constants.txtColor(),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 28,
                                      ),
                                    ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Obx(
                              () {
                                return Button(
                                  buttonWidth: MediaQuery.sizeOf(context).width,
                                  buttonText: "Sell",
                                  color: controller.amountController.text
                                              .isNotEmpty &&
                                          double.parse(controller
                                                  .amountController.text
                                                  .split(",")
                                                  .join()) <
                                              10
                                      ? Colors.grey
                                      : null,
                                  isLoading: swappController.isLoading.value,
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      return Get.toNamed('/enterbankdetails',
                                          arguments: {
                                            "amount": controller
                                                .amountController.text,
                                            "from": controller
                                                        .cryptoValueConvert
                                                        .value ==
                                                    null
                                                ? 'USDT'
                                                : controller
                                                    .cryptoValueConvert.value
                                                    .toString()
                                                    .split('-')
                                                    .first,
                                            "to": controller.nairaValueConvert
                                                        .value ==
                                                    null
                                                ? 'NGN'
                                                : controller
                                                    .nairaValueConvert.value
                                                    .toString(),
                                            "network": controller
                                                        .cryptoValueConvert
                                                        .value ==
                                                    null
                                                ? 'trc20'
                                                : controller
                                                    .cryptoValueConvert.value
                                                    .toString()
                                                    .split('-')
                                                    .last
                                                    .toLowerCase(),
                                          });
                                    }
                                  },
                                );
                              },
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

class LogOutClass extends StatelessWidget {
  const LogOutClass({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 385,
        height: 246,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        decoration: BoxDecoration(
            color: const Color(0xffFFFFFF),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Text(
              "Confirm you want to logout!",
              style: TextStyle(
                color: Color(0xff000000),
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "You are about to logout of your account,\nConfirm to proceed or cancel if it’s a mistake.",
              style: TextStyle(
                color: Color(0xff000000),
                fontWeight: FontWeight.w400,
                fontSize: 13,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: Button(
                    height: 48,
                    radius: 16,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                    buttonText: "Cancel",
                    color: const Color(0xff000000),
                    textColor: const Color(0xffffffff),
                    textSize: 18,
                    onTap: () => Get.back(),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Button(
                    height: 48,
                    radius: 16,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                    buttonText: "Logout",
                    color: const Color(0xffFF0000),
                    border: Border.all(
                        color: const Color(0xffFF0000).withOpacity(0.30),
                        width: 2),
                    outline: true,
                    textSize: 18,
                    onTap: () async {
                      await Constants.store.erase();

                      return Navigator.of(context).pushNamedAndRemoveUntil(
                          '/getstarted', (route) => false);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

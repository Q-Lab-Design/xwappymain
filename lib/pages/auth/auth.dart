import 'package:country_data/country_data.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xwappy/constants.dart';
import 'package:xwappy/pages/auth/authcontroller.dart';
import 'package:xwappy/widgets/button.dart';

class AuthScreen extends GetView<AuthController> {
  AuthScreen({super.key});

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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Obx(
              () => Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Image.asset(Constants.appLogo()),
                          const Spacer(),
                          Button(
                            height: 40,
                            buttonWidth: 98,
                            buttonText: "Login",
                            onTap: () {
                              return Get.toNamed('/login');
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Hey Chief,",
                        style: TextStyle(
                          color: Color(0xffC5C5C5),
                          fontWeight: FontWeight.w700,
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Buy and Sell your stablecoin\nin realtime.",
                        style: TextStyle(
                          color: Color(0xffFFFFFF),
                          fontWeight: FontWeight.w500,
                          fontSize: 21,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "",
                        style: TextStyle(
                          color: Color(0xffFFFFFF),
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 40,
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                            color: const Color(0xffD9D9D9),
                            borderRadius: BorderRadius.circular(16.8)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed('/getstarted');
                                // controller.pageState.value =
                                //     PageState.getstarted;
                              },
                              child: Container(
                                height: 40,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 5),
                                decoration: BoxDecoration(
                                    color: controller.pageState.value ==
                                            PageState.getstarted
                                        ? const Color(0xffF1D643)
                                        : const Color(0xffD9D9D9),
                                    borderRadius: BorderRadius.circular(16.8)),
                                child: const Center(
                                  child: Text(
                                    "Get Started",
                                    style: TextStyle(
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.pageState.value = PageState.ourstat;
                                if (controller.stats.isEmpty) {
                                  controller.getStats();
                                }
                              },
                              child: Container(
                                height: 40,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 5),
                                decoration: BoxDecoration(
                                    color: controller.pageState.value ==
                                            PageState.ourstat
                                        ? const Color(0xffF1D643)
                                        : const Color(0xffD9D9D9),
                                    borderRadius: BorderRadius.circular(16.8)),
                                child: const Center(
                                  child: Text(
                                    "Our Stats",
                                    style: TextStyle(
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.pageState.value =
                                    PageState.currencies;

                                if (controller.supportedAssets.isEmpty) {
                                  controller.getSupportedAssets();
                                }
                              },
                              child: Container(
                                height: 40,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 5),
                                decoration: BoxDecoration(
                                    color: controller.pageState.value ==
                                            PageState.currencies
                                        ? const Color(0xffF1D643)
                                        : const Color(0xffD9D9D9),
                                    borderRadius: BorderRadius.circular(16.8)),
                                child: const Center(
                                  child: Text(
                                    "Currencies",
                                    style: TextStyle(
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      if (controller.pageState.value == PageState.ourstat) ...[
                        const SizedBox(
                          height: 20,
                        ),
                        // if (controller.supportedAssetsLoading.value)
                        //   const Center(
                        //       child: LinearProgressIndicator(
                        //     minHeight: 0.7,
                        //   ))
                        // else
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset('assets/images/money-send.png'),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      "",
                                      style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                controller.statsLoading.value == true
                                    ? Constants.shimmer(
                                        baseColor: Colors.grey.withOpacity(0.2),
                                        highlightColor:
                                            Colors.amber.withOpacity(0.2),
                                        child: Container(
                                          height: 20,
                                          width: 200,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ))
                                    : controller.stats.isEmpty
                                        ? const SizedBox()
                                        : Text(
                                            controller.stats['onramp']['amount']
                                                    .toString()
                                                    .isNotEmpty
                                                ? r"$" +
                                                    Constants.moneyFormat(
                                                        int.parse(controller
                                                            .stats['onramp']
                                                                ['amount']
                                                            .toString()))
                                                : r"$12,234,843.93",
                                            style: const TextStyle(
                                              color: Color(0xff83BF4F),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 21,
                                            ),
                                          ),
                              ],
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Txn Counts",
                                  style: TextStyle(
                                    color: Color(0xffFFFFFF),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                controller.statsLoading.value == true
                                    ? Constants.shimmer(
                                        baseColor: Colors.grey.withOpacity(0.2),
                                        highlightColor:
                                            Colors.amber.withOpacity(0.2),
                                        child: Container(
                                          height: 20,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ))
                                    : controller.stats.isEmpty
                                        ? const SizedBox()
                                        : Text(
                                            controller.stats['onramp']['count']
                                                    .toString()
                                                    .isNotEmpty
                                                ? Constants.moneyFormat(
                                                    int.parse(controller
                                                        .stats['onramp']
                                                            ['count']
                                                        .toString()))
                                                : "12,234",
                                            style: const TextStyle(
                                              color: Color(0xff83BF4F),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 21,
                                            ),
                                          ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                        'assets/images/money-send copy.png'),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      "",
                                      style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                controller.statsLoading.value == true
                                    ? Constants.shimmer(
                                        baseColor: Colors.grey.withOpacity(0.2),
                                        highlightColor:
                                            Colors.amber.withOpacity(0.2),
                                        child: Container(
                                          height: 20,
                                          width: 200,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ))
                                    : controller.stats.isEmpty
                                        ? const SizedBox()
                                        : Text(
                                            controller.stats['offramp']
                                                        ['amount']
                                                    .toString()
                                                    .isNotEmpty
                                                ? r"$" +
                                                    Constants.moneyFormat(
                                                        int.parse(controller
                                                            .stats['offramp']
                                                                ['amount']
                                                            .toString()))
                                                : r"$15,464,745.03",
                                            style: const TextStyle(
                                              color: Color(0xffFA7C07),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 21,
                                            ),
                                          ),
                              ],
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Txn Counts",
                                  style: TextStyle(
                                    color: Color(0xffFFFFFF),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                controller.statsLoading.value == true
                                    ? Constants.shimmer(
                                        baseColor: Colors.grey.withOpacity(0.2),
                                        highlightColor:
                                            Colors.amber.withOpacity(0.2),
                                        child: Container(
                                          height: 20,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ))
                                    : controller.stats.isEmpty
                                        ? const SizedBox()
                                        : Text(
                                            controller.stats['offramp']['count']
                                                    .toString()
                                                    .isNotEmpty
                                                ? Constants.moneyFormat(
                                                    int.parse(controller
                                                        .stats['offramp']
                                                            ['count']
                                                        .toString()))
                                                : "12,234",
                                            style: const TextStyle(
                                              color: Color(0xffFA7C07),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 21,
                                            ),
                                          ),
                              ],
                            ),
                          ],
                        )
                      ],
                      // if (controller.supportedAssetsLoading.value)
                      //   const Center(
                      //       child: LinearProgressIndicator(
                      //     minHeight: 0.7,
                      //   ))
                      // else

                      if (controller.pageState.value ==
                          PageState.currencies) ...[
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Supported Stable coin",
                          style: TextStyle(
                            color: Color(0xffFFFFFF),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        controller.supportedAssetsLoading.value == true
                            ? Constants.shimmer(
                                baseColor: Colors.grey.withOpacity(0.2),
                                highlightColor: Colors.amber.withOpacity(0.2),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          height: 45,
                                          width: 45,
                                          decoration: const BoxDecoration(
                                            color: Colors.black,
                                            shape: BoxShape.circle,
                                            // borderRadius:
                                            //     BorderRadius.circular(5)
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 20,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          height: 45,
                                          width: 45,
                                          decoration: const BoxDecoration(
                                            color: Colors.black,
                                            shape: BoxShape.circle,
                                            // borderRadius:
                                            //     BorderRadius.circular(5)
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 20,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ))
                            : controller.supportedAssets.isEmpty
                                ? const SizedBox()
                                : Wrap(
                                    spacing: 10,
                                    children: controller
                                        .supportedAssets['coins']
                                        .map<Widget>(
                                      (e) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              e.toString() == "USDT-TRC20"
                                                  ? 'assets/images/image 219.png'
                                                  : 'assets/images/emojione_flag-for-nigeria.png',
                                              width: 47,
                                              height: 47,
                                              fit: BoxFit.fill,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              e.toString(),
                                              style: const TextStyle(
                                                color: Color(0xffffffff),
                                                fontWeight: FontWeight.w700,
                                                fontSize: 11,
                                              ),
                                            ),
                                            // const SizedBox(
                                            //   height: 5,
                                            // ),
                                            // const Text(
                                            //   "TRON",
                                            //   style: TextStyle(
                                            //     color: Color(0xffffffff),
                                            //     fontWeight: FontWeight.w600,
                                            //     fontSize: 12,
                                            //   ),
                                            // ),
                                          ],
                                        );
                                      },
                                    ).toList(),
                                    // Column(
                                    //   crossAxisAlignment: CrossAxisAlignment.start,
                                    //   children: [
                                    //     Image.asset(
                                    //         'assets/images/emojione_flag-for-nigeria.png'),
                                    //     const SizedBox(
                                    //       height: 10,
                                    //     ),
                                    //     const Text(
                                    //       "USDC",
                                    //       style: TextStyle(
                                    //         color: Color(0xffffffff),
                                    //         fontWeight: FontWeight.w700,
                                    //         fontSize: 11,
                                    //       ),
                                    //     ),
                                    //     const SizedBox(
                                    //       height: 5,
                                    //     ),
                                    //     const Text(
                                    //       "MATIC, ETH",
                                    //       style: TextStyle(
                                    //         color: Color(0xffffffff),
                                    //         fontWeight: FontWeight.w600,
                                    //         fontSize: 12,
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    // const SizedBox(
                                    //   width: 20,
                                    // ),
                                  ),
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          "Supported Countries",
                          style: TextStyle(
                            color: Color(0xffFFFFFF),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        controller.supportedAssetsLoading.value == true
                            ? Constants.shimmer(
                                baseColor: Colors.grey.withOpacity(0.2),
                                highlightColor: Colors.amber.withOpacity(0.2),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          height: 45,
                                          width: 45,
                                          decoration: const BoxDecoration(
                                            color: Colors.black,
                                            shape: BoxShape.circle,
                                            // borderRadius:
                                            //     BorderRadius.circular(5)
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 20,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          height: 45,
                                          width: 45,
                                          decoration: const BoxDecoration(
                                            color: Colors.black,
                                            shape: BoxShape.circle,
                                            // borderRadius:
                                            //     BorderRadius.circular(5)
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 20,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          height: 45,
                                          width: 45,
                                          decoration: const BoxDecoration(
                                            color: Colors.black,
                                            shape: BoxShape.circle,
                                            // borderRadius:
                                            //     BorderRadius.circular(5)
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 20,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ))
                            : controller.supportedAssets.isEmpty
                                ? const SizedBox()
                                : Wrap(
                                    spacing: 10,
                                    children: controller
                                        .supportedAssets['countries']
                                        .map<Widget>(
                                      (e) {
                                        List<Country> countries =
                                            CountryData().getCountries();
                                        final Country country =
                                            countries.firstWhere(
                                          (country) =>
                                              country.name.toLowerCase() ==
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

                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CountryFlag.fromCountryCode(
                                              country.id,
                                              height: 50,
                                              width: 50,
                                              borderRadius: 12,
                                            ),
                                            // Image.asset(
                                            //     'assets/images/image 186.png'),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              e['name'].toString(),
                                              style: const TextStyle(
                                                color: Color(0xffffffff),
                                                fontWeight: FontWeight.w700,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ).toList(),
                                  ),
                        // Row(
                        //   children: [
                        //     Column(
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       children: [
                        //         Image.asset('assets/images/image 186.png'),
                        //         const SizedBox(
                        //           height: 10,
                        //         ),
                        //         const Text(
                        //           "Nigeria",
                        //           style: TextStyle(
                        //             color: Color(0xffffffff),
                        //             fontWeight: FontWeight.w700,
                        //             fontSize: 11,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //     const SizedBox(
                        //       width: 30,
                        //     ),
                        //     Column(
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       children: [
                        //         Image.asset('assets/images/image 188.png'),
                        //         const SizedBox(
                        //           height: 10,
                        //         ),
                        //         const Text(
                        //           "Kenya",
                        //           style: TextStyle(
                        //             color: Color(0xffffffff),
                        //             fontWeight: FontWeight.w700,
                        //             fontSize: 11,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //     const SizedBox(
                        //       width: 30,
                        //     ),
                        //     Column(
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       children: [
                        //         Image.asset('assets/images/image 187.png'),
                        //         const SizedBox(
                        //           height: 10,
                        //         ),
                        //         const Text(
                        //           "Ghana",
                        //           style: TextStyle(
                        //             color: Color(0xffffffff),
                        //             fontWeight: FontWeight.w700,
                        //             fontSize: 11,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ],
                        // ),
                        const SizedBox(
                          height: 50,
                        ),
                        Button(
                          buttonWidth: MediaQuery.sizeOf(context).width,
                          buttonText: "Get Started",
                          onTap: () =>
                              controller.pageState.value = PageState.getstarted,
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}

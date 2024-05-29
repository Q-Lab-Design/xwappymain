import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xwappy/pages/records/model.dart';
import 'package:xwappy/pages/records/recordscard.dart';
import 'package:xwappy/pages/records/recordscontroller.dart';

class RecordsScreen extends GetView<RecordsController> {
  const RecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000000),
      body: SafeArea(
          top: true,
          left: false,
          right: false,
          bottom: false,
          child: Obx(
            () => BlurryModalProgressHUD(
              inAsyncCall: controller.isLoading.value,
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
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Transactions\nRecords", //$10,023.43
                        style: TextStyle(
                          color: Color(0xffC5C5C5),
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 39,
                        width: 103,
                        decoration: BoxDecoration(
                          color: const Color(0xff2A2A2A),
                          borderRadius: BorderRadius.circular(16.8),
                          border: Border.all(
                              width: 0.5, color: const Color(0xFfC3C7E5)),
                        ),
                        child: Center(
                          child: DropdownButton(
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Color(0xff6F6F6F),
                              ),
                              underline: const SizedBox(),
                              value: controller.typeDropDownValue.value,
                              hint: const Text(
                                'Buy ',
                                style: TextStyle(color: Color(0xffA7A7A7)),
                              ),
                              onChanged: (v) {
                                controller.isLoading.value = true;
                                controller.typeDropDownValue.value =
                                    v.toString();
                                controller
                                    .transactionRecords(
                                        filtrType:
                                            controller.pageState.value.name)
                                    .then((onValue) {
                                  controller.isLoading.value = false;
                                });
                              },
                              dropdownColor: const Color(0xff000000),
                              items: const [
                                DropdownMenuItem(
                                  value: 'Sell',
                                  child: Text(
                                    'Sell',
                                    style: TextStyle(color: Color(0xffA7A7A7)),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "Buy",
                                  child: Text(
                                    'Buy',
                                    style: TextStyle(color: Color(0xffA7A7A7)),
                                  ),
                                )
                              ]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Container(
                      height: 50,
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                          color: const Color(0xffFFFFFF),
                          borderRadius: BorderRadius.circular(40)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.pageState.value = PageState.initiated;
                              if (initiatedList.isEmpty) {
                                controller.initiatedLoading.value = true;
                              }

                              controller
                                  .transactionRecords(
                                      filtrType:
                                          controller.pageState.value.name)
                                  .then((onValue) {
                                controller.initiatedLoading.value = false;
                              });
                            },
                            child: Container(
                              height: 50,
                              width: 120,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 5),
                              decoration: BoxDecoration(
                                  color: controller.pageState.value ==
                                          PageState.initiated
                                      ? const Color(0xffF1D643)
                                      : const Color(0xffFFFFFF),
                                  borderRadius: BorderRadius.circular(40)),
                              child: const Center(
                                child: Text(
                                  "Initiated",
                                  style: TextStyle(
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.pageState.value = PageState.pending;
                              if (pendingList.isEmpty) {
                                controller.pendingLoading.value = true;
                              }

                              controller
                                  .transactionRecords(
                                      filtrType:
                                          controller.pageState.value.name)
                                  .then((onValue) {
                                controller.pendingLoading.value = false;
                              });
                            },
                            child: Container(
                              height: 50,
                              width: 120,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 5),
                              decoration: BoxDecoration(
                                  color: controller.pageState.value ==
                                          PageState.pending
                                      ? const Color(0xffF1D643)
                                      : const Color(0xffFFFFFF),
                                  borderRadius: BorderRadius.circular(40)),
                              child: const Center(
                                child: Text(
                                  "Pending",
                                  style: TextStyle(
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.pageState.value = PageState.completed;
                              if (completeList.isEmpty) {
                                controller.completeLoading.value = true;
                              }

                              controller
                                  .transactionRecords(
                                      filtrType:
                                          controller.pageState.value.name)
                                  .then((onValue) {
                                controller.completeLoading.value = false;
                              });
                            },
                            child: Container(
                              height: 50,
                              width: 120,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                  color: controller.pageState.value ==
                                          PageState.completed
                                      ? const Color(0xffF1D643)
                                      : const Color(0xffFFFFFF),
                                  borderRadius: BorderRadius.circular(40)),
                              child: const Center(
                                child: Text(
                                  "Completed",
                                  style: TextStyle(
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (controller.pageState.value == PageState.initiated) ...[
                    const SizedBox(
                      height: 5,
                    ),

                    if (controller.initiatedLoading.value)
                      const LinearProgressIndicator(
                        minHeight: 0.7,
                      )
                    else
                      ...initiatedList.map((v) {
                        return Column(children: [
                          RecordsCard(
                              type: 'initiated',
                              state: "Continue to Pay",
                              data: v),
                          const SizedBox(
                            height: 15,
                          ),
                        ]);
                      })
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    // RecordsCard(
                    //   type: 'initiated',
                    //   state: 'Continue to Pay',
                    // ),
                  ],
                  if (controller.pageState.value == PageState.pending) ...[
                    const SizedBox(
                      height: 5,
                    ),
                    if (controller.pendingLoading.value)
                      const LinearProgressIndicator(
                        minHeight: 0.7,
                      )
                    else
                      ...pendingList.map((v) {
                        // Constants.logger.d(v.type);
                        return Column(children: [
                          RecordsCard(type: v.type, state: v.status, data: v),
                          const SizedBox(
                            height: 15,
                          ),
                        ]);
                      })
                  ],

                  //  RecordsCard(type: 'pending', state: 'Contact Support'),
                  //   const SizedBox(
                  //     height: 15,
                  //   ),
                  //   RecordsCard(type: 'pending', state: 'Continue'),
                  //   const SizedBox(
                  //     height: 15,
                  //   ),
                  //   RecordsCard(type: 'pending', state: 'View'),
                  if (controller.pageState.value == PageState.completed) ...[
                    const SizedBox(
                      height: 5,
                    ),

                    if (controller.completeLoading.value)
                      const LinearProgressIndicator(
                        minHeight: 0.7,
                      )
                    else
                      ...completeList.map((v) {
                        return Column(children: [
                          RecordsCard(type: 'complete', state: "View", data: v),
                          const SizedBox(
                            height: 15,
                          ),
                        ]);
                      })
                    // RecordsCard(type: 'complete', state: 'View'),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    // RecordsCard(
                    //   type: 'complete',
                    //   state: 'View',
                    // ),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    // RecordsCard(
                    //   type: 'complete',
                    //   state: 'View',
                    // ),
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

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xwappy/pages/records/model.dart';
import 'package:xwappy/pages/records/recordscard.dart';
import 'package:xwappy/pages/records/recordscontroller.dart';

import '../../constants.dart';

class RecordsScreen extends GetView<RecordsController> {
  const RecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.bkgColor(),
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
                child: SingleChildScrollView(
                  child: Column(children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () => Get.offAllNamed('/home'),
                        child: Icon(
                          Icons.close,
                          color: Constants.txtColor(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "${controller.typeDropDownValue.value} Records", //$10,023.43
                          style: TextStyle(
                            color: Constants.txtColor(),
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
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Constants.txtColor(),
                                ),
                                underline: const SizedBox(),
                                value: controller.typeDropDownValue.value,
                                hint: Text(
                                  'Buy ',
                                  style: TextStyle(
                                    color: Constants.txtColor(),
                                  ),
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
                                dropdownColor: Constants.bkgColor(),
                                items: [
                                  DropdownMenuItem(
                                    value: 'Sell',
                                    child: Text(
                                      'Sell',
                                      style: TextStyle(
                                        color: Constants.txtColor(),
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: "Buy",
                                    child: Text(
                                      'Buy',
                                      style: TextStyle(
                                        color: Constants.txtColor(),
                                      ),
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
                                controller.pageState.value =
                                    PageState.initiated;
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
                                        ? Constants.activeHeaderColor()
                                        : Constants.headerColor(),
                                    borderRadius: BorderRadius.circular(40)),
                                child: Center(
                                  child: Text(
                                    "Initiated",
                                    style: TextStyle(
                                      color: Constants.bkgColor(),
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
                                        ? Constants.activeHeaderColor()
                                        : Constants.headerColor(),
                                    borderRadius: BorderRadius.circular(40)),
                                child: Center(
                                  child: Text(
                                    "Pending",
                                    style: TextStyle(
                                      color: Constants.bkgColor(),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.pageState.value =
                                    PageState.completed;
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
                                        ? Constants.activeHeaderColor()
                                        : Constants.headerColor(),
                                    borderRadius: BorderRadius.circular(40)),
                                child: Center(
                                  child: Text(
                                    "Completed",
                                    style: TextStyle(
                                      color: Constants.bkgColor(),
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
                            RecordsCard(
                                type: 'complete', state: "View", data: v),
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
            ),
          )),
    );
  }
}

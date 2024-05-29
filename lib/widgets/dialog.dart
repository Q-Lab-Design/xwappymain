import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:xwappy/widgets/button.dart';

import 'text.dart';

// ignore: must_be_immutable
class SuccessfulDialogs extends StatelessWidget {
  bool showclose;
  String title;
  String description;
  bool showloader;
  bool showImage;
  Color loaderColor;
  TextStyle? titleStyle;
  TextStyle? descStyle;
  double? borderRadius;
  Button? botton;

  SuccessfulDialogs(
      {super.key,
      this.showclose = false,
      this.showloader = true,
      this.title = '',
      this.description = '',
      this.showImage = false,
      this.loaderColor = const Color(0xffB2B1B1),
      this.titleStyle,
      this.borderRadius,
      this.botton,
      this.descStyle});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xffffffff),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 22)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 24),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showclose)
                const Icon(
                  MaterialCommunityIcons.close_box_outline,
                  size: 30,
                  color: Color(0xffffffff),
                ),
              if (showclose) const Spacer(),
              // if (showImage)
              Image.asset(
                'assets/images/check.gif',
                // size: 30,
              ),
              if (showclose) const Spacer(),
              if (showclose)
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    MaterialCommunityIcons.close_box_outline,
                    size: 30,
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: titleStyle ??
                const TextStyle(
                  color: Color(0xff2C333F),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: descStyle ??
                const TextStyle(
                  color: Color(0xff646C79),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(
            height: 25,
          ),
          if (botton != null) botton!,
          SizedBox(
            width: 116.5,
            child: showloader
                ? LinearProgressIndicator(
                    color: loaderColor,
                    backgroundColor: const Color(0xffE7E6E6),
                  )
                : const SizedBox(),
          ),
        ]),
      ),
    );
  }
}

// ignore: must_be_immutable
class ErrorDialogs extends StatelessWidget {
  bool showclose, showclos;
  String title;
  String description;
  bool showloader;
  Color loaderColor;
  bool showImage;
  TextStyle? titleStyle;
  TextStyle? descStyle;
  double? borderRadius;
  Button? botton;

  ErrorDialogs({
    super.key,
    this.showclose = false,
    this.showclos = false,
    this.showloader = true,
    this.title = '',
    this.description = '',
    this.loaderColor = const Color(0xffB2B1B1),
    this.borderRadius,
    this.botton,
    this.descStyle,
    this.titleStyle,
    this.showImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xfff6f6f6),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 22)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 24),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showclose)
                const Icon(
                  MaterialCommunityIcons.close_box_outline,
                  size: 30,
                  color: Color(0xfff6f6f6),
                ),
              if (showclose) const Spacer(),
              if (showImage) Image.asset('assets/images/redexclaim.png'),
              if (showclos) const Spacer(),
              if (showclos)
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    MaterialCommunityIcons.close_box_outline,
                    size: 30,
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          if (title.isNotEmpty)
            Text(
              title,
              textAlign: TextAlign.center,
              style: titleStyle ??
                  const TextStyle(
                    color: Color(0xff2C333F),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: descStyle ??
                const TextStyle(
                  color: Color(0xff646C79),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(
            height: 25,
          ),
          SizedBox(
            width: 116,
            child: showloader
                ? LinearProgressIndicator(
                    color: loaderColor,
                    backgroundColor: const Color(0xffE7E6E6),
                  )
                : const SizedBox(),
          ),
        ]),
      ),
    );
  }
}

// ignore: must_be_immutable
class ConfirmDialogs extends StatelessWidget {
  bool showclose;
  String title;
  String description;
  bool showloader;
  Color loaderColor;

  ConfirmDialogs({
    super.key,
    this.showclose = false,
    this.showloader = true,
    this.title = '',
    this.description = '',
    this.loaderColor = const Color(0xffB2B1B1),
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xfff6f6f6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 24),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showclose)
                const Icon(
                  MaterialCommunityIcons.close_box_outline,
                  size: 30,
                  color: Color(0xfff6f6f6),
                ),
              if (showclose) const Spacer(),
              Image.asset('assets/images/redexclaim.png'),
              if (showclose) const Spacer(),
              if (showclose)
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    MaterialCommunityIcons.close_box_outline,
                    size: 30,
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          if (title.isNotEmpty)
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xff2C333F),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xff646C79),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        color: const Color(0xffE4E4E4),
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          Get.back(result: false);
                        },
                        child: const CustomText(
                          text: 'Cancel',
                          fontSize: 16,
                          color: Color(0xff343434),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        color: const Color(0xffE5F3FE),
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          Get.back(result: true);
                        },
                        child: const CustomText(
                          text: 'Confirm',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff0084F8),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 116,
            child: showloader
                ? LinearProgressIndicator(
                    color: loaderColor,
                    backgroundColor: const Color(0xffE7E6E6),
                  )
                : const SizedBox(),
          ),
        ]),
      ),
    );
  }
}

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class CheckBoxx extends StatelessWidget {
  CheckBoxx({Key? key, this.onChanged, this.radius}) : super(key: key);

  RxBool checked = false.obs;
  void Function(bool?)? onChanged;
  double? radius;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Checkbox(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 5)),
        activeColor: const Color(0xff6B4EFF),
        onChanged: (bool? value) {
          checked.value = value!;

          if (onChanged != null) {
            onChanged!(value);
          }
        },
        value: checked.value,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:poemer/assets/strings.dart';

class BuildCreationDialog extends StatelessWidget {
  final TextEditingController controller;
  final Function() onAdd;

  const BuildCreationDialog(
      {required this.controller, required this.onAdd, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(vertical: 350.h),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextFormField(
            controller: controller,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FilledButton(
                onPressed: onAdd,
                child: Text(
                  PoemerStrings.add,
                  style: Get.textTheme.bodySmall,
                ),
              ),
              FilledButton(
                onPressed: () => Get.back(),
                child: Text(
                  PoemerStrings.close,
                  style: Get.textTheme.bodySmall,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:poemer/assets/strings.dart';

class BuildCreationDialog extends StatelessWidget {
  final TextEditingController controller;
  final Function() onAdd;
  final String title;

  const BuildCreationDialog({
    required this.controller,
    required this.onAdd,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(vertical: 370.h),
      title: Text(
        title,
        style: Get.textTheme.bodyMedium,
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextFormField(
            controller: controller,
            cursorColor: Get.theme.primaryColor.withOpacity(0.5),
            decoration: InputDecoration(

              hintText: PoemerStrings.typeANameHere,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    10.r,
                  ),
                ),
              ),
            ),
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

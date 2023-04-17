import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:poemer/assets/strings.dart';
import 'package:poemer/network/controllers/directories_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final DirectoriesController directoriesController =
      Get.find<DirectoriesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            PoemerStrings.appName,
            style: TextStyle(
              fontSize: 40.sp,
            ),
          ),
        ),
        body: SizedBox(
          height: 1080.h,
          width: 1920.w,
          child: Column(
            children: [
              directoriesController.obx(
                (state) => ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.length,
                  itemBuilder: (context, index)=> ListTile(
                    title: Text(state[index].name),
                    contentPadding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 80.w),
                  ),
                ),
                onLoading: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              )
            ],
          ),
        ));
  }
}

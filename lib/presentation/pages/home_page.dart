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
                (state) => state.length > 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.length,
                        itemBuilder: (context, index) => ListTile(
                          title: Text(
                            state[index].name,
                            style: TextStyle(
                              fontSize: 45.sp,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 50.h,
                            horizontal: 80.w,
                          ),
                        ),
                      )
                    : Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              PoemerStrings.yourWorkspaceIsEmpty,
                              style: Get.theme.textTheme.bodyMedium,
                            ),
                            TextButton(
                              onPressed: () async =>
                                  await Get.dialog(AlertDialog(
                                insetPadding:
                                    EdgeInsets.symmetric(vertical: 350.h),
                                content: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextFormField(
                                      controller: directoriesController
                                          .newDirectoryNameController,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        FilledButton(
                                          onPressed: () async{
                                            await directoriesController
                                              .addNewDirectory(
                                                  directoriesController
                                                      .newDirectoryNameController
                                                      .text);
                                            Get.back();
                                          },
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
                              )),
                              child: Text(
                                PoemerStrings.createNewDirectory,
                                style: Get.theme.textTheme.bodyMedium,
                              ),
                            )
                          ],
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

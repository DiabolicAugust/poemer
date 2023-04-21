import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:poemer/assets/strings.dart';
import 'package:poemer/domain/model/directory_model.dart';
import 'package:poemer/network/controllers/books_controller.dart';
import 'package:poemer/network/controllers/directories_controller.dart';
import 'package:poemer/presentation/widgets/creation_dialog.dart';

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
                    ? _BuildDirectoriesList(
                        directories: state,
                      )
                    : _BuildNoDirectories(
                        directoriesController: directoriesController),
                onLoading: const Expanded(
                  child: Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class _BuildDirectoriesList extends StatefulWidget {
  final List<Directory> directories;

  const _BuildDirectoriesList({
    required this.directories,
    super.key,
  });

  @override
  State<_BuildDirectoriesList> createState() => _BuildDirectoriesListState();
}

class _BuildDirectoriesListState extends State<_BuildDirectoriesList> {
  late final BooksController booksController;

  @override
  void initState() {
    booksController = Get.find<BooksController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: widget.directories.length,
        itemBuilder: (context, index) => ExpansionTile(
              title: Text(
                widget.directories[index].name,
                style: TextStyle(
                  fontSize: 45.sp,
                ),
              ),
              tilePadding: EdgeInsets.symmetric(
                horizontal: 30.w,
                vertical: 50.h,
              ),
              childrenPadding: EdgeInsets.symmetric(
                horizontal: 40.w,
                vertical: 50.h,
              ),
              children: [
                booksController.obx(
                    (state) => _buildExpandedTileSuccessfulContent(index),
                    onLoading: const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )),
              ],
            ));
  }

  Column _buildExpandedTileSuccessfulContent(int index) {
    return Column(
      children: [
        if (booksController.books.isNotEmpty)
          Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: booksController.books.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      booksController.books[index].name,
                      style: Get.textTheme.bodySmall,
                    ),
                  );
                },
              ),
              50.verticalSpace,
            ],
          ),
        _buildBookCreationButton(index),
      ],
    );
  }

  Center _buildBookCreationButton(int index) {
    return Center(
      child: TextButton(
        onPressed: () async {
          return await Get.dialog(
            BuildCreationDialog(
              controller: booksController.bookCreationController,
              onAdd: () async {
                await booksController.createBook(
                  booksController.bookCreationController.text,
                  widget.directories[index].id,
                );
                Get.back();
              },
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30.w,
            vertical: 20.h,
          ),
          child: Text(
            PoemerStrings.createNewBook,
            style: Get.textTheme.bodySmall,
          ),
        ),
      ),
    );
  }
}

class _BuildNoDirectories extends StatelessWidget {
  const _BuildNoDirectories({
    super.key,
    required this.directoriesController,
  });

  final DirectoriesController directoriesController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            PoemerStrings.yourWorkspaceIsEmpty,
            style: Get.theme.textTheme.bodyMedium,
          ),
          TextButton(
            onPressed: () async => await Get.dialog(
              BuildCreationDialog(
                controller: directoriesController.newDirectoryNameController,
                onAdd: () async {
                  await directoriesController.addNewDirectory(
                      directoriesController.newDirectoryNameController.text);
                  Get.back();
                },
              ),
            ),
            child: Text(
              PoemerStrings.createNewDirectory,
              style: Get.theme.textTheme.bodyMedium,
            ),
          )
        ],
      ),
    );
  }
}

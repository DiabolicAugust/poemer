import 'package:get/get.dart';
import 'package:poemer/network/controllers/directories_controller.dart';

class DirectoriesBinding implements Bindings {
// default dependency
  @override
  Future<void> dependencies() async {
    await Get.putAsync(() async => DirectoriesController());
    }
}
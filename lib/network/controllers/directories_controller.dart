import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:poemer/domain/model/directory_model.dart';
import 'package:poemer/service/factory/directory_factory.dart';

class DirectoriesController extends GetxController with StateMixin{
  final RxList<Directory> directories = <Directory>[].obs;
  final DirectoryFactory _factory = DirectoryFactory();

  @override
  Future<void> onInit()async{
    FirebaseFirestore firebase = FirebaseFirestore.instance;
    print(firebase.app.name);

    await FirebaseFirestore.instance.enableNetwork();
    QuerySnapshot snapshot = await firebase.collection('Directories').get();
    directories.addAll(_factory.toDomainList(snapshot.docs));
    change(directories, status: RxStatus.success());
    super.onInit();
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poemer/assets/strings.dart';
import 'package:poemer/domain/model/directory_model.dart';
import 'package:poemer/service/factory/directory_factory.dart';

class DirectoriesController extends GetxController with StateMixin {
  final RxList<Directory> directories = <Directory>[].obs;
  final DirectoryFactory _factory = DirectoryFactory();
  final TextEditingController newDirectoryNameController = TextEditingController();
  final FirebaseFirestore firebase = FirebaseFirestore.instance;

  @override
  Future<void> onInit() async {
    await FirebaseFirestore.instance.enableNetwork();
    QuerySnapshot snapshot = await firebase
        .collection(
          PoemerStrings.directoriesCollection,
        )
        .get();
    directories.addAll(_factory.toDomainList(snapshot.docs));
    change(directories, status: RxStatus.success());
    super.onInit();
  }

  Future<void> addNewDirectory(String name) async {
   DocumentReference directoryMap =  await firebase
        .collection(
          PoemerStrings.directoriesCollection,
        )
        .add(_factory.toMap(name));
   Directory directory = _factory.toDomain(await directoryMap.get());
   directories.add(directory);
   change(directories, status: RxStatus.success());
  }
}

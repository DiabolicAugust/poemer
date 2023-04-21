import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:poemer/assets/strings.dart';
import 'package:poemer/domain/model/book_model.dart';
import 'package:poemer/service/factory/book_factory.dart';

class BooksController extends GetxController with StateMixin {
  final RxList<Book> books = <Book>[].obs;
  final BookFactory _factory = BookFactory();
  final FirebaseFirestore firebase = FirebaseFirestore.instance;
  final TextEditingController bookCreationController = TextEditingController();

  @override
  Future<void> onInit() async {
    QuerySnapshot snapshot = await firebase
        .collection(
          PoemerStrings.booksCollection,
        )
        .get();
    books.addAll(_factory.toDomainList(snapshot.docs));
    change(books, status: RxStatus.success());
    super.onInit();
  }

  Future<void> createBook(String name, String directoryId) async {
    DocumentReference reference = await firebase
        .collection(
          PoemerStrings.booksCollection,
        )
        .add(_factory.toMap(name, directoryId));

    DocumentSnapshot snapshot = await reference.get();


    books.add(
      _factory.toDomain(
        snapshot
      ),
    );
    change(books, status: RxStatus.success());
  }
}

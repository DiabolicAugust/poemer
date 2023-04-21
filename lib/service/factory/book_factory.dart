import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:poemer/domain/model/book_model.dart';

class BookFactory {
  static const String _nameKey = 'name';
  static const String _dateOfCreationKey = 'date_of_creation';
  static const String _idKey = 'id';
  static const String _directoryIdKey = 'directory_id';

  Book toDomain(DocumentSnapshot data) {
    return Book(
      name: data[_nameKey],
      id: data.id,
      dateOfCreation: data[_dateOfCreationKey],
      directoryId: data[_directoryIdKey],
    );
  }

  List<Book> toDomainList(List<DocumentSnapshot> docs) {
    return docs.map((e) => toDomain(e)).toList();
  }

  Map<String, dynamic> toMap(String name, String directoryId) => {
        _nameKey: name,
        _dateOfCreationKey: DateTime.now().millisecondsSinceEpoch.toString(),
        _directoryIdKey: directoryId,
      };
}

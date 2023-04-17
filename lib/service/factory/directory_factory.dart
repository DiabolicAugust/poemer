import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:poemer/domain/model/directory_model.dart';

class DirectoryFactory{

  static const String _nameKey = 'name';

  Directory toDomain(DocumentSnapshot data){
    return Directory(data[_nameKey], data.id);
  }

  List<Directory> toDomainList(List<DocumentSnapshot> docs){
    return docs.map((e) => toDomain(e)).toList();
  }
}
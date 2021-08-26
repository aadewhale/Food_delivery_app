import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  static const ID = "id";
  static const NAME = "name";
  static const ICON = "icon";

  late int _id;
  late String _name;
  late String _icon;

  //  getters
  int get id => _id;

  String get name => _name;

  String get icon => _icon;

  CategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot[ID];
    _name = snapshot[NAME];
    _icon = snapshot[ICON];
  }
}

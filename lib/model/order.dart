import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  static const ID = "id";
  static const DESCRIPTION = "description";
  static const CART = "cart";
  static const USER_ID = "userId";
  static const TOTAL = "total";
  static const STATUS = "status";
  static const CREATED_AT = "createdAt";

  late String _id;

  late String _description;
  late String _userId;
  late String _status;
  late int _createdAt;
  late int _total;

//  getters
  String get id => _id;

  String get description => _description;
  String get userId => _userId;
  String get status => _status;
  int get total => _total;
  int get createdAt => _createdAt;

  // public variable
  late List cart;

  OrderModel.fromSnapshot(DocumentSnapshot document) {
    _id = document[ID];
    _description = document[DESCRIPTION];
    _total = document[TOTAL];
    _status = document[STATUS];
    _userId = document[USER_ID];
    _createdAt = document[CREATED_AT];

    cart = document[CART];
  }
}

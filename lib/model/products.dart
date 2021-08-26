import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  static const ID = "id";
  static const NAME = "name";
  static const RATING = "rating";
  static const IMAGE = "image";
  static const PRICE = "price";
  static const SUBCATEGORY = "subcategory";
  static const DESCRIPTION = "description";
  static const CATEGORY = "category";
  static const FEATURED = "featured";
  static const RATES = "rates";
  static const USER_LIKES = "userLikes";

  late String _id;
  late String _name;
  late String _subcategory;
  late String _category;
  late String _image;
  late String _description;

  late int _rating;
  late int _price;
  late int _rates;

  String get id => _id;

  String get name => _name;

  String get subcategory => _subcategory;

  String get category => _category;

  String get description => _description;

  String get image => _image;

  int get rating => _rating;

  int get price => _price;

  bool get featured => _featured;

  int get rates => _rates;

  // public variable
  bool liked = false;
  bool _featured = false;

  ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot[ID];
    _image = snapshot[IMAGE];
    _subcategory = snapshot[SUBCATEGORY];
    _description = snapshot[DESCRIPTION];
    _featured = snapshot[FEATURED];
    _price = snapshot[PRICE].floor();
    _category = snapshot[CATEGORY];
    _rating = snapshot[RATING];
    _rates = snapshot[RATES];
    _name = snapshot[NAME];
  }
}

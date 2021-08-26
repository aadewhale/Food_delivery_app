import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/model/cart_item.dart';

class UserModel {
  static const ID = "id";
  static const USERNAME = "username";
  static const EMAIL = "email";
  static const STRIPE_ID = "stripeId";
  static const CART = "cart";

  late String _username;
  late String _email;
  late String _id;
  late String _stripeId;
  int _priceSum = 0;

//  getters
  String get username => _username;
  String get email => _email;
  String get id => _id;
  String get stripeId => _stripeId;

//  public variable
  List<CartItemModel> cart = [];
  int totalCartPrice = 0;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _username = snapshot[USERNAME];
    _email = snapshot[EMAIL];
    _id = snapshot[ID];
    _stripeId = snapshot[STRIPE_ID];
    cart = _convertCartItems(snapshot[CART]);
    totalCartPrice =
        snapshot[CART] == null ? 0 : getTotalPrice(cart: snapshot[CART]);
  }

  int getTotalPrice({List? cart}) {
    if (cart == null) {
      return 0;
    }
    for (Map cartItem in cart) {
      int price = cartItem["price"];
      int quantity = cartItem["quantity"];
      _priceSum += price * quantity;
    }

    int total = _priceSum;

    return total;
  }

  List<CartItemModel> _convertCartItems(List cart) {
    List<CartItemModel> convertedCart = [];
    for (Map cartItem in cart) {
      convertedCart.add(CartItemModel.fromMap(cartItem));
    }
    return convertedCart;
  }
}

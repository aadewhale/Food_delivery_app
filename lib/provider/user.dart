import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/authexception.dart';
import 'package:myapp/helper/order.dart';
import 'package:myapp/helper/user.dart';
import 'package:myapp/model/cart_item.dart';
import 'package:myapp/model/order.dart';
import 'package:myapp/model/products.dart';
import 'package:myapp/model/user.dart';


import 'package:uuid/uuid.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider with ChangeNotifier {
  FirebaseAuth _auth;
  UserModel? _userModel;
  AuthResultStatus? _statuss;

  late User _user;
  final picker = ImagePicker();
  File? images;
  Status _status = Status.Uninitialized;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserServices _userServicse = UserServices();
  OrderServices _orderServices = OrderServices();
  bool isSwitched = true;
  var textValue = "Admin";
  late final fresh;

//  getter
  UserModel? get userModel => _userModel;

  Status get status => _status;
  User get user => _user;

  // public variables
  List<OrderModel> orders = [];

  final formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  // TextEditingController pname = TextEditingController();
  // TextEditingController description = TextEditingController();
  // TextEditingController restaurantId = TextEditingController();
  // TextEditingController restaurant = TextEditingController();
  // TextEditingController rates = TextEditingController();
  // TextEditingController rating = TextEditingController();
  // TextEditingController price = TextEditingController();
  // TextEditingController category = TextEditingController();
  // TextEditingController image = TextEditingController();

  TextEditingController featured = TextEditingController();

  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen((User? user) async {
      if (user == null) {
        _status = Status.Uninitialized;
      } else {
        _user = user;
        _status = Status.Authenticated;
      }
      notifyListeners();
    });
  }

  Future<AuthResultStatus?> signIn() async {
    try {
      _status = Status.Authenticating;

      final authResult = await _auth.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      if (authResult.user != null) {
        _statuss = AuthResultStatus.successful;
      } else {
        _statuss = AuthResultStatus.undefined;
      }
    } catch (e) {
      _status = Status.Unauthenticated;
      _statuss = AuthExceptionHandler.handleException(e);
      notifyListeners();
      print(e.toString());
    }

    return _statuss;
  }

  Future<AuthResultStatus?> signUp() async {
    try {
      _status = Status.Authenticating;
      UserCredential authResult = await _auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        _firestore.collection('users').doc(result.user!.uid).set({
          'username': username.text,
          'email': email.text,
          'stripeId': result.user!.uid,
          "id": result.user!.uid,
          "cart": [],
        });
        return fresh;
      });
      if (authResult.user != null) {
        _statuss = AuthResultStatus.successful;
      } else {
        _statuss = AuthResultStatus.undefined;
      }
    } catch (e) {
      _status = Status.Unauthenticated;
      _statuss = AuthExceptionHandler.handleException(e);
      notifyListeners();
      print(e.toString());
    }
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  // Future addPicture() async {
  //   String id = Uuid().v4();
  //   Reference ref = FirebaseStorage.instance.ref();
  //   TaskSnapshot snapshot = await ref.child(id).putFile(images!);
  //   if (snapshot.state == TaskState.success) {
  //     final String downloadUrl = await snapshot.ref.getDownloadURL();
  //     await _firestore.collection("products").add({
  //       "id": id,
  //       "restaurantId": restaurantId.text,
  //       "restaurant": restaurant.text,
  //       "category": category.text,
  //       "description": description.text,
  //       "price": int.parse(price.text),
  //       "rating": int.parse(rating.text),
  //       "rates": int.parse(rates.text),
  //       "name": pname.text,
  //       "image": downloadUrl,
  //       "featured": true
  //     });

  //     print('Sucess');
  //   }
  // }

  // void clearController() {
  //   name.text = "";
  //   password.text = "";
  //   email.text = "";
  //   category.text = "";
  //   restaurantId.text = "";
  //   restaurant.text = "";
  //   restaurant.text = "";
  //   description.text = "";
  //   price.text = "";
  //   rating.text = "";
  //   rates.text = "";
  //   pname.text = "";
  //   image.text = "";
  // }

  Future<void> reloadUserModel() async {
    _userModel = await _userServicse.getUserById(user.uid);

    notifyListeners();
  }

  Future<bool> addToCard(
      {required ProductModel product, required int quantity}) async {
    try {
      var uuid = Uuid();
      String cartItemId = uuid.v4();
      List<CartItemModel>? cart = _userModel!.cart;

      Map cartItem = {
        "id": cartItemId,
        "name": product.name,
        "image": product.image,
        "totalRestaurantSale": product.price * quantity,
        "productId": product.id,
        "price": product.price,
        "quantity": quantity
      };

      CartItemModel item = CartItemModel.fromMap(cartItem);

      print("CART ITEMS ARE: ${cart.toString()}");
      _userServicse.addToCart(userId: _user.uid, cartItem: item);

      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      print(product.price * quantity);

      return false;
    }
  }

  getOrders() async {
    orders = await _orderServices.getUserOrders(userId: _user.uid);
    notifyListeners();
  }

  Future<bool> removeFromCart({required CartItemModel cartItem}) async {
    print("THE PRODUC IS: ${cartItem.toString()}");

    try {
      _userServicse.removeFromCart(userId: _user.uid, cartItem: cartItem);
      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return false;
    }
  }

  Future openCamera() async {
    var image = await picker.pickImage(source: ImageSource.camera);

    images = File(image!.path);

    notifyListeners();
  }

  openGallery() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {}
    notifyListeners();
  }

  void toggleSwitch(bool value) {
    if (isSwitched == true) {
      isSwitched = false;
      textValue = "Admin";
      print(textValue);
    } else {
      isSwitched = true;
      textValue = '';
      print(textValue);
    }
    notifyListeners();
  }
}

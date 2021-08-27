import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum SearchBy { PRODUCTS, RESTAURANTS }
class AppProvider with ChangeNotifier {
  bool isLoading = false;

  SearchBy search = SearchBy.PRODUCTS;
  String filterBy = "Products";
  int totalPrice = 0;
  int priceSum = 0;
  int quantitySum = 0;
  final picker = ImagePicker();
  File? image;
  final icon = [
    "assets/images/cheese-burger.png",
    "assets/images/bacon.png",
    "assets/images/hamburger.png",
  ];

  final List<String> images = <String>[
    "assets/images/Burger11.jpg",
    "assets/images/Burger22.jpg",
    "assets/images/Burger44.jpg",
    "assets/images/Burger22.jpg",
    "assets/images/Burger33.jpg",
  ];

  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future openCamera() async {
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }

    notifyListeners();
  }

  openGallery() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
    notifyListeners();
  }

  void changeSearchBy({required SearchBy newSearchBy}) {
    search = newSearchBy;
    if (newSearchBy == SearchBy.PRODUCTS) {
      filterBy = "Products";
    } else {
      filterBy = "Restaurants";
    }
    notifyListeners();
  }

  addPrice({required int newPrice}) {
    priceSum += newPrice;
    notifyListeners();
  }

  addQuantity({required int newQuantity}) {
    quantitySum += newQuantity;
    notifyListeners();
  }

  getTotalPrice() {
    print("THE TOTAL SUM IS: $priceSum");
    print("THE TOTAL SUM IS: $priceSum");
    print("THE TOTAL SUM IS: $priceSum");
    print("THE TOTAL SUM IS: $priceSum");
    print("THE QUANTITY SUM IS: $quantitySum");
    print("THE QUANTITY SUM IS: $quantitySum");
    print("THE QUANTITY SUM IS: $quantitySum");
    print("THE QUANTITY SUM IS: $quantitySum");

    totalPrice = priceSum * quantitySum;
    print("THE TOTAL AMOUNT IS: $totalPrice");
    print("THE TOTAL AMOUNT IS: $totalPrice");
    print("THE TOTAL AMOUNT IS: $totalPrice");
    print("THE TOTAL AMOUNT IS: $totalPrice");
    print("THE TOTAL AMOUNT IS: $totalPrice");

    notifyListeners();
  }
}

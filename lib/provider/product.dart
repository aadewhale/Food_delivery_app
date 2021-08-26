import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/helper/product.dart';
import 'package:myapp/model/products.dart';
import 'package:uuid/uuid.dart';

class ProductProvider with ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController pname = TextEditingController();
  TextEditingController description = TextEditingController();

  TextEditingController subcategory = TextEditingController();
  TextEditingController rates = TextEditingController();
  TextEditingController rating = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController image = TextEditingController();

  TextEditingController featured = TextEditingController();

  ProductServices _productServices = ProductServices();
  List<ProductModel> products = [];
  List<ProductModel> productsByCategory = [];

  List<ProductModel> productsSearched = [];

  ProductProvider.initialize() {
    loadProducts();
  }

  loadProducts() async {
    products = await _productServices.getProducts();
    notifyListeners();
  }

  Future loadProductsByCategory({required String categoryName}) async {
    productsByCategory =
        await _productServices.getProductsOfCategory(category: categoryName);
    notifyListeners();
  }

  Future search({required String productName}) async {
    productsSearched =
        await _productServices.searchProducts(productName: productName);

    notifyListeners();
  }

  Future addProducts() async {
    String id = Uuid().v4();
    await _firestore.collection("products").add({
      "id": id,
      "subcategory": subcategory.text,
      "category": category.text,
      "description": description.text,
      "price": int.parse(price.text),
      "rating": int.parse("3"),
      "rates": int.parse(rates.text),
      "name": pname.text,
      "image": "hhhh",
      "featured": true
    });
  }
}

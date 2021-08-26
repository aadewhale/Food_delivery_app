import 'package:flutter/material.dart';
import 'package:myapp/helper/category.dart';
import 'package:myapp/model/category.dart';

class CategoryProvider with ChangeNotifier {
  CategoryServices _categoryServices = CategoryServices();
  List<CategoryModel> categories = [];

  Color? color;

  CategoryProvider.initialize() {
    loadCategories();
  }

  loadCategories() async {
    categories = await _categoryServices.getCategories();
    notifyListeners();
  }
}

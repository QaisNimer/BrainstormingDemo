import 'package:flutter/foundation.dart';
import '../model/category_model/category_model.dart';
import '../service/category/category_service.dart';

class CategoryController with ChangeNotifier {
  final CategoryService _categoryService = CategoryService();
  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  Future<void> fetchCategories() async {
    try {
      _categories = await _categoryService.getAllCategories();
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching categories: $e');
      }
    }
  }
}
import 'package:flutter/foundation.dart';
import '../model/category_model/category_model.dart';
import '../service/category/category_service.dart';

class CategoryController with ChangeNotifier {
  final CategoryService _categoryService = CategoryService();
  List<CategoryModel> _categories = [];
  List<CategoryModel> _categoryItems = [];

  List<CategoryModel> get categories => _categories;
  List<CategoryModel> get categoryItems => _categoryItems;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// Fetches all categories from the API.
  Future<void> fetchCategories() async {
    _setLoading(true);
    _clearError();

    try {
      final fetchedCategories = await _categoryService.getAllCategories();
      _categories = fetchedCategories;
    } catch (e) {
      _setError('Failed to load categories. Please try again.');
      if (kDebugMode) {
        print('Error fetching categories: $e');
      }
    } finally {
      _setLoading(false);
    }
  }

  /// Fetches items for a specific category.
  Future<void> fetchCategoryItems(String categoryName) async {
    _setLoading(true);
    _clearError();

    try {
      final fetchedCategories = await _categoryService.getAllCategories();
      _categoryItems = fetchedCategories
          .where((category) => category.englishName.toLowerCase() == categoryName.toLowerCase())
          .toList();
    } catch (e) {
      _setError('Failed to load category items. Please try again.');
      if (kDebugMode) {
        print('Error fetching category items: $e');
      }
    } finally {
      _setLoading(false);
    }
  }

  /// Refreshes the categories by clearing and refetching.
  Future<void> refreshCategories() async {
    _categories.clear();
    notifyListeners();
    await fetchCategories();
  }

  /// Sets the loading state and notifies listeners.
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Sets an error message and notifies listeners.
  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  /// Clears any existing error message.
  void _clearError() {
    _errorMessage = null;
  }
}

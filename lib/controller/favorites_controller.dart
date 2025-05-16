import 'package:flutter/foundation.dart';
import '../model/favorite_model/favorite_model.dart';
import '../service/favorite/favorite_service.dart';

class FavoritesController with ChangeNotifier {
  final FavoriteService _favoriteService = FavoriteService();
  final List<FavoriteItem> _favorites = [];
  bool _isLoading = false;
  String _error = '';
  FavoriteItem? _currentSelectedItem;

  final int _clientId = 1;

  List<FavoriteItem> get favorites => _favorites;
  bool get isLoading => _isLoading;
  String get error => _error;
  FavoriteItem? get currentSelectedItem => _currentSelectedItem;

  // Constructor
  FavoritesController() {
    loadFavorites();
  }

  // Set current item for removal dialog
  void setCurrentItem(FavoriteItem item) {
    _currentSelectedItem = item;
    notifyListeners();
  }

  // Clear current item
  void clearCurrentItem() {
    _currentSelectedItem = null;
    notifyListeners();
  }

  // Load favorites from API
  Future<void> loadFavorites() async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      final favoritesList = await _favoriteService.getFavorites(_clientId);
      _favorites
        ..clear()
        ..addAll(favoritesList.map((favorite) => favorite.toFavoriteItem()));

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = 'Error loading favorites: ${e.toString()}';
      notifyListeners();
    }
  }

  // Add to favorites
  Future<bool> add(FavoriteItem item) async {
    try {
      if (item.itemId <= 0) {
        _error = 'Invalid item ID - must be greater than zero';
        notifyListeners();
        return false;
      }

      if (isFavorite(item.itemId)) return true;

      _favorites.add(item);
      notifyListeners();

      final success = await _favoriteService.addToFavorite(item.itemId, _clientId);
      if (!success) {
        _favorites.removeWhere((element) => element.itemId == item.itemId);
        _error = 'Failed to add to favorites';
        notifyListeners();
        return false;
      }

      return true;
    } catch (e) {
      _error = 'Error adding to favorites: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  // Remove from favorites
  Future<bool> remove(int itemId) async {
    try {
      if (itemId <= 0) {
        _error = 'Invalid item ID';
        notifyListeners();
        return false;
      }

      final existingIndex =
      _favorites.indexWhere((item) => item.itemId == itemId);
      if (existingIndex == -1) {
        _error = 'Item not found in favorites';
        notifyListeners();
        return false;
      }

      final removedItem = _favorites.removeAt(existingIndex);
      notifyListeners();

      final success = await _favoriteService.removeFromFavorite(itemId);
      if (!success) {
        _favorites.insert(existingIndex, removedItem);
        _error = 'Failed to remove from favorites';
        notifyListeners();
        return false;
      }

      return true;
    } catch (e) {
      _error = 'Error removing from favorites: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  // Remove current selected item
  Future<bool> removeCurrentItem() async {
    if (_currentSelectedItem == null) return false;
    bool success = await remove(_currentSelectedItem!.itemId);
    if (success) clearCurrentItem();
    return success;
  }

  // Check if item is already a favorite by ID
  bool isFavorite(int itemId) {
    return _favorites.any((element) => element.itemId == itemId);
  }

  // Get item ID by title (optional)
  int getItemIdByTitle(String title) {
    try {
      return _favorites.firstWhere((item) => item.title == title).itemId;
    } catch (e) {
      if (kDebugMode) {
        print("Item not found in favorites: $title");
      }
      return -1;
    }
  }
}

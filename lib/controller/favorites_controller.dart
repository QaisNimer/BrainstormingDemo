import 'package:flutter/material.dart';
import '../model/favorite_model/favorite_model.dart';
import '../service/favorite/favorite_service.dart';

class FavoritesController with ChangeNotifier {
  final FavoriteService _favoriteService = FavoriteService();
  final List<FavoriteItem> _favorites = [];
  bool _isLoading = false;
  String _error = '';

  // Mock client ID - in a real app, this would come from authentication
  final int _clientId = 1;

  List<FavoriteItem> get favorites => _favorites;
  bool get isLoading => _isLoading;
  String get error => _error;

  // Load favorites from API
  Future<void> loadFavorites() async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      final favoritesList = await _favoriteService.getFavorites(_clientId);

      _favorites.clear();
      for (var favorite in favoritesList) {
        if (favorite.title != null &&
            favorite.description != null &&
            favorite.price != null &&
            favorite.imagePath != null) {
          _favorites.add(favorite.toFavoriteItem());
        }
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  // Add to favorites both locally and on the server
  Future<void> add(FavoriteItem item, int itemId) async {
    try {
      // Check if it's already a favorite
      if (isFavorite(item.title)) return;

      // Add locally first for responsive UI
      _favorites.add(item);
      notifyListeners();

      // Add to server
      final success = await _favoriteService.addToFavorite(itemId, _clientId);

      if (!success) {
        // If server operation failed, remove from local list
        _favorites.removeWhere((element) => element.title == item.title);
        _error = 'Failed to add to favorites';
        notifyListeners();
      }
    } catch (e) {
      // If there was an error, revert the local change
      _favorites.removeWhere((element) => element.title == item.title);
      _error = e.toString();
      notifyListeners();
    }
  }

  // Remove from favorites both locally and on the server
  Future<void> remove(String title, int itemId) async {
    try {
      // Store the item in case we need to restore it
      final item = _favorites.firstWhere((element) => element.title == title);
      final index = _favorites.indexOf(item);

      // Remove locally first for responsive UI
      _favorites.removeWhere((element) => element.title == title);
      notifyListeners();

      // Remove on server
      final success = await _favoriteService.removeFromFavorite(itemId);

      if (!success) {
        // If server operation failed, restore the local item
        if (index >= 0 && index <= _favorites.length) {
          _favorites.insert(index, item);
        } else {
          _favorites.add(item);
        }
        _error = 'Failed to remove from favorites';
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      loadFavorites(); // Reload to ensure consistency
    }
  }

  bool isFavorite(String title) {
    return _favorites.any((element) => element.title == title);
  }

  // Get item ID by title (this would normally use a mapping from your API)
  // This is a placeholder method since we don't have the actual mapping
  int getItemIdByTitle(String title) {
    // In a real application, you would have a mapping or fetch this from the API
    // For now, we'll use a simple hash of the title as a mock
    return title.hashCode.abs() % 1000;
  }
}
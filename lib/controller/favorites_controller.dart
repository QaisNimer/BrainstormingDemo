import 'package:flutter/foundation.dart';
import '../model/favorite_model/favorite_model.dart';
import '../service/favorite/favorite_service.dart';

class FavoritesController with ChangeNotifier {
  final FavoriteService _favoriteService = FavoriteService();
  final List<FavoriteItem> _favorites = [];
  bool _isLoading = false;
  String _error = '';
  FavoriteItem? _currentSelectedItem; // Track current item for removal dialog

  // Mock client ID - in a real app, this would come from authentication
  final int _clientId = 1;

  List<FavoriteItem> get favorites => _favorites;
  bool get isLoading => _isLoading;
  String get error => _error;
  FavoriteItem? get currentSelectedItem => _currentSelectedItem;

  // Constructor
  FavoritesController() {
    // Initialize by loading favorites
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

  // Load favorites from API with improved error handling
  Future<void> loadFavorites() async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      if (kDebugMode) {
        print("Fetching favorites for client: $_clientId");
      }

      // Debug API connection first
      if (kDebugMode) {
        await _favoriteService.debugApiConnection();
      }

      final favoritesList = await _favoriteService.getFavorites(_clientId);

      if (kDebugMode) {
        print("Received ${favoritesList.length} favorites from API");
      }

      _favorites.clear();
      for (var favorite in favoritesList) {
        // Convert FavoriteModel to FavoriteItem using the method we added
        _favorites.add(favorite.toFavoriteItem());
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print("Error in loadFavorites: $e");
      }
      _isLoading = false;
      _error = 'Error loading favorites: ${e.toString()}';
      notifyListeners();
    }
  }

  // Add to favorites both locally and on the server
  Future<bool> add(FavoriteItem item, int itemId) async {
    try {
      // Check if it's already a favorite
      if (isFavorite(item.title)) return true;

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
        return false;
      }

      return true;
    } catch (e) {
      if (kDebugMode) {
        print("Error adding to favorites: $e");
      }

      // If there was an error, revert the local change
      _favorites.removeWhere((element) => element.title == item.title);
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Remove from favorites both locally and on the server
  Future<bool> remove(String title, int itemId) async {
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
        return false;
      }

      return true;
    } catch (e) {
      if (kDebugMode) {
        print("Error removing from favorites: $e");
      }
      _error = e.toString();
      loadFavorites(); // Reload to ensure consistency
      return false;
    }
  }

  // Remove current selected item using the dialog
  Future<bool> removeCurrentItem() async {
    if (_currentSelectedItem == null) {
      return false;
    }

    try {
      bool success = await remove(_currentSelectedItem!.title, _currentSelectedItem!.itemId);
      clearCurrentItem();
      return success;
    } catch (e) {
      if (kDebugMode) {
        print("Error removing current item: $e");
      }
      return false;
    }
  }

  bool isFavorite(String title) {
    return _favorites.any((element) => element.title == title);
  }

  // Get item ID by title (this would normally use a mapping from your API)
  // This is a placeholder method since we don't have the actual mapping
  int getItemIdByTitle(String title) {
    // First check if we have this item already in our favorites
    final existingItem = _favorites.firstWhere(
          (element) => element.title == title,
      orElse: () => FavoriteItem(
          title: '',
          description: '',
          price: '',
          imagePath: '',
          rating: 0.0,
          itemId: -1
      ),
    );

    if (existingItem.itemId != -1) {
      return existingItem.itemId;
    }

    // In a real application, you would have a mapping or fetch this from the API
    // For now, we'll use a simple hash of the title as a mock
    return title.hashCode.abs() % 1000;
  }
}
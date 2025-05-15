import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../controller/favorites_controller.dart';
import 'favorites_screen.dart';

class RemoveFavouritePage extends StatelessWidget {
  final String? title; // Make this optional to support both constructor patterns
  final int? itemId; // Make this optional to support both constructor patterns

  // Updated constructor to support both usage patterns
  const RemoveFavouritePage({Key? key, this.title, this.itemId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final favoritesController = Provider.of<FavoritesController>(context);

    // Use either the passed title/itemId or get from controller's selected item
    final currentItem = (title != null && itemId != null)
        ? favoritesController.favorites.firstWhere(
          (item) => item.title == title,
      orElse: () => favoritesController.currentSelectedItem!,
    )
        : favoritesController.currentSelectedItem;

    // If no item is selected, go back to favorites screen
    if (currentItem == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const FavoritesScreen())
        );
      });

      // Return a loading indicator while redirecting
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/removefavourite.png',
              fit: BoxFit.cover,
            ),
          ),
          // Blurred overlay
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),
          ),
          // Dialog content
          SafeArea(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(25),
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[900] : Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Item details
                    if (currentItem.imagePath.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          currentItem.imagePath,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (ctx, error, _) => Container(
                            height: 100,
                            width: 100,
                            color: Colors.grey[300],
                            child: const Icon(Icons.image_not_supported),
                          ),
                        ),
                      ),
                    const SizedBox(height: 15),
                    Text(
                      currentItem.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      AppLocalizations.of(context)!.are_you_sure_you_want_to_remove_it_from_favorites,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: isDarkMode ? Colors.white70 : Colors.black87,
                          fontSize: 16
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Action buttons
                    Row(
                      children: [
                        // Cancel button
                        Expanded(
                          child: SizedBox(
                            height: 45,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.grey),
                              ),
                              onPressed: () {
                                favoritesController.clearCurrentItem();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const FavoritesScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                AppLocalizations.of(context)!.cancel,
                                style: TextStyle(
                                    color: isDarkMode ? Colors.white : Colors.black87
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        // Yes button
                        Expanded(
                          child: SizedBox(
                            height: 45,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              onPressed: () async {
                                // Show loading indicator
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );

                                // Get the item ID (either from passed parameter or from current item)
                                final itemIdToRemove = itemId ?? currentItem.itemId;

                                bool success = false;
                                if (title != null && itemId != null) {
                                  // If we were called with direct title/itemId
                                  success = await favoritesController.remove(title!, itemIdToRemove);
                                } else {
                                  // Use the controller's mechanism for current item
                                  success = await favoritesController.removeCurrentItem();
                                }

                                // Close loading dialog
                                Navigator.of(context).pop();

                                // Return to favorites screen
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const FavoritesScreen(),
                                  ),
                                );

                                // Show feedback
                                if (success) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          AppLocalizations.of(context)!.removed_from_favorites,
                                          // Assuming you have this string in your localization
                                        ),
                                        backgroundColor: Colors.green,
                                      )
                                  );
                                }
                              },
                              child: Text(
                                AppLocalizations.of(context)!.yes,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
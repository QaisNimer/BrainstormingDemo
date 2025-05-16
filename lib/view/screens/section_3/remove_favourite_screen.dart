import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../controller/favorites_controller.dart';
import 'favorites_screen.dart';

class RemoveFavouritePage extends StatelessWidget {
  final String? title;
  final int? itemId;

  const RemoveFavouritePage({Key? key, this.title, this.itemId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final favoritesController = Provider.of<FavoritesController>(context);

    // Use the current selected item directly from the controller
    final currentItem = favoritesController.currentSelectedItem;

    if (currentItem == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context); // Pop to go back if no item is selected
      });
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
                    // Item image
                    currentItem.imagePath.isNotEmpty
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        currentItem.imagePath,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
                      ),
                    )
                        : const SizedBox(height: 100), // Placeholder for image
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
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        // Cancel button
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              favoritesController.clearCurrentItem();
                              Navigator.pop(context); // Close the dialog
                            },
                            child: Text(
                              AppLocalizations.of(context)!.cancel,
                              style: TextStyle(
                                color: isDarkMode ? Colors.white : Colors.black87,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        // Yes button
                        Expanded(
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

                              final success = await favoritesController.removeCurrentItem();
                              Navigator.pop(context); // Close loading dialog

                              if (success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      AppLocalizations.of(context)!.removed_from_favorites,
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      AppLocalizations.of(context)!.error_removing_favorite,
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }

                              Navigator.pop(context); // Close the remove dialog
                            },
                            child: Text(
                              AppLocalizations.of(context)!.yes,
                              style: const TextStyle(color: Colors.white),
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

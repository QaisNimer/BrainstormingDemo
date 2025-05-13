import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../controller/favorites_controller.dart';
import 'favorites_screen.dart';

class RemoveFavouritePage extends StatelessWidget {
  final String title;
  final int itemId;

  const RemoveFavouritePage({
    Key? key,
    required this.title,
    required this.itemId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoritesController = Provider.of<FavoritesController>(context, listen: false);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/removefavourite.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),
          ),
          SafeArea(
            child: Center(
              child: Container(
                padding: EdgeInsets.all(25),
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      AppLocalizations.of(
                        context,
                      )!.are_you_sure_you_want_to_remove_it_from_favorites,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black87, fontSize: 16),
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
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
                            builder: (BuildContext context) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );

                          try {
                            // Call API to remove from favorites
                            await favoritesController.remove(title, itemId);

                            // Close loading dialog
                            Navigator.pop(context);

                            // Navigate back to favorites screen
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FavoritesScreen(),
                              ),
                            );
                          } catch (e) {
                            // Close loading dialog
                            Navigator.pop(context);

                            // Show error dialog
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Error'),
                                  content: Text('Failed to remove from favorites. Please try again.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: Text(
                          AppLocalizations.of(context)!.yes,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
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
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodtek/view/screens/section_6/profile_screen.dart';
import 'package:foodtek/view/screens/section_6/track_location_screen.dart';
import 'package:provider/provider.dart';

import '../../../core/theme_provider.dart';
import '../../widgets/bottom_nav_Item_widget.dart';
import '../section_3/favorites_screen.dart';
import '../section_3/home_screen.dart';
import '../section_4/delete_cart_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() => selectedIndex = index);
  }

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    final List<Map<String, String>> messages = [
      {
        "text": AppLocalizations.of(context)!.hello_chatgpt_how_are_you_today,
        "sender": "user",
      },
      {
        "text": AppLocalizations.of(context)!.hello_i_m_fine_how_can_i_help_you,
        "sender": "bot",
      },
      {
        "text":
            AppLocalizations.of(context)!.what_is_the_best_programming_language,
        "sender": "user",
      },
      {
        "text":
            AppLocalizations.of(
              context,
            )!.there_are_many_programming_languages_in_the_market,
        "sender": "bot",
      },
      {
        "text": AppLocalizations.of(context)!.so_explain_to_me_more,
        "sender": "user",
      },
      {
        "text":
            AppLocalizations.of(
              context,
            )!.there_are_many_programming_languages_in_the_market,
        "sender": "bot",
      },
    ];

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.chat),
        backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        foregroundColor: isDarkMode ? Colors.white : Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Container(height: 1, color: Colors.grey.shade300),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              itemCount: messages.length,
              reverse: false,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final bool isUser = msg['sender'] == 'user';
                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 6,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isUser
                              ? Colors.green
                              : (isDarkMode
                                  ? Colors.grey[700]
                                  : Colors.grey[200]),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      msg['text']!,
                      style: TextStyle(
                        color:
                            isUser
                                ? Colors.white
                                : (isDarkMode
                                    ? Colors.white70
                                    : Colors.grey.shade600),
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText:
                          AppLocalizations.of(context)!.write_your_message,
                      hintStyle: TextStyle(
                        color:
                            isDarkMode
                                ? Colors.grey.shade400
                                : Colors.grey.shade600,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      fillColor:
                          isDarkMode ? Colors.grey[800] : Colors.grey[200],
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.green,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () {
                      if (_controller.text.trim().isEmpty) return;
                      setState(() {
                        messages.add({
                          'text': _controller.text.trim(),
                          'sender': 'user',
                        });
                        _controller.clear();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottomNavItemWidget(
                icon: Icons.home,
                label: AppLocalizations.of(context)!.home,
                isSelected: selectedIndex == 0,
                onTap: () {
                  onItemTapped(0);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => HomeScreen()),
                  );
                },
              ),
              BottomNavItemWidget(
                icon: Icons.favorite,
                label: AppLocalizations.of(context)!.favorite,
                isSelected: selectedIndex == 1,
                onTap: () {
                  onItemTapped(1);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const FavoritesScreen()),
                  );
                },
              ),
              const SizedBox(width: 40),
              BottomNavItemWidget(
                icon: Icons.home_work,
                label: AppLocalizations.of(context)!.track,
                isSelected: selectedIndex == 3,
                onTap: () {
                  onItemTapped(3);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TrackLocationScreen(),
                    ),
                  );
                },
              ),
              BottomNavItemWidget(
                icon: Icons.person,
                label: AppLocalizations.of(context)!.profile,
                isSelected: selectedIndex == 4,
                onTap: () {
                  onItemTapped(4);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const ProfileScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DeleteCartScreen()),
            ),
        child: const Icon(Icons.shopping_cart, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

import 'package:flutter/material.dart';
import 'search_screen.dart';
import 'new_chat_screen.dart';
import 'status_screen.dart';
import 'calls_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Chats tab content
  Widget _buildChatsTab() {
    return Column(
      children: [
        // Header with title and search icon
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 16, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Chats',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B1B3A),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.search, size: 28),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        // Empty body area for future chat list
        const Expanded(child: SizedBox()),
      ],
    );
  }

  // Get current screen based on selected index
  Widget _getCurrentScreen() {
    switch (_selectedIndex) {
      case 0:
        return _buildChatsTab();
      case 1:
        return const StatusScreen();
      case 2:
        return const CallsScreen();
      case 3:
        return const ProfileScreen();
      default:
        return _buildChatsTab();
    }
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: _getCurrentScreen()),
      // Floating action button for new chat - only show on chats tab
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewChatScreen(),
                  ),
                );
              },
              backgroundColor: const Color(0xFF3B3B3B),
              elevation: 3,
              shape: const CircleBorder(),
              child: const Icon(
                Icons.add_comment,
                color: Colors.white,
                size: 24,
              ),
            )
          : null,
      // Bottom navigation bar
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onBottomNavTap,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF3B3B3B),
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.access_time), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.call), label: ''),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}

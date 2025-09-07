import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:indomgram/screens/home_screen.dart';
import 'package:indomgram/screens/discover_screen.dart';
import 'package:indomgram/screens/create_screen.dart';
import 'package:indomgram/screens/bharat_reels_screen.dart';
import 'package:indomgram/screens/profile_screen.dart';
import 'package:indomgram/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(const BharatSocialApp());
}

class BharatSocialApp extends StatelessWidget {
  const BharatSocialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const MainDashboard(),
    );
  }
}

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _animationController;

  final List<Widget> _screens = [
    const HomeScreen(),
    const DiscoverScreen(), // Renamed from SearchScreen
    const CreateScreen(), // Renamed from AddScreen
    const BharatReelsScreen(), // Renamed from ReelsScreen
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      // Animate the create button
      _animationController.forward(from: 0.0);
      // Show creation dialog/bottom sheet
      _showCreateOptions();
      return;
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  void _showCreateOptions() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Create New',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.all(20),
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: [
                  _buildCreateOption(
                    'Post',
                    Icons.image,
                    AppTheme.indianOrange,
                  ),
                  _buildCreateOption(
                    'Bharat Reel',
                    Icons.video_library,
                    AppTheme.indianGreen,
                  ),
                  _buildCreateOption(
                    'Story',
                    Icons.timelapse,
                    AppTheme.indianBlue,
                  ),
                  _buildCreateOption('Live', Icons.live_tv, Colors.red),
                  _buildCreateOption('Article', Icons.article, Colors.purple),
                  _buildCreateOption('Poll', Icons.poll, Colors.amber),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateOption(String title, IconData icon, Color color) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        // Handle specific creation option
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Remove AppBar for home screen (index 0) since HomeScreen has its own AppBar
      appBar: _selectedIndex != 0
          ? AppBar(
              title: _getScreenTitle(_selectedIndex),
              backgroundColor: Theme.of(context).colorScheme.surface,
              elevation: 0,
            )
          : null,
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: NavigationBar(
          onDestinationSelected: _onItemTapped,
          selectedIndex: _selectedIndex,
          backgroundColor: Theme.of(context).colorScheme.surface,
          elevation: 0,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          destinations: [
            const NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            const NavigationDestination(
              icon: Icon(Icons.explore_outlined),
              selectedIcon: Icon(Icons.explore),
              label: 'Discover',
            ),
            NavigationDestination(
              icon: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _animationController.value * 0.5,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppTheme.indianOrange, AppTheme.indianGreen],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  );
                },
              ),
              label: 'Create',
            ),
            const NavigationDestination(
              icon: Icon(Icons.auto_awesome_outlined),
              selectedIcon: Icon(Icons.auto_awesome),
              label: 'Bharat Reels',
            ),
            const NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to get the title for each screen
  Widget _getScreenTitle(int index) {
    switch (index) {
      case 1:
        return const Text('Discover Bharat');
      case 2:
        return const Text('Create Content');
      case 3:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bharat',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppTheme.indianOrange,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'REELS',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      case 4:
        return const Text('Profile');
      default:
        return const Text('IND OM Gram');
    }
  }
}

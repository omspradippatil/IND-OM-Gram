import 'package:flutter/material.dart';
import 'package:indomgram/theme/app_theme.dart';

class BharatReelsScreen extends StatefulWidget {
  const BharatReelsScreen({super.key});

  @override
  State<BharatReelsScreen> createState() => _BharatReelsScreenState();
}

class _BharatReelsScreenState extends State<BharatReelsScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _demoReels = [
    {
      'username': 'indianyogi',
      'title': 'Ancient wisdom of Yoga',
      'description': 'Learn the traditional yoga postures to improve your wellbeing. #yoga #wellness #indianculture',
      'likes': '250K',
      'comments': '1.2K',
      'music': 'Traditional Indian Flute',
      'videoBg': 'https://picsum.photos/id/1000/800/1600',
    },
    {
      'username': 'incredibleindia',
      'title': 'Wonders of Rajasthan',
      'description': 'Exploring the majestic forts and palaces of Rajasthan. #travel #heritage #rajasthan',
      'likes': '489K',
      'comments': '3.4K',
      'music': 'Rajasthani Folk Music',
      'videoBg': 'https://picsum.photos/id/1036/800/1600',
    },
    {
      'username': 'bharatiya_chef',
      'title': 'Authentic Butter Chicken Recipe',
      'description': 'Learn how to make the perfect butter chicken at home. #indianfood #recipe #cooking',
      'likes': '732K',
      'comments': '5.1K',
      'music': 'Cooking With Spices - Soundtrack',
      'videoBg': 'https://picsum.photos/id/1080/800/1600',
    },
    {
      'username': 'tech_bharat',
      'title': 'Indian Startups Changing the World',
      'description': 'Discover how Indian tech startups are revolutionizing global markets. #technology #startups #innovation',
      'likes': '150K',
      'comments': '894',
      'music': 'Digital India - Soundtrack',
      'videoBg': 'https://picsum.photos/id/180/800/1600',
    },
    {
      'username': 'classical_dance',
      'title': 'Bharatanatyam Expressions',
      'description': 'The beauty and grace of Bharatanatyam dance form. #classicaldance #culture #arts',
      'likes': '362K',
      'comments': '2.7K',
      'music': 'Carnatic Classical Raga',
      'videoBg': 'https://picsum.photos/id/1024/800/1600',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bharat',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
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
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt, color: Colors.white),
            onPressed: () {
              // Navigate to camera/reel creation
            },
          ),
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemCount: _demoReels.length,
        itemBuilder: (context, index) {
          final reel = _demoReels[index];
          return _buildReelItem(reel, index);
        },
      ),
    );
  }

  Widget _buildReelItem(Map<String, dynamic> reel, int index) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Video placeholder
        Image.network(
          reel['videoBg'],
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.black,
              child: const Center(
                child: Icon(
                  Icons.video_library,
                  size: 64,
                  color: Colors.white54,
                ),
              ),
            );
          },
        ),
        
        // Gradient overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.2),
                Colors.transparent,
                Colors.black.withOpacity(0.4),
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
        ),
        
        // Content
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User info and description
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage('https://picsum.photos/id/${800 + index}/100'),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '@${reel['username']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Follow',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    reel['title'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    reel['description'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.music_note,
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          reel['music'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        
        // Right side action buttons
        Positioned(
          right: 16,
          bottom: 100,
          child: Column(
            children: [
              _buildActionButton(Icons.favorite, reel['likes']),
              _buildActionButton(Icons.comment, reel['comments']),
              _buildActionButton(Icons.share, 'Share'),
              _buildActionButton(Icons.bookmark_border, 'Save'),
              _buildActionButton(Icons.more_horiz, 'More'),
            ],
          ),
        ),
        
        // Progress indicator at top
        Positioned(
          top: MediaQuery.of(context).padding.top + 56,
          left: 0,
          right: 0,
          child: Row(
            children: List.generate(
              _demoReels.length,
              (i) => Expanded(
                child: Container(
                  height: 2,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: i == _currentPage
                        ? Colors.white
                        : Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 28,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:indomgram/models/post_model.dart';
import 'package:indomgram/models/user_model.dart';
import 'package:indomgram/utils/dummy_data.dart';
import 'package:indomgram/widgets/post_card.dart';
import 'package:indomgram/widgets/story_item.dart';
import 'package:indomgram/screens/messages_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<User> _users;
  late List<Post> _posts;

  @override
  void initState() {
    super.initState();
    _users = DummyData.users;
    _posts = DummyData.posts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'IND OM Gram',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.send_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MessagesScreen()),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Simulate refresh
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            // Shuffle posts to simulate new content
            _posts = List.from(_posts)..shuffle();
          });
        },
        child: CustomScrollView(
          slivers: [
            // Stories
            SliverToBoxAdapter(
              child: SizedBox(
                height: 120,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: _users.length,
                  itemBuilder: (context, index) {
                    final user = _users[index];
                    return StoryItem(
                      user: user,
                      isCurrentUser: index == 0,
                      hasStory: true,
                      isViewed: index == 3 || index == 4,
                    );
                  },
                ),
              ),
            ),
            
            // Divider
            const SliverToBoxAdapter(
              child: Divider(height: 1),
            ),
            
            // Posts
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final post = _posts[index];
                  return PostCard(post: post);
                },
                childCount: _posts.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

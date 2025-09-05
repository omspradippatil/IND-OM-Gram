import 'package:flutter/material.dart';
import 'package:indomgram/models/user_model.dart';

class ProfileHeader extends StatelessWidget {
  final User user;
  
  const ProfileHeader({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile info section
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile picture
              Stack(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(user.profileImageUrl),
                  ),
                  if (user.isVerified)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.verified,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                ],
              ),
              
              const SizedBox(width: 24),
              
              // Stats (posts, followers, following)
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatColumn('Posts', user.posts),
                    _buildStatColumn('Followers', user.followers),
                    _buildStatColumn('Following', user.following),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        // Name and bio
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              if (user.bio.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(user.bio),
                ),
            ],
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Action buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 0,
                  ),
                  child: const Text('Edit Profile'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 0,
                  ),
                  child: const Text('Share Profile'),
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Story highlights
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            itemCount: 6, // Number of highlights + "Add new" button
            itemBuilder: (context, index) {
              // First item is "Add new" button
              if (index == 0) {
                return _buildHighlightItem(
                  icon: Icons.add,
                  label: 'New',
                  isAddButton: true,
                );
              } else {
                // Other items are highlights
                return _buildHighlightItem(
                  imageUrl: 'https://picsum.photos/id/${100 + index}/100',
                  label: index == 1 ? 'Flutter' : index == 2 ? 'Coding' : index == 3 ? 'Travel' : index == 4 ? 'Food' : 'Nature',
                );
              }
            },
          ),
        ),
      ],
    );
  }
  
  Widget _buildStatColumn(String label, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _formatCount(count),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
  
  Widget _buildHighlightItem({
    String? imageUrl,
    IconData? icon,
    required String label,
    bool isAddButton = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey[300]!,
                width: 1,
              ),
            ),
            child: isAddButton
                ? Center(
                    child: Icon(
                      icon,
                      size: 28,
                      color: Colors.grey[800],
                    ),
                  )
                : CircleAvatar(
                    backgroundImage: NetworkImage(imageUrl!),
                    radius: 30,
                  ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
  
  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    } else {
      return count.toString();
    }
  }
}

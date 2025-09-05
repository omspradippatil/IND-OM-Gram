import 'package:flutter/material.dart';
import 'package:indomgram/models/user_model.dart';

class StoryItem extends StatelessWidget {
  final User user;
  final bool isCurrentUser;
  final bool hasStory;
  final bool isViewed;
  
  const StoryItem({
    super.key,
    required this.user,
    this.isCurrentUser = false,
    this.hasStory = true,
    this.isViewed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: hasStory && !isViewed
                  ? const LinearGradient(
                      colors: [Colors.purple, Colors.orange, Colors.pink],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    )
                  : null,
              color: isViewed ? Colors.grey[300] : null,
            ),
            child: Container(
              padding: const EdgeInsets.all(3.0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Stack(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.profileImageUrl),
                    radius: 35,
                  ),
                  if (isCurrentUser)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            isCurrentUser ? 'Your Story' : user.username,
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
}

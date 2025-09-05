import 'package:flutter/material.dart';
import 'package:indomgram/models/reel_model.dart';

class ReelItem extends StatelessWidget {
  final Reel reel;
  final bool isActive;
  
  const ReelItem({
    super.key,
    required this.reel,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Video placeholder (would be actual video in a real app)
        Image.network(
          reel.thumbnailUrl,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.black,
              child: const Center(child: Icon(Icons.error, color: Colors.white)),
            );
          },
        ),
        
        // Gradient overlay at the bottom
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        
        // User info and caption at the bottom
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User info
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(reel.user.profileImageUrl),
                    radius: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    reel.user.username,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (reel.user.isVerified) const SizedBox(width: 4),
                  if (reel.user.isVerified) 
                    const Icon(Icons.verified, color: Colors.blue, size: 14),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                    child: const Text('Follow'),
                  ),
                ],
              ),
              
              const SizedBox(height: 8),
              
              // Caption
              Text(
                reel.caption,
                style: const TextStyle(color: Colors.white),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              
              const SizedBox(height: 8),
              
              // Audio info
              Row(
                children: [
                  const Icon(Icons.music_note, color: Colors.white, size: 16),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      reel.audio,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        // Actions on the right side
        Positioned(
          bottom: 16,
          right: 16,
          child: Column(
            children: [
              _buildActionButton(Icons.favorite_outline, reel.likes.toString()),
              _buildActionButton(Icons.chat_bubble_outline, reel.comments.toString()),
              _buildActionButton(Icons.send_outlined, reel.shares.toString()),
              _buildActionButton(Icons.more_horiz, ''),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    reel.thumbnailUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildActionButton(IconData icon, String count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 28),
          if (count.isNotEmpty) 
            Text(
              count,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
        ],
      ),
    );
  }
}

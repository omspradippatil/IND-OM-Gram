import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Post'),
            Tab(text: 'Story'),
            Tab(text: 'Reel'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPostTab(),
          _buildStoryTab(),
          _buildReelTab(),
        ],
      ),
    );
  }
  
  Widget _buildPostTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _buildImagePicker(),
          ),
          const SizedBox(height: 16),
          _buildCaptionInput(),
          const SizedBox(height: 16),
          _buildLocationInput(),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Share Post'),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStoryTab() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: _buildImagePicker(isStory: true),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCircularButton(Icons.text_fields, 'Text'),
              _buildCircularButton(Icons.music_note, 'Music'),
              _buildCircularButton(Icons.brush, 'Draw'),
              _buildCircularButton(Icons.face, 'Effects'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
            child: const Text('Share Story'),
          ),
        ),
      ],
    );
  }
  
  Widget _buildReelTab() {
    return Column(
      children: [
        Expanded(
          child: Stack(
            fit: StackFit.expand,
            children: [
              _buildImagePicker(isReel: true),
              Positioned(
                bottom: 16,
                left: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCircularButton(Icons.music_note, 'Audio'),
                    const SizedBox(height: 16),
                    _buildCircularButton(Icons.speed, 'Speed'),
                    const SizedBox(height: 16),
                    _buildCircularButton(Icons.timer, 'Timer'),
                  ],
                ),
              ),
              Positioned(
                bottom: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildCircularButton(Icons.filter, 'Effects'),
                    const SizedBox(height: 16),
                    _buildCircularButton(Icons.flash_on, 'Flash'),
                    const SizedBox(height: 16),
                    _buildCircularButton(Icons.flip_camera_ios, 'Flip'),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
            child: const Text('Next'),
          ),
        ),
      ],
    );
  }
  
  Widget _buildCircularButton(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.black54,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(icon, color: Colors.white),
            onPressed: () {},
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
  
  Widget _buildImagePicker({bool isStory = false, bool isReel = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(isStory ? 0 : 8),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isReel ? Icons.videocam : Icons.add_photo_alternate,
              size: 64,
              color: Colors.grey[800],
            ),
            const SizedBox(height: 16),
            Text(
              isReel 
                  ? 'Tap to record a new reel'
                  : isStory 
                      ? 'Tap to add to your story' 
                      : 'Tap to add photos or videos',
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildCaptionInput() {
    return TextField(
      maxLines: 3,
      decoration: InputDecoration(
        hintText: 'Write a caption...',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
  
  Widget _buildLocationInput() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Add location',
        prefixIcon: const Icon(Icons.location_on_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

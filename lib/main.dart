import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF131520),
        cardColor: const Color(0xFF1D2030),
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: [
            // --- FOTO PROFIL ---
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFF2C3148),
              child: CircleAvatar(
                radius: 46,
                backgroundImage: AssetImage('profile.jpg'),
              ),
            ),
            const SizedBox(height: 16),

            // --- NAMA & NIM ---
            const Text(
              'Muhammad Charis Putra Jaya',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 6),
            const Text(
              'NIM 2111081',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 12),

            // --- BADGE JURUSAN ---
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF2B3252),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.school_outlined, size: 18, color: Color(0xFF8A99E3)),
                  SizedBox(width: 8),
                  Text(
                    'Teknik Informatika',
                    style: TextStyle(color: Color(0xFF8A99E3), fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // --- SKILLS ---
            _buildSectionTitle('Skills'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: const [
                SkillChip(label: 'JavaScript'),
                SkillChip(label: 'React'),
                SkillChip(label: 'Tailwind CSS'),
                SkillChip(label: 'UI/UX'),
                SkillChip(label: 'Node.js'),
                SkillChip(label: 'Git'),
                SkillChip(label: 'Figma'),
                SkillChip(label: 'Networking'),
                SkillChip(label: 'Mikrotik'),
              ],
            ),
            const SizedBox(height: 28),

            // --- CONTACT ---
            _buildSectionTitle('Contact'),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                ContactTile(icon: Icons.email_outlined, subtitle: 'chars.putra29@gmail.com'),
                ContactTile(icon: Icons.phone_outlined, subtitle: '+62 851 6162 9012'),
                ContactTile(icon: Icons.link, subtitle: 'linkedin.com/in/charis-putra-9557b3375/'),
                ContactTile(icon: Icons.code, subtitle: 'github.com/chars-sudo'),
              ],
            ),
            const SizedBox(height: 28),

            // --- ABOUT ME ---
            _buildSectionTitle('About Me'),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () {
                showVideoDialog(
                  context,
                  'assets/about.mp4',
                );
              },
              child: Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                    image: AssetImage('Thumbnail.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 36),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Perjalanan belajar & project pilihan saya.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}

// --- FUNGSI SHOW VIDEO DIALOG ---
void showVideoDialog(BuildContext context, String videoUrl) {
  showDialog(
    context: context,
    builder: (context) => VideoPlayerDialog(videoUrl: videoUrl),
  );
}

// --- WIDGET DIALOG PEMUTAR VIDEO ---
class VideoPlayerDialog extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerDialog({super.key, required this.videoUrl});

  @override
  State<VideoPlayerDialog> createState() => _VideoPlayerDialogState();
}

class _VideoPlayerDialogState extends State<VideoPlayerDialog> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    );

    _videoPlayerController.initialize().then((_) {
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: _videoPlayerController.value.aspectRatio,
        autoPlay: true,
        looping: false,
      );
      setState(() {});
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1D2030),
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 250,
        child: _chewieController != null &&
                _chewieController!.videoPlayerController.value.isInitialized
            ? Chewie(controller: _chewieController!)
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

// --- CUSTOM WIDGET: CHIP SKILL ---
class SkillChip extends StatelessWidget {
  final String label;
  const SkillChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1D2030),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white70, fontSize: 13),
      ),
    );
  }
}

// --- CUSTOM WIDGET: CONTACT TILE ---
class ContactTile extends StatelessWidget {
  final IconData icon;
  final String subtitle;

  const ContactTile({super.key, required this.icon, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 65,
          height: 55,
          decoration: BoxDecoration(
            color: const Color(0xFF1D2030),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white10),
          ),
          child: Icon(icon, color: const Color(0xFF8A99E3), size: 22),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 70,
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 9, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}

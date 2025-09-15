import 'package:flutter/material.dart';
import 'package:fitness_app/core/constants/app_colors.dart';

class CoachContactScreen extends StatelessWidget {
  const CoachContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Coach Contact'),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCoachCard(
            name: 'Sarah Johnson',
            specialty: 'Strength Training',
            rating: 4.9,
            image: 'assets/images/coach1.jpg',
          ),
          const SizedBox(height: 16),
          _buildCoachCard(
            name: 'Mike Chen',
            specialty: 'Nutrition Specialist',
            rating: 4.7,
            image: 'assets/images/coach2.jpg',
          ),
          const SizedBox(height: 16),
          _buildCoachCard(
            name: 'Emma Wilson',
            specialty: 'Yoga & Mobility',
            rating: 4.8,
            image: 'assets/images/coach3.jpg',
          ),
          const SizedBox(height: 32),
          const Text(
            'Contact Options',
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          _buildContactOptions(),
        ],
      ),
    );
  }

  Widget _buildCoachCard({
    required String name,
    required String specialty,
    required double rating,
    required String image,
  }) {
    return Card(
      color: Colors.grey[850],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(image),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    specialty,
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        rating.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.message, color: AppColors.primary),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactOptions() {
    return Column(
      children: [
        _buildContactTile(
          icon: Icons.email,
          title: 'Email Support',
          subtitle: 'support@uplift.ai',
          onTap: () {},
        ),
        _buildContactTile(
          icon: Icons.phone,
          title: 'Call Support',
          subtitle: '+1 (800) 123-4567',
          onTap: () {},
        ),
        _buildContactTile(
          icon: Icons.chat_bubble,
          title: 'Live Chat',
          subtitle: 'Available 24/7',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildContactTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      color: Colors.grey[850],
      margin: const EdgeInsets.only(top: 12),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
        trailing: const Icon(Icons.chevron_right, color: Colors.white),
        onTap: onTap,
      ),
    );
  }
}

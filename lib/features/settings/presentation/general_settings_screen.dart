import 'package:flutter/material.dart';
import 'package:fitness_app/core/constants/app_colors.dart';

class GeneralSettingsScreen extends StatelessWidget {
  const GeneralSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 24),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'General Settings',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Content
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildSectionHeader('App Preferences'),
                  _buildSettingItem(
                    icon: Icons.language,
                    title: 'Language',
                    value: 'English',
                    onTap: () {},
                  ),
                  _buildSettingItem(
                    icon: Icons.access_time,
                    title: 'Time Format',
                    value: '24-hour',
                    onTap: () {},
                  ),
                  _buildSettingItem(
                    icon: Icons.straighten,
                    title: 'Units',
                    value: 'Metric (kg, cm)',
                    onTap: () {},
                  ),
                  const SizedBox(height: 24),
                  _buildSectionHeader('Display'),
                  _buildSettingItem(
                    icon: Icons.text_fields,
                    title: 'Font Size',
                    value: 'Medium',
                    onTap: () {},
                  ),
                  _buildSettingItem(
                    icon: Icons.grid_view,
                    title: 'App Layout',
                    value: 'Default',
                    onTap: () {},
                  ),
                  const SizedBox(height: 24),
                  _buildSectionHeader('Data'),
                  _buildSettingItem(
                    icon: Icons.backup,
                    title: 'Backup Settings',
                    onTap: () {},
                  ),
                  _buildSettingItem(
                    icon: Icons.restore,
                    title: 'Restore Defaults',
                    onTap: () {},
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    String? value,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (value != null)
              Text(
                value,
                style: const TextStyle(color: Colors.grey),
              ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}

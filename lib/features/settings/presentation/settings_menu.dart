import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitness_app/core/services/auth_service.dart';
import 'package:fitness_app/features/settings/presentation/account_settings_screen.dart';
import 'package:fitness_app/features/settings/presentation/general_settings_screen.dart';
import 'package:fitness_app/features/settings/presentation/notification_settings_screen.dart';
import 'package:fitness_app/features/settings/presentation/personal_info_screen.dart';
import 'package:fitness_app/features/settings/presentation/coach_contact_screen.dart';
import 'package:fitness_app/features/settings/presentation/dark_mode_screen.dart';
import 'package:fitness_app/features/settings/presentation/linked_devices_screen.dart';
import 'package:fitness_app/features/settings/presentation/security_privacy_screen.dart';
import 'package:fitness_app/features/settings/presentation/main_security_screen.dart';

class SettingsMenu extends StatelessWidget {
  const SettingsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.settings, color: Colors.white),
      ),
      offset: const Offset(0, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      color: Colors.grey.shade900,
      onSelected: (value) => _handleMenuSelection(context, value),
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem<String>(
            enabled: false,
            height: 40,
            child: Text(
              'General',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          _buildMenuItem(context,
              icon: Icons.person_outline,
              title: 'Account Settings',
              value: 'account'),
          _buildMenuItem(context,
              icon: Icons.settings_outlined,
              title: 'General',
              value: 'general'),
          _buildMenuItem(context,
              icon: Icons.notifications_outlined,
              title: 'Notifications',
              value: 'notifications'),
          _buildMenuItem(context,
              icon: Icons.perm_identity,
              title: 'Personal Info',
              value: 'personal_info'),
          _buildMenuItem(context,
              icon: Icons.sports_handball,
              title: 'Coach Contact',
              value: 'coach'),
          _buildDarkModeMenuItem(context),
          _buildMenuItem(context,
              icon: Icons.devices_other,
              title: 'Linked Devices',
              value: 'devices'),
          const PopupMenuItem<String>(
            enabled: false,
            height: 40,
            child: Text(
              'Security & Privacy',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          _buildMenuItem(context,
              icon: Icons.security_outlined,
              title: 'Security & Privacy',
              value: 'security'),
          _buildMenuItem(context,
              icon: Icons.admin_panel_settings_outlined,
              title: 'Main Security',
              value: 'main_security'),
          const PopupMenuDivider(height: 1),
          _buildMenuItem(context,
              icon: Icons.logout,
              title: 'Logout',
              value: 'logout',
              isLogout: true),
        ];
      },
    );
  }

  PopupMenuItem<String> _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    bool isLogout = false,
  }) {
    return PopupMenuItem<String>(
      value: value,
      height: 48,
      child: Row(
        children: [
          Icon(icon, color: isLogout ? Colors.red : Colors.white, size: 22),
          const SizedBox(width: 12),
          Text(title,
              style: TextStyle(
                  color: isLogout ? Colors.red : Colors.white,
                  fontWeight: FontWeight.w500)),
          if (!isLogout) const Spacer(),
          if (!isLogout)
            Icon(Icons.arrow_forward_ios,
                color: Colors.grey.shade400, size: 16),
        ],
      ),
    );
  }

  PopupMenuItem<String> _buildDarkModeMenuItem(BuildContext context) {
    return PopupMenuItem<String>(
      value: 'dark_mode',
      height: 48,
      child: Row(
        children: [
          const Icon(Icons.dark_mode_outlined, color: Colors.white, size: 22),
          const SizedBox(width: 12),
          const Text('Dark Mode',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
          const Spacer(),
          Switch(
            value: true, // Replace with actual dark mode state
            onChanged: (value) {
              Navigator.pop(context); // Close the menu
              _handleMenuSelection(context, 'dark_mode');
            },
            activeColor: Colors.orange,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }

  void _handleMenuSelection(BuildContext context, String value) {
    Future.delayed(const Duration(milliseconds: 150), () {
      switch (value) {
        case 'account':
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AccountSettingsScreen()));
          break;
        case 'general':
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const GeneralSettingsScreen()));
          break;
        case 'notifications':
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const NotificationSettingsScreen()));
          break;
        case 'personal_info':
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const PersonalInfoScreen()));
          break;
        case 'coach':
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const CoachContactScreen()));
          break;
        case 'dark_mode':
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const DarkModeScreen()));
          break;
        case 'devices':
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const LinkedDevicesScreen()));
          break;
        case 'security':
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const SecurityPrivacyScreen()));
          break;
        case 'main_security':
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const MainSecurityScreen()));
          break;
        case 'logout':
          _confirmLogout(context);
          break;
      }
    });
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.grey.shade900,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.logout, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                const Text('Confirm Logout',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Are you sure you want to logout?',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 16)),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          side: const BorderSide(color: Colors.grey),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () async {
                          Navigator.of(context).pop();
                          await authService.signOut();
                        },
                        child: const Text('Logout'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

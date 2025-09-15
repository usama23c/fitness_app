// import 'package:flutter/material.dart';
// import 'package:fitness_app/core/constants/app_colors.dart';

// class SecurityPrivacyScreen extends StatelessWidget {
//   const SecurityPrivacyScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Security & Privacy'),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           _buildSecurityCard(
//             icon: Icons.lock,
//             title: 'Change Password',
//             onTap: () {},
//           ),
//           _buildSecurityCard(
//             icon: Icons.fingerprint,
//             title: 'Biometric Authentication',
//             trailing: Switch(value: true, onChanged: (value) {}),
//           ),
//           _buildSecurityCard(
//             icon: Icons.visibility_off,
//             title: 'Hide Sensitive Data',
//             trailing: Switch(value: false, onChanged: (value) {}),
//           ),
//           _buildSecurityCard(
//             icon: Icons.history,
//             title: 'Activity History',
//             onTap: () {},
//           ),
//           const SizedBox(height: 24),
//           _buildPrivacySection(),
//         ],
//       ),
//     );
//   }

//   Widget _buildSecurityCard({
//     required IconData icon,
//     required String title,
//     Widget? trailing,
//     VoidCallback? onTap,
//   }) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 16),
//       child: ListTile(
//         leading: Icon(icon, color: AppColors.primary),
//         title: Text(title),
//         trailing: trailing ?? const Icon(Icons.chevron_right),
//         onTap: onTap,
//       ),
//     );
//   }

//   Widget _buildPrivacySection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Privacy Settings',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 16),
//         _buildPrivacyOption(
//           title: 'Data Sharing',
//           subtitle: 'Control what data is shared with our coaches',
//         ),
//         _buildPrivacyOption(
//           title: 'Analytics',
//           subtitle: 'Help improve Uplift.ai by sharing usage data',
//         ),
//         _buildPrivacyOption(
//           title: 'Advertising',
//           subtitle: 'Personalized ads based on your activity',
//         ),
//       ],
//     );
//   }

//   Widget _buildPrivacyOption({
//     required String title,
//     required String subtitle,
//   }) {
//     return ListTile(
//       contentPadding: EdgeInsets.zero,
//       title: Text(title),
//       subtitle: Text(subtitle),
//       trailing: Switch(value: false, onChanged: (value) {}),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:fitness_app/core/constants/app_colors.dart';

class SecurityPrivacyScreen extends StatelessWidget {
  const SecurityPrivacyScreen({super.key});

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
                    'Security & Privacy',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSecurityCard(
                      icon: Icons.lock,
                      title: 'Change Password',
                      onTap: () {},
                    ),
                    _buildSecurityCard(
                      icon: Icons.fingerprint,
                      title: 'Biometric Authentication',
                      trailing: Switch(value: true, onChanged: (value) {}),
                    ),
                    _buildSecurityCard(
                      icon: Icons.visibility_off,
                      title: 'Hide Sensitive Data',
                      trailing: Switch(value: false, onChanged: (value) {}),
                    ),
                    _buildSecurityCard(
                      icon: Icons.history,
                      title: 'Activity History',
                      onTap: () {},
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Privacy Settings',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildPrivacyOption(
                      title: 'Data Sharing',
                      subtitle: 'Control what data is shared with our coaches',
                    ),
                    _buildPrivacyOption(
                      title: 'Analytics',
                      subtitle: 'Help improve Uplift.ai by sharing usage data',
                    ),
                    _buildPrivacyOption(
                      title: 'Advertising',
                      subtitle: 'Personalized ads based on your activity',
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityCard({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title),
        trailing: trailing ?? const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  Widget _buildPrivacyOption({
    required String title,
    required String subtitle,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(title),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 13, color: Colors.grey),
        ),
        trailing: Switch(value: false, onChanged: (value) {}),
      ),
    );
  }
}

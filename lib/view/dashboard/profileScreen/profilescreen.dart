import 'package:flutter/material.dart';
import 'package:fyp_project/navigationScreen/appNavigation.dart';
import 'package:provider/provider.dart';

import '../../../routings/routeName/routes_name.dart';
import '../../../widgets/customProfile/profileHeader/profileheader.dart';
import '../../../widgets/customProfile/profileList/profilelist.dart';
import '../../../view_modal/provider/generalProvider/general_provider.dart';
import '../contactUs/contactUsScreen.dart';
import '../termsAndcondition/termsAndcondition.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final generalProvider =
        Provider.of<GeneralProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: FutureBuilder<Map<String, dynamic>?>(
          future: generalProvider.getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final userData = snapshot.data;
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ProfileHeader(
                    name: userData?['name'] ?? 'User',
                    email: userData?['email'],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Consumer<GeneralProvider>(
                    builder: (context, provider, _) {
                      bool isDark = provider.themeMode == ThemeMode.dark;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isDark ? "Dark Theme" : "Light Theme",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: theme.textTheme.bodyLarge?.color,
                            ),
                          ),
                          Switch(
                            value: isDark,
                            onChanged: (value) {
                              provider.toggleTheme();
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
                ProfileListTile(
                  icon: Icons.lock_outline,
                  color: Colors.blue,
                  title: 'Change Password',
                  onTap: () {
                    AppNavigators.changescreen(
                      context,
                      RouteName.confirmpasswordscreen,
                    );
                  },
                ),
                ProfileListTile(
                  icon: Icons.email_outlined,
                  color: Colors.green,
                  title: 'Contact us',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ContactUsScreen()),
                    );
                  },
                ),
                ProfileListTile(
                  icon: Icons.description_outlined,
                  color: Colors.indigo,
                  title: 'Terms & Conditions',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const TermsAndConditionsScreen()),
                    );
                  },
                ),
                ProfileListTile(
                  icon: Icons.logout,
                  color: Colors.red,
                  title: 'Logout',
                  onTap: () {
                    AppNavigators.changescreen(
                      context,
                      RouteName.loginscreen,
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

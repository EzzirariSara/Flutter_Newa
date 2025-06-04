import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/theme/Colors.dart';
import 'package:flutter_application_1/features/Auth/widgets/AboutSection.dart';
import 'package:flutter_application_1/features/Auth/widgets/EditProfileCard.dart';
import 'package:flutter_application_1/features/Auth/widgets/EditProfileForm.dart';
import 'package:flutter_application_1/features/Auth/widgets/HelpButton.dart';
import 'package:flutter_application_1/features/Auth/widgets/MenuSection.dart';
import 'package:flutter_application_1/features/Auth/widgets/ProfileHeader.dart';
import 'package:flutter_application_1/features/Auth/widgets/SocialSection.dart';
import 'package:flutter_application_1/features/Auth/widgets/VersionInfo.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/profile_controller.dart';
import '../../models/user_model.dart';
import '../auth/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _showEditProfile = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateUserData();
    });
  }

  void _updateUserData() {
    final authController = Provider.of<AuthController>(context, listen: false);
    final profileController = Provider.of<ProfileController>(
      context,
      listen: false,
    );

    final fakeUser = User(
      id: '123456',
      name: 'Sara Ezzirari',
      email: 'saraezzirari26@gmail.com',
      phone: '+212665965083',
      address: '27 Avenue Hassan II',
      city: 'Casablanca',
      postalCode: '20000',
      isPremium: true,
      preferences: {
        'pushNotifications': true,
        'emailPromotions': false,
        'cartReminders': true,
      },
      gender: 'Femme',
    );

    if (authController.isAuthenticated && authController.currentUser != null) {
      profileController.user = authController.currentUser;
    } else {
      profileController.user = fakeUser;
    }
  }

  void _logout() {
    final authController = Provider.of<AuthController>(context, listen: false);
    authController.logout();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void _toggleEditProfile() {
    setState(() {
      _showEditProfile = !_showEditProfile;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);
    final profileController = Provider.of<ProfileController>(context);

    final user =
        profileController.user ??
        User(
          id: '123456',
          name: 'Sara Ezzirari',
          email: 'saraezzirari26@gmail.com',
          phone: '+212665965083',
          address: '27 Avenue Hassan II',
          city: 'Casablanca',
          postalCode: '20000',
          isPremium: true,
          preferences: {
            'pushNotifications': true,
            'emailPromotions': false,
            'cartReminders': true,
          },
          gender: 'Femme',
        );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Mon compte',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileHeader(
              user: user,
              onEdit: _toggleEditProfile,
            ),
            if (_showEditProfile) 
              EditProfileCard(
                user: user,
                onClose: _toggleEditProfile,
              ),

            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Mon compte',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Menusection(),
            const SizedBox(height: 20),
            Helpbutton(),
            const SizedBox(height: 20),
            Aboutsection(),
            const SizedBox(height: 30),
            SocialSection(),
            const SizedBox(height: 20),
            // Versioninfo(),
          ],
        ),
      ),
    );
  }



}
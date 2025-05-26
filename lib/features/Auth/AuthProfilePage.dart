import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/theme/Colors.dart';
import 'package:flutter_application_1/features/Auth/pages/profile/profile_page.dart';
import 'package:provider/provider.dart';
import 'controllers/auth_controller.dart';
import 'controllers/profile_controller.dart';
class Authprofilepage extends StatefulWidget {
  const Authprofilepage({Key? key}) : super(key: key);

  @override
  _AuthprofilepageState createState() => _AuthprofilepageState();
}

class _AuthprofilepageState extends State<Authprofilepage> {
 @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => ProfileController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mon Profil',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Roboto',
        ),
        home: const ProfilePage(),
      ),
    );
  }
}
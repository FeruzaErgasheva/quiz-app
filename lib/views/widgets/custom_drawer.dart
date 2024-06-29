import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lesson_65/views/screens/home_screen.dart';
import 'package:lesson_65/views/screens/settings_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blue.shade900,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const DrawerHeader(
            child: SizedBox(),
          ),
          ListTile(
            title: const Text(
              "Home",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () => Navigator.of(context).pushReplacement(
              CupertinoPageRoute(
                builder: (context) => HomeScreen(),
              ),
            ),
          ),
          ListTile(
            title: const Text(
              "Admin page",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () => Navigator.of(context).pushReplacement(
              CupertinoPageRoute(
                builder: (context) => QuestionForm(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:domedia/view/genaral_screens.dart/settings.dart';

class HomeAppBar extends StatelessWidget  implements PreferredSizeWidget{
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const Border(
        bottom: BorderSide(
          color: Colors.grey,
          width: 0.4,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const SettingsScreen();
                },
              ),
            );
          },
          child: const Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              IconlyBold.setting,
              color: Colors.black,
              weight: 20,
            ),
          ),
        )
      ],
      title: Text(
        "Home",
        style: GoogleFonts.raleway(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}

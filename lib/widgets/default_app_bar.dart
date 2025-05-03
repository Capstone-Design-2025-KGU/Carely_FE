import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  Color? color;
  List<Widget>? actions;
  final bool isHome;

  DefaultAppBar({
    super.key,
    required this.title,
    this.color,
    this.actions,
    this.isHome = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
      ),
      leadingWidth: 72,
      leading:
          isHome
              ? Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: SvgPicture.asset(
                  'assets/images/logo.svg',
                  width: 40.0,
                  height: 40.0,
                  fit: BoxFit.contain,
                ),
              )
              : IconButton(
                icon: const Icon(CupertinoIcons.back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
      backgroundColor: color ?? Colors.white,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

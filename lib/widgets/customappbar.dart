import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onTap;
  final AppBar appBar;
  final Widget actions;

  const CustomAppBar({Key key, this.onTap, this.appBar, this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GestureDetector(onTap: onTap, child: appBar));
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

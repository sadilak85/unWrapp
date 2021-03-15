import 'package:flutter/material.dart';
import 'package:unwrapp/helpers/app_theme.dart';

void showDialogmenu(context, _textboxmessage) {
  showGeneralDialog(
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 200),
    context: context,
    pageBuilder: (_, __, ___) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 300,
          child: SizedBox.expand(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Text(
                    _textboxmessage,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: AppTheme.subtitle.fontFamily,
                      fontSize: 18,
                      color: AppTheme.darkText,
                      fontWeight: FontWeight.w700,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  ),
                ],
              ),
            ),
          ),
          margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      return SlideTransition(
        position: Tween(begin: Offset(1, 0), end: Offset(0, 0)).animate(anim),
        child: child,
      );
    },
  );
}

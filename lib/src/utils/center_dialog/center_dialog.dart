import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';

class CenterDialog {
  static simpleCenterDialog(
    BuildContext context,
    String title,
    String content,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            title,
            style: const TextStyle(
              decoration: TextDecoration.none,
              fontFamily: AppTheme.fontFamily,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              fontSize: 18,
              height: 21 / 18,
              letterSpacing: 0.4,
              color: AppTheme.red,
            ),
          ),
          content: Text(
            content,
            style: const TextStyle(
              decoration: TextDecoration.none,
              fontFamily: AppTheme.fontFamily,
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.normal,
              fontSize: 18,
              height: 21 / 18,
              letterSpacing: 0.4,
              color: AppTheme.black,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                color: AppTheme.blue,
                child: const Center(
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: AppTheme.fontFamily,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: 18,
                      height: 21 / 18,
                      letterSpacing: 0.4,
                      color: AppTheme.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          title: Text(title),
          content: Text(content),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Center(
                child: Text("Ok"),
              ),
            )
          ],
        );
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CenterDialog {
  simpleCenterDialog(
    BuildContext context,
    String title,
    String content,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
         showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title:  Text(title),
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
      },
    );
  }
}

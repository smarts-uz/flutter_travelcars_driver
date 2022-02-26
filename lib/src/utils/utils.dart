import 'package:flutter/cupertino.dart';

class Utils{
  static double height(BuildContext context){
    return (MediaQuery.of(context).size.height / 926);
  }
  static double width(BuildContext context){
    return (MediaQuery.of(context).size.width / 428);
  }
}
import 'package:flutter/material.dart';

// ignore: camel_case_types
// making custom appbar
// ignore: camel_case_types
class customAppBar extends PreferredSize {
  final double height; //height of appbar
  final Widget child; // various elements or functionalities it will contain

// making a constructor class of customappbar
  customAppBar({this.height = kToolbarHeight, @required this.child});
  @override
  // ignore: todo
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.cyan[200], Colors.redAccent],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft),
        borderRadius: new BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0)),
      ),
      child: child,
    );
  }
}

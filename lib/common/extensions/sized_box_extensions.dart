import 'package:flutter/material.dart';

class Space {
  static SizedBox w(double width) => SizedBox(width: width);
  static SizedBox h(double height) => SizedBox(height: height);
  static SizedBox s(double size) => SizedBox(width: size, height: size);
}

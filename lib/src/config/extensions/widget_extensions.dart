import 'package:flutter/material.dart';

extension PaddingExtensions on Widget {
  Widget padding(EdgeInsets insets) {
    return Padding(
      padding: insets,
      child: this,
    );
  }
}
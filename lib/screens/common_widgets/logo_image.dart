import 'package:flutter/widgets.dart';

Center logoImage() {
  return Center(
    child: SizedBox(
      height: 300,
      width: 300,
      child: Image.asset("assets/images/logo.png"),
    ),
  );
}

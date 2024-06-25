import 'package:flutter/material.dart';

class DesktopView extends StatelessWidget {
  const DesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: const Center(
            child: Text(
              "Desktop view not supported\nTry again on your mobile device",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          )),
    );
  }
}

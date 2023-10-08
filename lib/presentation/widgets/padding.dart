import 'package:flutter/material.dart';

class MyPadding extends StatelessWidget {
  const MyPadding({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(padding: EdgeInsets.all(16));
  }
}

class MySmallPadding extends StatelessWidget {
  const MySmallPadding({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(padding: EdgeInsets.all(8));
  }
}

import 'package:flutter/material.dart';

abstract class DefinedText extends StatelessWidget {
  const DefinedText(this.text, {super.key, this.align = TextAlign.start});

  final String text;
  final TextAlign align;
}

class H1 extends DefinedText {
  const H1(super.text, {super.align, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.displayMedium, textAlign: align);
  }
}

class H2 extends DefinedText {
  const H2(super.text, {super.align, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.displaySmall, textAlign: align);
  }
}

class H3 extends DefinedText {
  const H3(super.text, {super.align, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.titleMedium, textAlign: align);
  }
}

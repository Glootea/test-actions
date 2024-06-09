import 'package:flutter/material.dart';

class InitableCubitScreenTemplate<T> extends StatelessWidget {
  const InitableCubitScreenTemplate({required this.future, required this.builder, super.key});
  final Future<T> future;
  final Widget Function(BuildContext context, AsyncSnapshot<T?> snapshot) builder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) => AnimatedCrossFade(
        crossFadeState: snapshot.data == null ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        duration: const Duration(milliseconds: 500),
        firstChild: const SizedBox(),
        secondChild: builder(context, snapshot),
        layoutBuilder: (topChild, topChildKey, bottomChild, bottomChildKey) => Stack(
          children: [const SizedBox(), topChild],
        ),
      ),
    );
  }
}

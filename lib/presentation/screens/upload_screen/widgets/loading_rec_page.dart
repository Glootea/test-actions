import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoadingRecPage extends StatelessWidget {
  const LoadingRecPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Загрузка записи", style: Theme.of(context).textTheme.headlineLarge),
        const Gap(64),
        const Align(
            child: SizedBox(
          height: 100,
          width: 100,
          child: CircularProgressIndicator(),
        )),
      ],
    );
  }
}

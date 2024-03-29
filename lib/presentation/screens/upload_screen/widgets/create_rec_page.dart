import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:queue/logic/states.dart';

class CreatedRecPage extends StatelessWidget {
  final UploadFromLinkState state;
  const CreatedRecPage(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      // TODO: show additional info like place in queue and previous person
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Спасибо за помощь!",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const Gap(64),
          Text(
            state.message ?? '',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          if (state.loadedPosition == false) const Gap(16),
          if (state.loadedPosition == false) const CircularProgressIndicator(),
        ],
      ),
    );
  }
}

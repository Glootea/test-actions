import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DialogFactory {
  static void showErrorDialog(BuildContext context, String errorMessage) {
    return WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Ошибка", style: Theme.of(context).textTheme.headlineMedium),
              content: Text(errorMessage),
              actions: [OutlinedButton(onPressed: () => context.pop(), child: const Text("OK"))],
            )));
  }
}

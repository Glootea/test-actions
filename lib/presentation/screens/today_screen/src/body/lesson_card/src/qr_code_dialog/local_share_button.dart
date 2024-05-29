import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LocalShareButton extends StatelessWidget {
  final String data;
  const LocalShareButton(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    const platform = MethodChannel('com.glootea.queueminder/share');
    return TextButton(
        onPressed: () async {
          try {
            final result = await platform.invokeMethod<String>('share', {"text": data}) ?? false;
            print(result);
          } catch (e) {
            debugPrint(e.toString());
          }
        },
        child: const Text("Поделиться"));
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LocalShareButton extends StatelessWidget {
  const LocalShareButton(this.data, {super.key});
  final String data;

  @override
  Widget build(BuildContext context) {
    const platform = MethodChannel('com.glootea.queueminder/share');
    return TextButton(
      onPressed: () async {
        try {
          final result = await platform.invokeMethod<String>('share', {'text': data}) ?? false;
          if (kDebugMode) {
            print(result);
          }
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      },
      child: const Text('Поделиться'),
    );
  }
}

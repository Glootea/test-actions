import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/domain/theme/theme_cubit.dart';

class ImagedBackground extends StatelessWidget {
  const ImagedBackground({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            final show = state.themePreset.backgroundImagePossible && state.showBackgroundImage;
            return AnimatedCrossFade(
              layoutBuilder: (topChild, topChildKey, bottomChild, bottomChildKey) => Stack(
                fit: StackFit.expand,
                children: [bottomChild, if (show) topChild],
              ),
              duration: const Duration(milliseconds: 300),
              crossFadeState: show ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              firstChild: CachedNetworkImage(
                repeat: ImageRepeat.repeat,
                errorWidget: (context, url, error) => ColoredBox(color: Theme.of(context).colorScheme.surface),
                imageUrl: state.themePreset.backgroundImagePath ?? '',
                errorListener: (value) {
                  if (kDebugMode) {
                    log('Failed to load background image: $value');
                  }
                },
              ),
              secondChild: Container(),
            );
          },
        ),
        child,
      ],
    );
  }
}

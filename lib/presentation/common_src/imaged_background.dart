import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImagedBackground extends StatelessWidget {
  const ImagedBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      repeat: ImageRepeat.repeat,
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/queueminder.appspot.com/o/themes%2Fblack%2Fpanda.png?alt=media&token=5300bcff-1e05-4175-83a8-731fcda7ce19",
    );
  }
}

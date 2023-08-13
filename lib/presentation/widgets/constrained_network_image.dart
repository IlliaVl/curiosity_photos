import 'package:flutter/material.dart';

/// Widget for displaying image with loading indicator.
/// If [imageWidth] or [imageHeight] is not provided,
/// then default layout in [Image.network] is used.
/// Otherwise image width constrained by [imageWidth]
/// and [AspectRatio] is used according to provided size.
class ConstrainedNetworkImage extends StatelessWidget {
  /// Image url.
  final String imageUrl;

  /// Image width.
  final int? imageWidth;

  /// Image height.
  final int? imageHeight;

  /// Creates new [ConstrainedNetworkImage]
  const ConstrainedNetworkImage({
    Key? key,
    required this.imageUrl,
    this.imageWidth,
    this.imageHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = Image.network(
      fit: BoxFit.fitHeight,
      imageUrl,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    );
    return imageWidth == null || imageHeight == null
        ? image
        : ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: imageWidth!.toDouble(),
            ),
            child: AspectRatio(
              aspectRatio: imageWidth! / imageHeight!,
              child: image,
            ),
          );
  }
}

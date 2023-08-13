import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';

import '../../domain/cubits/photos/mars_photos_cubit.dart';

/// Screen responsible for displaying details of Mars photo.
class PhotoDetailsScreen extends StatelessWidget {
  final int photoIndex;

  const PhotoDetailsScreen({
    super.key,
    required this.photoIndex,
  });

  @override
  Widget build(BuildContext context) {
    final marsPhoto =
        context.read<MarsPhotosCubit>().state.marsPhotos[photoIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('${marsPhoto.id}'),
      ),
      body: PhotoView(
        imageProvider: NetworkImage(
          marsPhoto.photoUrl,
        ),
      ),
    );
  }
}

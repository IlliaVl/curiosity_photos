import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/cubits/photos/mars_photos_cubit.dart';
import '../../domain/cubits/photos/mars_photos_state.dart';
import '../mixins/errors_snack_bar_mixin.dart';
import '../widgets/constrained_network_image.dart';

class MainScreen extends StatelessWidget with ErrorsSnackBarMixin {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.of(context).size.width.round();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Curiosity Photos'),
      ),
      body: BlocConsumer<MarsPhotosCubit, MarsPhotosState>(
        listener: (context, state) {
          if (!state.busy) {
            if (state.errorStatus == MarsPhotosErrorStatus.network) {
              showNetworkErrorSnackBar(context);
            } else if (state.errorStatus == MarsPhotosErrorStatus.generic) {
              showGenericErrorSnackBar(context);
            }
          }
        },
        builder: (context, state) {
          return state.busy
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : state.errorStatus != MarsPhotosErrorStatus.none
                  ? Center(
                      child: TextButton(
                        onPressed: context.read<MarsPhotosCubit>().load,
                        child: const Text('Retry'),
                      ),
                    )
                  : ListView.builder(
                      itemCount: state.marsPhotos.length,
                      itemBuilder: (context, index) => ConstrainedNetworkImage(
                        imageWidth: imageSize,
                        imageHeight: imageSize,
                        imageUrl: state.marsPhotos[index].photoUrl,
                      ),
                    );
        },
      ),
    );
  }
}

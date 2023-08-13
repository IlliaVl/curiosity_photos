import 'package:flutter_bloc/flutter_bloc.dart';

import '../../abstracts/repositories/mars_photos_repository_interface.dart';
import '../../exceptions/curiosity_exception.dart';
import 'mars_photos_state.dart';

/// A cubit that keeps the list of photos.
class MarsPhotosCubit extends Cubit<MarsPhotosState> {
  final MarsPhotosRepositoryInterface _repository;

  /// Creates a new cubit using the supplied `repository`
  MarsPhotosCubit({
    required MarsPhotosRepositoryInterface repository,
    String? customerID,
  })  : _repository = repository,
        super(MarsPhotosState());

  /// Loads a list of photos.
  Future<void> load() async {
    emit(
      state.copyWith(
        busy: true,
        errorStatus: MarsPhotosErrorStatus.none,
      ),
    );

    try {
      final photos = await _repository.getPhotos();

      emit(
        state.copyWith(
          marsPhotos: photos,
          busy: false,
        ),
      );
    } on CuriosityException catch (e) {
      switch (e.errorType) {
        case CuriosityExceptionType.network:
          emit(
            state.copyWith(
              busy: false,
              errorStatus: MarsPhotosErrorStatus.network,
            ),
          );
        default:
          emit(
            state.copyWith(
              busy: false,
              errorStatus: MarsPhotosErrorStatus.generic,
            ),
          );
      }
    } on Exception catch (e) {
      emit(
        state.copyWith(
          busy: false,
          errorStatus: MarsPhotosErrorStatus.generic,
        ),
      );
    }
  }
}

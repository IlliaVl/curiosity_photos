import 'package:bloc_test/bloc_test.dart';
import 'package:curiosity_photos/domain/abstracts/repositories/mars_photos_repository_interface.dart';
import 'package:curiosity_photos/domain/cubits/photos/mars_photos_cubit.dart';
import 'package:curiosity_photos/domain/cubits/photos/mars_photos_state.dart';
import 'package:curiosity_photos/domain/models/mars_photo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPhotosRepository extends Mock
    implements MarsPhotosRepositoryInterface {}

void main() {
  const photosLength = 99;

  final photos = List.generate(
    photosLength,
    (index) => MarsPhoto(
      id: index,
      photoUrl: 'url_$index',
    ),
  );

  final repository = MockPhotosRepository();

  late MarsPhotosCubit cubit;

  setUp(
    () {
      cubit = MarsPhotosCubit(repository: repository);

      when(
        repository.getPhotos,
      ).thenAnswer(
        (_) async => photos,
      );
    },
  );

  blocTest<MarsPhotosCubit, MarsPhotosState>(
    'Starts with empty state',
    build: () => cubit,
    verify: (c) => expect(
      c.state,
      MarsPhotosState(),
    ),
  );

  blocTest<MarsPhotosCubit, MarsPhotosState>(
    'Loads photos, '
    'emits state with loaded photos',
    build: () => cubit,
    act: (c) => c.load(),
    expect: () => [
      MarsPhotosState(busy: true),
      MarsPhotosState(
        marsPhotos: photos,
        busy: false,
      )
    ],
    verify: (c) {
      verify(
        repository.getPhotos,
      ).called(1);
    },
  );

  blocTest<MarsPhotosCubit, MarsPhotosState>(
    'Handles exceptions gracefully',
    setUp: () {
      /// Test case that throws Exception
      when(
        repository.getPhotos,
      ).thenAnswer(
        (_) async => throw Exception('Some Error'),
      );
    },
    build: () => cubit,
    act: (c) => c.load(),
    expect: () => [
      MarsPhotosState(busy: true),
      MarsPhotosState(
        busy: false,
        errorStatus: MarsPhotosErrorStatus.generic,
      )
    ],
    verify: (c) {
      verify(
        repository.getPhotos,
      ).called(1);
    },
  );
}

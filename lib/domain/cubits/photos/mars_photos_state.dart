import 'dart:collection';

import 'package:equatable/equatable.dart';

import '../../models/mars_photo.dart';

/// The state of the [PhotosCubit].
class MarsPhotosState extends Equatable {
  /// A list of photos.
  final UnmodifiableListView<MarsPhoto> marsPhotos;

  /// The current error status.
  final MarsPhotosErrorStatus errorStatus;

  /// True if the cubit is processing something.
  final bool busy;

  /// Creates a new [MarsPhotosState].
  MarsPhotosState({
    Iterable<MarsPhoto> marsPhotos = const <MarsPhoto>[],
    this.errorStatus = MarsPhotosErrorStatus.none,
    this.busy = false,
  }) : marsPhotos = UnmodifiableListView(marsPhotos);

  @override
  List<Object?> get props => [
        marsPhotos,
        errorStatus,
        busy,
      ];

  /// Creates a new state based on this one.
  MarsPhotosState copyWith({
    List<MarsPhoto>? marsPhotos,
    MarsPhotosErrorStatus? errorStatus,
    bool? busy,
  }) =>
      MarsPhotosState(
        marsPhotos: marsPhotos ?? this.marsPhotos,
        errorStatus: errorStatus ?? this.errorStatus,
        busy: busy ?? this.busy,
      );
}

/// The available error status.
enum MarsPhotosErrorStatus {
  /// No errors.
  none,

  /// Generic error.
  generic,

  /// Network error.
  network,
}

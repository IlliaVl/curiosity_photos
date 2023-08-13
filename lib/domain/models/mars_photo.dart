/// Model representing a Mars photo.
class MarsPhoto {
  /// ID of the Mars photo.
  final int id;

  /// Url of the Mars photo.
  final String photoUrl;

  /// Creates new [MarsPhoto]
  MarsPhoto({
    required this.id,
    required this.photoUrl,
  });
}

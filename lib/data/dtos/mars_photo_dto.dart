/// Data transfer object that represents a Mars photo.
class MarsPhotoDTO {
  /// ID of the Mars photo.
  final int id;

  /// Source url of the Mars photo.
  final String imgSrc;

  /// Creates new [MarsPhotoDTO]
  MarsPhotoDTO({
    required this.id,
    required this.imgSrc,
  });

  /// Creates a [MarsPhotoDTO] from a json.
  factory MarsPhotoDTO.fromJson(Map<String, dynamic> json) => MarsPhotoDTO(
        id: json['id'],
        imgSrc: json['img_src'],
      );

  /// Creates a [MarsPhotoDTO]s from a list of json maps.
  static List<MarsPhotoDTO> fromJsonList(List<Map<String, dynamic>> json) =>
      json.map(MarsPhotoDTO.fromJson).toList();
}

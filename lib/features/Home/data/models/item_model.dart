class ItemModel {
  final int? id;
  final String? name;
  final String? imageUrl;
  final String? availability;
  ItemModel({
    required this.id,
    required this.name,
    required this.availability,
    required this.imageUrl,
  });
  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json["id"],
      name: json["name"],
      availability: json["availability"],
      imageUrl: json["image_url"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "availability": availability,
      "image": imageUrl,
    };
  }
}

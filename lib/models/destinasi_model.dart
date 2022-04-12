class DestinasiModel {
  static const tblFavorite = 'Favorites';
  static const colId = 'id';
  static const colName = 'name';
  static const colImage = 'image';
  static const colRating = 'rating';
  static const colWeekday = 'weekday_text';
  static const colKategoriRisk = 'kategori_risk';
  static const colCity = 'city';

  int id;
  String name;
  String image;
  String rating;
  String weekday;
  String kategoriRisk;
  String city;

  DestinasiModel({
    this.id,
    this.image,
    this.kategoriRisk,
    this.name,
    this.rating,
    this.weekday,
    this.city,
  });

  DestinasiModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    rating = json['rating'];
    weekday = json['weekday_text'] ?? "8:00 AM - 9:00 PM";
    kategoriRisk = json['kategori_risk'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'rating': rating,
      'weekday_text': weekday,
      'kategori_risk': kategoriRisk,
      'city': city,
    };
  }
}

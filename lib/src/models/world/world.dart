class World{
  int? id;
  String? capital;
  String? country;

  World(this.capital,this.country);

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      "capital": capital,
      "country": country,
    };
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  World.fromMap(Map<String, Object?> map) {
    id = (map["id"] as int?)!;
    capital = (map["capital"] as String?)!;
    country = (map["country"] as String?)!;
  }


  World.fromJson(Map<String, dynamic> json) {
    capital = json['capital'];
    country = json['country'];
  }

}